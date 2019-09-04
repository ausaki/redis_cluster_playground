NUM_REDIS=6
START_ADDR=100

exec 1>docker-compose.yml

echo -e "version: \"3\"\nservices:" 

for i in $(seq $NUM_REDIS);do
    name=redis_$i
    if [ ! -d "$name" ];then 
        mkdir "$name"
    fi
    if [ ! -d "$name/data" ];then
        mkdir "$name/data"
    fi
    if [ ! -f "$name/redis.conf" ];then
        cp redis.conf "$name/redis.conf"
    fi

    cat <<-EOF | sed -e 's/^  //'
    $name:
      image: redis
      volumes:
        - "./$name/redis.conf:/etc/redis/redis.conf"
        - "./$name/data:/data"
      container_name: $name
      hostname: $name
      networks:
        redis_cluster:
          ipv4_address: "192.168.100.$(($START_ADDR + $i))"
      command: "/etc/redis/redis.conf"
EOF
done

cat <<-EOF
networks:
  redis_cluster:
    ipam:
      config:
        - subnet: "192.168.100.0/24"
EOF
