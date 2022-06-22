Redis setup template

git clone https://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@github.com/markavale/redis-cluster

1 -----
wget https://download.redis.io/releases/redis-6.2.6.tar.gz
tar -zxvf redis-6.2.6.tar.gz
2 -----
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


netstat -plan | grep 7000







