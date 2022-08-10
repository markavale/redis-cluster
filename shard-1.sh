#! bin/bash
echo "Start Shard 1 conf"

redis_folder="/opt/redis-6.2.6/"
if [ -d "$redis_folder" ]

then
    echo "Folder already existing..." 

else

    echo "Folder does not exist. Creating instead..."
    cd /opt
    sudo wget https://download.redis.io/releases/redis-6.2.6.tar.gz
    expect "Password"
    send "@linux121598"
fi
    