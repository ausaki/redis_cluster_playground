N=$1
name=redis_$N

if [ ! -d $name ];then
    mkdir $name
fi

if [ ! -d $name/data ];then
    mkdir $name/data
fi

if [ ! -f $name/redis.conf ];then
    cp redis.conf $name/redis.conf

fi

docker run -d --rm --name $name --mount type=bind,source=$PWD/$name/redis.conf,target=/etc/redis/redis.conf \
--mount type=bind,source=$PWD/$name/data,target=/data --hostname $name \
--network redis_cluster_test_redis_cluster --ip "192.168.100.$((100 + $N))" redis "/etc/redis/redis.conf"
