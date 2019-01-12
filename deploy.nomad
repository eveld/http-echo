job "http-echo" {
  datacenters = ["dc1"]
  type = "service"

  update {
    max_parallel = 1
    min_healthy_time = "10s"
    healthy_deadline = "3m"
    progress_deadline = "10m"
    auto_revert = false
    canary = 0
  }

  migrate {
    max_parallel = 1
    health_check = "checks"
    min_healthy_time = "10s"
    healthy_deadline = "5m"
  }

  group "group" {
    count = 1

    restart {
      attempts = 2
      interval = "30m"
      delay = "15s"
      mode = "fail"
    }

    ephemeral_disk {
      size = 300
    }

    task "task" {
      driver = "docker"

      config {
        image = "${image}"
        
        port_map {
          http = 80
        }

        auth {
          server_address = "gcr.io"
        }
      }

      resources {
        cpu    = 100
        memory = 64
        network {
          mbits = 10
          port "http" {}
        }
      }

      service {
        name = "http-echo"
        tags = ["http", "echo"]
        port = "http"
        check {
          name     = "alive"
          type     = "tcp"
          interval = "10s"
          timeout  = "2s"
        }
      }
    }
  }
}