Redis setup template

git clone https://key@github.com/markavale/redis-cluster

1 -----
wget https://download.redis.io/releases/redis-6.2.6.tar.gz
tar -zxvf redis-6.2.6.tar.gz
1.5 ----
sudo apt-get install build-essential  -Y
wget http://www.cmake.org/files/v3.0/cmake-3.0.0.tar.gz
tar -zxvf cmake-3.0.0.tar.gz
cd cmake-3.0.0
./boostrap
gmake
sudo gmake install
# then check if already installed
cmake --version
cmake version 3.0.0
2 -----
cd redis-6-2-6/
sudo make install PREFIX=/usr/local/redis

3 -----
sudo mkdir /etc/redis_0/
sudo cp ~/redis-cluster/7000/redis.conf /etc/redis_0/redis.conf
4 -----

sudo mkdir /var/lib/redis_1

sudo nano /etc/systemd/system/redis_0.service



[Unit]
Description=redis-server
After=network.target

[Service]
Type=forking
ExecStart=/usr/local/redis/bin/redis-server /etc/redis_0/redis.conf
PrivateTmp=true
ExecStop=/usr/local/redis/bin/redis-cli shutdown
Restart=always

[Install]
WantedBy=multi-user.target

5 -----
sudo systemctl daemon-reload
# to start redis service
sudo service redis_0 start

# to stop redis service
sudo service redis stop

# to check redis service status
sudo service redis status​

sudo systemctl enable redis​
or
sudo systemd-escape enable redis​

6 -----
# create redis user and group
sudo adduser --system --group --no-create-home redis

# make redis home dir
sudo mkdir /var/lib/redis

# update file permissions
sudo chown redis:redis /var/lib/redis

# prevent regular users
sudo chmod 770 /var/lib/redis​


How to test if redis server is installed correctly?

Once you followed above steps and installed redis correctly try following command to test if installation process went smoth and you get response back from redis:

# switch to redis cli mode
$ redis-cli

# send ping request
127.0.0.1:6379> ping

# you will see following output
PONG

# exit the server
127.0.0.1:6379> exit​



sudo redis-cli --cluster create 192.168.3.215:7000 192.168.3.215:7001 192.168.3.216:7002 192.168.3.216:7003 192.168.3.217:7004 192.168.3.217:7005 --cluster-replicas 1

sudo redis-cli --cluster create 10.243.134.182:7000 10.243.134.182:7001 10.243.134.238:7002 10.243.134.238:7003 10.243.134.92:7004 10.243.134.92:7005 --cluster-replicas 1


netstat -plan | grep 7000


*---------------------------------------------*
Adding a new node as a replica

Adding a new Replica can be performed in two ways. The obvious one is to use redis-cli again, but with the --cluster-slave option, like this:

redis-cli --cluster add-node 127.0.0.1:7006 127.0.0.1:7000 --cluster-slave
*---------------------------------------------*
However you can specify exactly what master you want to target with your new replica with the following command line:

redis-cli --cluster add-node 127.0.0.1:7006 127.0.0.1:7000 --cluster-slave --cluster-master-id 3c3a0c74aae0b56170ccb03a76b60cfe7dc1912e

*---------------------------------------------*
Removing a node

To remove a replica node just use the del-node command of redis-cli:

redis-cli --cluster del-node 127.0.0.1:7000 `<node-id>`

*---------------------------------------------*
Adding a new node as a replica

Adding a new Replica can be performed in two ways. The obvious one is to use redis-cli again, but with the --cluster-slave option, like this:

redis-cli --cluster add-node 127.0.0.1:7006 127.0.0.1:7000 --cluster-slave

Note that the command line here is exactly like the one we used to add a new master, so we are not specifying to which master we want to add the replica. In this case what happens is that redis-cli will add the new node as replica of a random master among the masters with fewer replicas.

However you can specify exactly what master you want to target with your new replica with the following command line:

redis-cli --cluster add-node 127.0.0.1:7006 127.0.0.1:7000 --cluster-slave --cluster-master-id 3c3a0c74aae0b56170ccb03a76b60cfe7dc1912e




