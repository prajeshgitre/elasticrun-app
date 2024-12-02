##############################Service Account Token Details#################################
project = {
  name            = "prj-seed-elasticrun",
  service_account = "sa-terraform-app@prj-seed-elasticrun.iam.gserviceaccount.com"
}


list_of_gke = [
  {
    project_service        = "prj-prod-svc-elasticrun-01-94"
    project_host           = "prj-prod-int-elasticrun-hostc9"
    region                 = "asia-south2"
    zone                   = "asia-south2-a"
    regional               = false
    disable_default_snat   = false
    service_account        = "sa-er-prod-as2-gke-eng-cluster@prj-prod-svc-elasticrun-01-94.iam.gserviceaccount.com"
    cluster_name           = "gke-internal-prod-as2-eng-cluster"
    network_project_id     = "prj-prod-int-elasticrun-hostc9"
    network                = "vpc-elasticrun-prod-as2-shared"
    subnetwork             = "sb-prod-as2-k8s-eng-01"
    ip_range_pods          = "sb-prod-as2-k8s-eng-pod"
    ip_range_services      = "sb-prod-as2-k8s-eng-svc"
    master_ipv4_cidr_block = "172.20.52.0/28"
    node_disk_type         = "pd-ssd"
    node_image_type        = "ubuntu_containerd"
    cluster_resource_labels = {
      "environment" : "prod"

    },
    http_load_balancing                  = true
    network_policy                       = false
    enable_intranode_visibility          = false
    filestore_csi_driver                 = false
    enable_private_endpoint              = true
    enable_private_nodes                 = true
    master_global_access_enabled         = false
    enable_vertical_pod_autoscaling      = true
    remove_default_node_pool             = true
    create_service_account               = false
    spot                                 = false
    enable_gcfs                          = false
    enable_gvnic                         = false
    auto_repair                          = true
    auto_upgrade                         = true
    preemptible                          = false
    configure_ip_masq                    = false
    database_encryption                  = []
    state                                = "ENCRYPTED"
    enable_binary_authorization          = true
    enable_network_egress_export         = false
    enable_resource_consumption_export   = false
    ip_masq_link_local                   = false
    ip_masq_resync_interval              = ""
    logging_service                      = null
    enable_shielded_nodes                = true
    release_channel                      = "STABLE"
    master_version                       = "1.30.5-gke.1014003"
    maintenance_start_time               = "2024-01-01T00:00:00Z"
    maintenance_end_time                 = "2024-01-02T08:00:00Z"
    maintenance_recurrence               = "FREQ=WEEKLY;BYDAY=TH"
    authenticator_security_group         = null
    default_max_pods_per_node            = 50
    monitoring_enable_managed_prometheus = false
    master_authorized_networks = [
      {
        cidr_block   = "172.20.28.2/32",
        display_name = "jumpost-01"
      },
    ]
    monitoring_service               = null
    non_masquerade_cidrs             = []
    upstream_nameservers             = []
    resource_usage_export_dataset_id = ""
    secrets_encryption_kms_key       = ""
    node_pools_oauth_scopes = {
      all = ["https://www.googleapis.com/auth/cloud-platform"]
    }
    node_pools_labels = {
      all = {}

      default-node-pool = {
        default-node-pool = false
      }
    }
    node_pools_metadata = {
      all               = {}
      default-node-pool = {}
    }

    node_pools_taints = {
      all = []
    }

    node_pools_tags = {
      all               = ["ssh"]
      default-node-pool = []
    }

    node_pools = [
      {
        name                        = "gke-node-pool-internal-prod-eng-mon"
        node_pool_version           = "1.30.5-gke.1014003"
        machine_type                = "n2d-highmem-4"
        node_locations              = "asia-south2-a"
        total_max_count             = 10
        total_min_count             = 1
        local_ssd_count             = 0
        spot                        = true
        disk_size_gb                = 64
        disk_type                   = "pd-ssd"
        image_type                  = "ubuntu_containerd"
        node_count                  = 1
        enable_gcfs                 = false
        enable_gvnic                = false
        auto_repair                 = true
        auto_upgrade                = true
        service_account             = "sa-er-prod-as2-gke-eng-node-01@prj-prod-svc-elasticrun-01-94.iam.gserviceaccount.com"
        preemptible                 = false
        initial_node_count          = 1
        enable_secure_boot          = true
        enable_integrity_monitoring = true
        boot_disk_kms_key           = ""
      },
      {
        name                        = "gke-node-pool-internal-prod-eng-app"
        node_pool_version           = "1.30.5-gke.1014003"
        machine_type                = "n2d-highmem-2"
        node_locations              = "asia-south2-a"
        total_max_count             = 10
        total_min_count             = 1
        local_ssd_count             = 0
        spot                        = true
        disk_size_gb                = 64
        disk_type                   = "pd-ssd"
        image_type                  = "ubuntu_containerd"
        node_count                  = 1
        enable_gcfs                 = false
        enable_gvnic                = false
        auto_repair                 = true
        auto_upgrade                = true
        service_account             = "sa-er-prod-as2-gke-eng-node-02@prj-prod-svc-elasticrun-01-94.iam.gserviceaccount.com"
        preemptible                 = false
        initial_node_count          = 1
        enable_secure_boot          = true
        enable_integrity_monitoring = true
        boot_disk_kms_key           = ""
      },
      {
        name                        = "gke-node-pool-internal-prod-eng-sys"
        node_pool_version           = "1.30.5-gke.1014003"
        machine_type                = "n2d-highmem-2"
        node_locations              = "asia-south2-a"
        total_max_count             = 10
        total_min_count             = 1
        local_ssd_count             = 0
        spot                        = false
        disk_size_gb                = 64
        disk_type                   = "pd-ssd"
        image_type                  = "ubuntu_containerd"
        node_count                  = 1
        enable_gcfs                 = false
        enable_gvnic                = false
        auto_repair                 = true
        auto_upgrade                = true
        service_account             = "sa-er-prod-as2-gke-eng-node-03@prj-prod-svc-elasticrun-01-94.iam.gserviceaccount.com"
        preemptible                 = false
        initial_node_count          = 1
        enable_secure_boot          = true
        enable_integrity_monitoring = true
        boot_disk_kms_key           = ""
      },
    ]
  },

  #list_of_gke-2 = [
  {
    project_service        = "prj-prod-svc-elasticrun-01-94"
    project_host           = "prj-prod-int-elasticrun-hostc9"
    region                 = "asia-south2"
    zone                   = "asia-south2-a"
    regional               = false
    disable_default_snat   = false
    service_account        = "ssa-er-prod-as2-gke-app-cluster@prj-prod-svc-elasticrun-01-94.iam.gserviceaccount.com"
    cluster_name           = "gke-internal-prod-as2-app-cluster"
    network_project_id     = "prj-prod-int-elasticrun-hostc9"
    network                = "vpc-elasticrun-prod-as2-shared"
    subnetwork             = "sb-prod-as2-k8s-app-01"
    ip_range_pods          = "sb-prod-as2-k8-app-pod"
    ip_range_services      = "sb-prod-as2-k8-app-svc"
    master_ipv4_cidr_block = "172.20.24.0/28"
    node_disk_type         = "pd-ssd"
    node_image_type        = "ubuntu_containerd"
    cluster_resource_labels = {
      "environment" : "prod"

    },
    http_load_balancing                  = true
    network_policy                       = false
    enable_intranode_visibility          = false
    filestore_csi_driver                 = false
    enable_private_endpoint              = true
    enable_private_nodes                 = true
    master_global_access_enabled         = false
    enable_vertical_pod_autoscaling      = true
    remove_default_node_pool             = true
    create_service_account               = false
    spot                                 = false
    enable_gcfs                          = false
    enable_gvnic                         = false
    auto_repair                          = true
    auto_upgrade                         = true
    preemptible                          = false
    configure_ip_masq                    = false
    database_encryption                  = []
    state                                = "ENCRYPTED"
    enable_binary_authorization          = true
    enable_network_egress_export         = false
    enable_resource_consumption_export   = false
    ip_masq_link_local                   = false
    ip_masq_resync_interval              = ""
    logging_service                      = null
    enable_shielded_nodes                = true
    release_channel                      = "STABLE"
    master_version                       = "1.30.5-gke.1014003"
    maintenance_start_time               = "2024-01-01T00:00:00Z"
    maintenance_end_time                 = "2024-01-02T08:00:00Z"
    maintenance_recurrence               = "FREQ=WEEKLY;BYDAY=TH"
    authenticator_security_group         = null
    default_max_pods_per_node            = 50
    monitoring_enable_managed_prometheus = false
    master_authorized_networks = [
      {
        cidr_block   = "172.20.28.2/32",
        display_name = "jumpost-01"
      },
    ]
    monitoring_service               = null
    non_masquerade_cidrs             = []
    upstream_nameservers             = []
    resource_usage_export_dataset_id = ""
    secrets_encryption_kms_key       = ""
    node_pools_oauth_scopes = {
      all = ["https://www.googleapis.com/auth/cloud-platform"]
    }
    node_pools_labels = {
      all = {}

      default-node-pool = {
        default-node-pool = false
      }
    }
    node_pools_metadata = {
      all               = {}
      default-node-pool = {}
    }

    node_pools_taints = {
      all = []
    }

    node_pools_tags = {
      all               = ["ssh"]
      default-node-pool = []
    }

    node_pools = [
      {
        name                        = "gke-node-pool-internal-prod-app-mon"
        node_pool_version           = "1.30.5-gke.1014003"
        machine_type                = "n2d-highmem-4"
        node_locations              = "asia-south2-a"
        total_max_count             = 10
        total_min_count             = 1
        local_ssd_count             = 0
        spot                        = true
        disk_size_gb                = 64
        disk_type                   = "pd-ssd"
        image_type                  = "ubuntu_containerd"
        node_count                  = 1
        enable_gcfs                 = false
        enable_gvnic                = false
        auto_repair                 = true
        auto_upgrade                = true
        service_account             = "sa-er-prod-as2-gke-app-node-01@prj-prod-svc-elasticrun-01-94.iam.gserviceaccount.com"
        preemptible                 = false
        initial_node_count          = 1
        enable_secure_boot          = true
        enable_integrity_monitoring = true
        boot_disk_kms_key           = ""
      },
      {
        name                        = "gke-node-pool-internal-prod-app-app-01"
        node_pool_version           = "1.30.5-gke.1014003"
        machine_type                = "n2d-highmem-2"
        node_locations              = "asia-south2-a"
        total_max_count             = 10
        total_min_count             = 1
        local_ssd_count             = 0
        spot                        = true
        disk_size_gb                = 64
        disk_type                   = "pd-ssd"
        image_type                  = "ubuntu_containerd"
        node_count                  = 1
        enable_gcfs                 = false
        enable_gvnic                = false
        auto_repair                 = true
        auto_upgrade                = true
        service_account             = "sa-er-prod-as2-gke-app-node-02@prj-prod-svc-elasticrun-01-94.iam.gserviceaccount.com"
        preemptible                 = false
        initial_node_count          = 1
        enable_secure_boot          = true
        enable_integrity_monitoring = true
        boot_disk_kms_key           = ""
      },
      {
        name                        = "gke-node-pool-internal-prod-app-app-02"
        node_pool_version           = "1.30.5-gke.1014003"
        machine_type                = "n2d-highmem-2"
        node_locations              = "asia-south2-a"
        total_max_count             = 10
        total_min_count             = 1
        local_ssd_count             = 0
        spot                        = true
        disk_size_gb                = 64
        disk_type                   = "pd-ssd"
        image_type                  = "ubuntu_containerd"
        node_count                  = 1
        enable_gcfs                 = false
        enable_gvnic                = false
        auto_repair                 = true
        auto_upgrade                = true
        service_account             = "sa-er-prod-as2-gke-app-node-03@prj-prod-svc-elasticrun-01-94.iam.gserviceaccount.com"
        preemptible                 = false
        initial_node_count          = 1
        enable_secure_boot          = true
        enable_integrity_monitoring = true
        boot_disk_kms_key           = ""
      },
      {
        name                        = "gke-node-pool-internal-prod-app-sys"
        node_pool_version           = "1.30.5-gke.1014003"
        machine_type                = "n2d-highmem-2"
        node_locations              = "asia-south2-a"
        total_max_count             = 10
        total_min_count             = 1
        local_ssd_count             = 0
        spot                        = false
        disk_size_gb                = 64
        disk_type                   = "pd-ssd"
        image_type                  = "ubuntu_containerd"
        node_count                  = 1
        enable_gcfs                 = false
        enable_gvnic                = false
        auto_repair                 = true
        auto_upgrade                = true
        service_account             = "sa-er-prod-as2-gke-app-node-04@prj-prod-svc-elasticrun-01-94.iam.gserviceaccount.com"
        preemptible                 = false
        initial_node_count          = 1
        enable_secure_boot          = true
        enable_integrity_monitoring = true
        boot_disk_kms_key           = ""
      },
    ]
  }
]
