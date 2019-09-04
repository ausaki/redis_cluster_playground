# Redis Cluster Tutorial

原文链接：[https://redis.io/topics/cluster-tutorial](https://redis.io/topics/cluster-tutorial)



## 分区方案

Redis Cluster采取的分区方案是hash slot，总的有16384个slot。Redis Cluster支持多个主节点和从节点。

计算key属于哪个slot的方法：CRC16(key) % 16384。

在Redis Cluster中，每个主节点存储hash slot的一个子集，加起来等于16384。

添加节点只需要从现有节点迁移一部分key到新节点。删除节点则需要将节点的key迁移到其它节点。
添加节点和删除节点不需要停止服务。

Redis Cluster支持一条命令（或者事务和Lua脚本）包含多个key，前提是这些key具有相同的hash slot。Redis Cluster提供一种叫做hash tag的技术，使得不同的key具有相同的hash slot。hash tag指的是key中包含形如`{hash tag}`的字符串，如果遇到hash tag字符串，Redis只会使用括号之内的字符串计算hash slot。

## 创建测试环境

使用 Docker 创建一个可以用来测试的 Redis Cluster 环境。步骤如下：

- 运行 `init.sh` 脚本初始化环境。例如创建 docker-compose.yml 配置文件和 redis 配置文件。

- 运行 `docker-compose up` 命令启动多个 Redis 容器。

- 运行 `create_cluster.sh` 创建 Redis Cluster。

- 运行 `redis-cli` 进入容器内的 redis-cli。


Redis Cluster 包括 6 个 Redis 实例，3 个 master，3 个 slave。

1 号实例叫做 redis_1，IP 地址是 192.168.100.101,2 号实例叫做 redis_2，IP 地址是 192.168.100.102，其余实例以此类推。




