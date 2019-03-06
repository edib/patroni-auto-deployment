# confd installation guide
[confd](https://github.com/kelseyhightower/confd) is a lightweight configuration management tool. Using this tool we can change the master ip automatically in pgbouncer without intervention whenever the master changes.

* download binary from [github](https://github.com/kelseyhightower/confd/releases)
* copy it as /usr/bin/confd
* download [patroni github repo](https://github.com/zalando/patroni.git) and copy patroni extras/confd to /etc/confd/confd
* create a default configuration file in /etc/confd/confd.toml

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

* reconfigure pgbouncer.tmpl file that is in /etc/confd/templates/ accordingly.
* create a service file confd.service and copy it in /lib/systemd/system/ and enable it
* start confd service
* restsart pgbouncer service
