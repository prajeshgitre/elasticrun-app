##############################Service Account Token Details#################################
# project = {
#   name            = "prj-infra-service",
#   service_account = "sa-common-srv-terraform-deploy@prj-infra-services.iam.gserviceaccount.com",
# } 

############################## GKE creation Details#######################################
list_of_gke = [
  {
    project_service        = "prj-stage-svc-o4s-01-45"
    project_host           = "prj-stage-shrd-host-o4s-01-20"
    region                 = "asia-south1"
    zone                   = "asia-south1-a"
    regional               = false
    disable_default_snat   = false
    service_account        = "sa-stage-gke@prj-stage-svc-o4s-01-45.iam.gserviceaccount.com"
    cluster_name           = "gke-prj-stage-svc-as1-app-01"
    network_project_id     = "prj-stage-shrd-host-o4s-01-20"
    network                = "vpc-stage-shrd-host-01"
    subnetwork             = "sb-preprod-usw1-pc-gke-nodepool-01"
    ip_range_pods          = "sb-preprod-usw1-pc-gke-pod-01"
    ip_range_services      = "sb-preprod-usw1-pc-gke-svc-01"
    master_ipv4_cidr_block = "10.2.9.0/28"
    node_disk_type         = "pd-ssd"
    node_image_type        = "COS_CONTAINERD"
    cluster_resource_labels = {
      "environment" : "stage"

    },
    http_load_balancing                  = true
    network_policy                       = false
    enable_intranode_visibility          = false
    filestore_csi_driver                 = false
    enable_private_endpoint              = false
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
    master_version                       = "1.29.9-gke.1177000"
    maintenance_start_time               = "2024-01-01T00:00:00Z"
    maintenance_end_time                 = "2024-01-02T08:00:00Z"
    maintenance_recurrence               = "FREQ=WEEKLY;BYDAY=TH"
    authenticator_security_group         = "gke-security-groups@zoomcar.com"
    default_max_pods_per_node            = 32
    monitoring_enable_managed_prometheus = false
    master_authorized_networks = [
      {
        cidr_block   = "34.93.111.234/32",
        display_name = "bastion-host"
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
        name                        = "gke-node-pool-o4s-stage-app-non-prod"
        node_pool_version           = "1.30.3-gke.1639000"
        machine_type                = "n2d-custom-16-32768"
        node_locations              = "asia-south1-a"
        total_max_count             = 7
        total_min_count             = 0
        local_ssd_count             = 0
        spot                        = false
        disk_size_gb                = 50
        disk_type                   = "pd-ssd"
        image_type                  = "COS_CONTAINERD"
        node_count                  = 4
        enable_gcfs                 = false
        enable_gvnic                = false
        auto_repair                 = true
        auto_upgrade                = true
        service_account             = "sa-stage-app-non-prod@prj-stage-svc-o4s-01-45.iam.gserviceaccount.com"
        preemptible                 = false
        initial_node_count          = 1
        enable_secure_boot          = true
        enable_integrity_monitoring = true
        boot_disk_kms_key           = ""
      },
       {
        name                        = "gke-node-pool-o4s-stage-backend-spot"
        node_pool_version           = "1.30.3-gke.1639000"
        machine_type                = "n2d-standard-8"
        node_locations              = "asia-south1-a"
        total_max_count             = 10
        total_min_count             = 1
        local_ssd_count             = 0
        spot                        = true
        disk_size_gb                = 33
        disk_type                   = "pd-ssd"
        image_type                  = "COS_CONTAINERD"
        node_count                  = 1
        enable_gcfs                 = false
        enable_gvnic                = false
        auto_repair                 = true
        auto_upgrade                = true
        service_account             = "sa-stage-backend-spot@prj-stage-svc-o4s-01-45.iam.gserviceaccount.com"
        preemptible                 = false
        initial_node_count          = 1
        enable_secure_boot          = true
        enable_integrity_monitoring = true
        boot_disk_kms_key           = ""
      },
        {
        name                        = "gke-node-pool-o4s-stage-general"
        node_pool_version           = "1.30.3-gke.1639000"
        machine_type                = "n2d-standard-4"
        node_locations              = "asia-south1-a"
        total_max_count             = 10
        total_min_count             = 1
        local_ssd_count             = 0
        spot                        = false
        disk_size_gb                = 33
        disk_type                   = "pd-ssd"
        image_type                  = "COS_CONTAINERD"
        node_count                  = 1
        enable_gcfs                 = false
        enable_gvnic                = false
        auto_repair                 = true
        auto_upgrade                = true
        service_account             = "sa-stage-general@prj-stage-svc-o4s-01-45.iam.gserviceaccount.com"
        preemptible                 = false
        initial_node_count          = 1
        enable_secure_boot          = true
        enable_integrity_monitoring = true
        boot_disk_kms_key           = ""
      },
            {
        name                        = "gke-node-pool-o4s-stage-ops"
        node_pool_version           = "1.30.3-gke.1639000"
        machine_type                = "n2d-standard-8"
        node_locations              = "asia-south1-a"
        total_max_count             = 7
        total_min_count             = 0
        local_ssd_count             = 0
        spot                        = false
        disk_size_gb                = 50
        disk_type                   = "pd-ssd"
        image_type                  = "COS_CONTAINERD"
        node_count                  = 1
        enable_gcfs                 = false
        enable_gvnic                = false
        auto_repair                 = true
        auto_upgrade                = true
        service_account             = "sa-stage-ops@prj-stage-svc-o4s-01-45.iam.gserviceaccount.com"
        preemptible                 = false
        initial_node_count          = 1
        enable_secure_boot          = true
        enable_integrity_monitoring = true
        boot_disk_kms_key           = ""
      },
                  {
        name                        = "gke-node-pool-o4s-stage-perfect"
        node_pool_version           = "1.30.3-gke.1639000"
        machine_type                = "n2d-custom-4-8192"
        node_locations              = "asia-south1-a"
        total_max_count             = 1
        total_min_count             = 0
        local_ssd_count             = 0
        spot                        = false
        disk_size_gb                = 10
        disk_type                   = "pd-ssd"
        image_type                  = "COS_CONTAINERD"
        node_count                  = 1
        enable_gcfs                 = false
        enable_gvnic                = false
        auto_repair                 = true
        auto_upgrade                = true
        service_account             = "sa-stage-perfect@prj-stage-svc-o4s-01-45.iam.gserviceaccount.com"
        preemptible                 = false
        initial_node_count          = 0
        enable_secure_boot          = true
        enable_integrity_monitoring = true
        boot_disk_kms_key           = ""
      },
    ]
  }
]
