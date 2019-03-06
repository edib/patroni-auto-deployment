# confd manual installation guide
[confd](https://github.com/kelseyhightower/confd) is a lightweight configuration management tool. Using this tool we can change the master ip automatically in pgbouncer without intervention whenever the master changes.

* download binary from [github](https://github.com/kelseyhightower/confd/releases). v0.16.0 is used here.
```
wget https://github.com/kelseyhightower/confd/releases/download/v0.16.0/confd-0.16.0-linux-amd64
```
* Move it to /usr/bin/confd
```
mv confd-0.16.0-linux-amd64 /usr/bin/confd
chmod +x /usr/bin/confd
```
* download [patroni github repo](https://github.com/zalando/patroni.git) and copy patroni extras/confd to /etc/confd. We only use pgbouncer template here then delete the haproxy template.
```
git clone https://github.com/zalando/patroni.git
cp -r patroni/extras/confd /etc/confd
rm /etc/confd/conf.d/haproxy.toml
rm /etc/confd/templates/haproxy.tmpl
```
* create a default configuration file in /etc/confd/confd.toml. Put the content and etcd nodes information.
```
#backend = "etcd"
#client_cert = "/etc/confd/ssl/client.crt"
#client_key = "/etc/confd/ssl/client.key"
#confdir = "/etc/confd"
#log-level = "debug"
interval = 10
nodes = [
  "http://10.0.0.11:2379",
  "http://10.0.0.12:2379",
  "http://10.0.0.13:2379"
]
#noop = false
prefix = "/db/postgres"
#scheme = "https"
#srv_domain = "etcd.example.com"
```

* Reconfigure pgbouncer.tmpl file that is in /etc/confd/templates/ accordingly. The file in templates is the template for the real pgbouncer file. Always make the necessary changes in this file otherwise it will be owerritten.
* create a service file confd.service and copy it in /lib/systemd/system/.

`content of confd.service`

```
[Unit]
Description=confd
After=syslog.target
After=network.target

[Service]
Type=simple
ExecStart=/usr/bin/confd
KillSignal=SIGINT
Restart=always
RestartSec=10
ExecReload=/bin/kill -s HUP $MAINPID

[Install]
WantedBy=multi-user.target
```

* Enable the confd service and start it.
```
systemctl enable confd
systemctl start confd
```
* Create and change pgbouncer's required files and restsart pgbouncer service.
```
systemctl restart pgbouncerred
```
