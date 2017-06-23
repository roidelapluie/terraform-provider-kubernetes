resource "kubernetes_pod" "master" {
  metadata {
    name = "redis-master"
    labels {
      name = "redis"
      redis-sentinel = "true"
      role = "master"
    }
  }

  spec {
    container {
      image = "gcr.io/google_containers/redis:v1"
      name  = "master"

      env {
        name = "MASTER"
        value = "true"
      }

      port {
        container_port = 6379
      }

      resources {
        limits {
          cpu = "0.1"
        }
      }

      volume_mount {
        name = "data"
        mount_path = "/redis-master-data"
      }
    }

    container {
      image = "kubernetes/redis:v1"
      name  = "sentinel"

      env {
        name = "SENTINEL"
        value = "true"
      }

      port {
        container_port = 26379
      }
    }

    volume {
      name = "data"
      empty_dir { }
    }
  }
}
