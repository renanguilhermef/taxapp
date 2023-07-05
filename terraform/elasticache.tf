resource "aws_elasticache_subnet_group" "taxapp-redis" {
  name       = "taxapp-redis-subnet"
  subnet_ids = [aws_subnet.db-private-1a.id, aws_subnet.db-private-1b.id, aws_subnet.db-private-1c.id]
}

resource "aws_elasticache_replication_group" "taxapp-redis" {
  replication_group_id       = "taxapp-redis-group"
  description                = "Taxapp Redis group"
  node_type                  = "cache.r6g.large"
  port                       = 6379
  parameter_group_name       = "default.redis7.cluster.on"
  subnet_group_name          = aws_elasticache_subnet_group.taxapp-redis.name
  automatic_failover_enabled = true
  multi_az_enabled           = false
  replicas_per_node_group    = 0
  num_node_groups            = 3
}