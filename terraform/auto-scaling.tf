resource "aws_autoscaling_group" "taxapp-api" {
  name     = "taxapp-api-asg-group"
  min_size = 3
  max_size = 30

  health_check_type   = "EC2"
  vpc_zone_identifier = [aws_subnet.api-private-1a.id, aws_subnet.api-private-1b.id, aws_subnet.api-private-1c.id]
  target_group_arns   = [aws_lb_target_group.taxapp.arn]

  mixed_instances_policy {
    launch_template {
      launch_template_specification {
        launch_template_id = aws_launch_template.taxapp-api.id
      }
      override {
        instance_type = "t2.large"
      }
    }
  }
}

resource "aws_autoscaling_policy" "taxapp-api" {
  name                   = "taxapp-api-asg-policy"
  policy_type            = "TargetTrackingScaling"
  autoscaling_group_name = aws_autoscaling_group.taxapp-api.name

  estimated_instance_warmup = 15

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }

    target_value = 75.0
  }
}

resource "aws_appautoscaling_target" "taxapp-redis" {
  service_namespace  = "elasticache"
  scalable_dimension = "elasticache:replication-group:NodeGroups"
  resource_id        = "replication-group/${aws_elasticache_replication_group.taxapp-redis.id}"
  min_capacity       = 3
  max_capacity       = 30
}

resource "aws_appautoscaling_policy" "taxapp-redis" {
  name               = "cpu-auto-scaling"
  service_namespace  = aws_appautoscaling_target.taxapp-redis.service_namespace
  scalable_dimension = aws_appautoscaling_target.taxapp-redis.scalable_dimension
  resource_id        = aws_appautoscaling_target.taxapp-redis.resource_id
  policy_type        = "TargetTrackingScaling"

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ElastiCachePrimaryEngineCPUUtilization"
    }

    target_value = 70.0
  }
}