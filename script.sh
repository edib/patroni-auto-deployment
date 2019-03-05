# postgres install
echo "deb http://apt.postgresql.org/pub/repos/apt/ bionic-pgdg main" | sudo tee --append /etc/apt/sources.list.d/pgdg.list
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
sudo apt-get update
sudo apt-get install postgresql-11 python3-pip etcd -y
# postgresql must be managed my patroni. disable service
sudo systemctl disable postgresql
sudo systemctl stop postgresql

# install patroni
sudo pip3 install patroni python-etcd psycopg2-binary
  # dizine patroniyi ekleyecek.
