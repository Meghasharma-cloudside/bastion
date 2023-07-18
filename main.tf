resource "google_compute_instance" "default" {
  name         = "test"
  machine_type = "e2-medium"
  zone         = "us-central1-a"
  project      = "xyz"
  deletion_protection = "disable"

  labels = "inst"

  tags = ["foo", "bar"]

boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
      size  =  10 GB
      labels = {
        my_label = "value"
      }
    }
  }

  network_interface {
    network = "default"
    //subnetwork = ""

    //access_config {
      // Ephemeral public IP
    //}
  }

  scheduling {
    on_host_maintenance = "MIGRATE"
    min_node_cpus       = 2
    automatic_restart   = "true"
    preemptible         = "false"
  }

  metadata = {
    foo = "bar"
  }

  metadata_startup_script = "echo hi > /test.txt"

  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = google_service_account.default.email
    scopes = ["cloud-platform"]
  }
}