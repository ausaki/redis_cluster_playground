NUM_REDIS=6

redis_instances=""
start_address=100

for i in $(seq $NUM_REDIS);do
    redis_instances="$redis_instances 192.168.100.$(($start_address + $i)):6379"
done

docker-compose exec redis_1 redis-cli --cluster create $redis_instances --cluster-replicas 1 

