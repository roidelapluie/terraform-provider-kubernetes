resource "kubernetes_service" "sentinel" {
  metadata {
    name = "redis-sentinel"
    labels {
      name = "sentinel"
      role = "service"
    }
  }
  spec {
    selector {
      redis-sentinel = "true"
    }
    port {
      port = 26379
      target_port = 26379
    }
  }
}

output "lb_ip" {
  value = "${kubernetes_service.sentinel.load_balancer_ingress.0.ip}"
}
