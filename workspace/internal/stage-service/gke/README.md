# Terraform Kubernetes Engine Module

This module handles opinionated Google Cloud Platform Kubernetes Engine cluster creation and configuration with Node Pools, IP MASQ, Network Policy, etc. This particular submodule creates a [private cluster](https://cloud.google.com/kubernetes-engine/docs/how-to/private-clusters)
The resources/services/activations/deletions that this module will create/trigger are:
- Create a GKE cluster with the provided addons
- Create GKE Node Pool(s) with provided configuration and attach to cluster
- Replace the default kube-dns configmap if `stub_domains` are provided
- Activate network policy if `network_policy` is true
- Add `ip-masq-agent` configmap with provided `non_masquerade_cidrs` if `configure_ip_masq` is true

Sub modules are provided for creating private clusters, beta private clusters, and beta public clusters as well.  Beta sub modules allow for the use of various GKE beta features. See the modules directory for the various sub modules.

## Private Cluster Details
For details on configuring private clusters with this module, check the [troubleshooting guide](https://github.com/terraform-google-modules/terraform-google-kubernetes-engine/blob/master/docs/private_clusters.md).

## Compatibility

This module is meant for use with Terraform 1.3+ and tested using Terraform 1.0+.
If you find incompatibilities using Terraform `>=1.3`, please open an issue.

If you haven't [upgraded to 1.3][terraform-1.3-upgrade] and need a Terraform
0.13.x-compatible version of this module, the last released version
intended for Terraform 0.13.x is [27.0.0].

If you haven't [upgraded to 0.13][terraform-0.13-upgrade] and need a Terraform
0.12.x-compatible version of this module, the last released version
intended for Terraform 0.12.x is [12.3.0].

## Usage
There are multiple examples included in the [examples](https://github.com/terraform-google-modules/terraform-google-kubernetes-engine/tree/master/examples) folder but simple usage is as follows:

```hcl
# google_client_config and kubernetes provider must be explicitly specified like the following.
module "gke" {
  for_each                        = { for x in var.list_of_gke : x.cluster_name => x }
  source                          = "terraform-google-modules/kubernetes-engine/google//modules/private-cluster"
  version                         = "27.0.0"
  project_id                      = each.value.project_service
  name                            = each.value.cluster_name
  region                          = each.value.region
  zones                           = each.value.zones
  regional                        = each.value.regional
  disable_default_snat            = each.value.disable_default_snat
  network_project_id              = each.value.network_project_id
  network                         = each.value.network
  identity_namespace              = each.value.identity_namespace
  subnetwork                      = each.value.subnetwork
  ip_range_pods                   = each.value.ip_range_pods
  ip_range_services               = each.value.ip_range_services
  http_load_balancing             = each.value.http_load_balancing
  network_policy                  = each.value.network_policy
  filestore_csi_driver            = each.value.filestore_csi_driver
  monitoring_service              = each.value.monitoring_service
  logging_service                 = each.value.logging_service
  enable_private_endpoint         = each.value.enable_private_endpoint
  enable_private_nodes            = each.value.enable_private_nodes
  enable_vertical_pod_autoscaling = each.value.enable_vertical_pod_autoscaling
  remove_default_node_pool        = each.value.remove_default_node_pool
  enable_binary_authorization     = each.value.enable_binary_authorization
  master_authorized_networks      = each.value.master_authorized_networks
  create_service_account          = each.value.create_service_account
  node_pools                      = each.value.node_pools
  enable_shielded_nodes           = each.value.enable_shielded_nodes
  release_channel                 = each.value.release_channel
  default_max_pods_per_node       = each.value.default_max_pods_per_node
  node_pools_resource_labels      = each.value.node_pools_resource_labels
  maintenance_start_time          = each.value.maintenance_start_time
  maintenance_end_time            = each.value.maintenance_end_time
  maintenance_recurrence          = each.value.maintenance_recurrence

  cluster_resource_labels = each.value.cluster_resource_labels
  node_pools_metadata     = each.value.node_pools_metadata
  node_pools_tags         = each.value.node_pools_tags
}


```

<!-- do not understand what this is about -->
Then perform the following commands on the root folder:

- `terraform init` to get the plugins
- `terraform plan` to see the infrastructure plan
- `terraform apply` to apply the infrastructure build
- `terraform destroy` to destroy the built infrastructure

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| cluster\_resource\_labels | The GCE resource labels (a map of key/value pairs) to be applied to the cluster | `map(string)` | `{}` | no |
| create\_service\_account | Defines if service account specified to run nodes should be created. | `bool` | `true` | no |
| database\_encryption | Application-layer Secrets Encryption settings. The object format is {state = string, key\_name = string}. Valid values of state are: "ENCRYPTED"; "DECRYPTED". key\_name is the name of a CloudKMS key. | `list(object({ state = string, key_name = string }))` | <pre>[<br>  {<br>    "key_name": "",<br>    "state": "DECRYPTED"<br>  }<br>]</pre> | no |
| default\_max\_pods\_per\_node | The maximum number of pods to schedule per node | `number` | `110` | no |
| disable\_default\_snat | Whether to disable the default SNAT to support the private use of public IP addresses | `bool` | `false` | no |
| enable\_private\_endpoint | (Beta) Whether the master's internal IP address is used as the cluster endpoint | `bool` | `false` | no |
| enable\_private\_nodes | (Beta) Whether nodes have internal IP addresses only | `bool` | `false` | no |
| enable\_shielded\_nodes | Enable Shielded Nodes features on all nodes in this cluster | `bool` | `true` | no |
| enable\_vertical\_pod\_autoscaling | Vertical Pod Autoscaling automatically adjusts the resources of pods controlled by it | `bool` | `false` | no |
| filestore\_csi\_driver | The status of the Filestore CSI driver addon, which allows the usage of filestore instance as volumes | `bool` | `false` | no |
| gateway\_api\_channel | The gateway api channel of this cluster. Accepted values are `CHANNEL_STANDARD` and `CHANNEL_DISABLED`. | `string` | `null` | no |
| http\_load\_balancing | Enable httpload balancer addon | `bool` | `true` | no |
| identity\_namespace | The workload pool to attach all Kubernetes service accounts to. (Default value of `enabled` automatically sets project-based pool `[project_id].svc.id.goog`) | `string` | `"enabled"` | no |
| initial\_node\_count | The number of nodes to create in this cluster's default node pool. | `number` | `0` | no |
| ip\_range\_pods | The _name_ of the secondary subnet ip range to use for pods | `string` | n/a | yes |
| ip\_range\_services | The _name_ of the secondary subnet range to use for services | `string` | n/a | yes |
| maintenance\_end\_time | Time window specified for recurring maintenance operations in RFC3339 format | `string` | `""` | no |
| maintenance\_recurrence | Frequency of the recurring maintenance window in RFC5545 format. | `string` | `""` | no |
| maintenance\_start\_time | Time window specified for daily or recurring maintenance operations in RFC3339 format | `string` | `"05:00"` | no |
| master\_authorized\_networks | List of master authorized networks. If none are provided, disallow external access (except the cluster node IPs, which GKE automatically whitelists). | `list(object({ cidr_block = string, display_name = string }))` | `[]` | no |
| name | The name of the cluster (required) | `string` | n/a | yes |
| network | The VPC network to host the cluster in (required) | `string` | n/a | yes |
| network\_policy | Enable network policy addon | `bool` | `false` | no |
| network\_project\_id | The project ID of the shared VPC's host (for shared vpc support) | `string` | `""` | no |
| node\_pools | List of maps containing node pools | `list(map(any))` | <pre>[<br>  {<br>    "name": "default-node-pool"<br>  }<br>]</pre> | no |
| node\_pools\_metadata | Map of maps containing node metadata by node-pool name | `map(map(string))` | <pre>{<br>  "all": {},<br>  "default-node-pool": {}<br>}</pre> | no |
| node\_pools\_resource\_labels | Map of maps containing resource labels by node-pool name | `map(map(string))` | <pre>{<br>  "all": {},<br>  "default-node-pool": {}<br>}</pre> | no |
| node\_pools\_tags | Map of lists containing node network tags by node-pool name | `map(list(string))` | <pre>{<br>  "all": [],<br>  "default-node-pool": []<br>}</pre> | no |
| project\_id | The project ID to host the cluster in (required) | `string` | n/a | yes |
| region | The region to host the cluster in (optional if zonal cluster / required if regional) | `string` | `null` | no |
| regional | Whether is a regional cluster (zonal cluster if set false. WARNING: changing this after cluster creation is destructive!) | `bool` | `true` | no |
| release\_channel | The release channel of this cluster. Accepted values are `UNSPECIFIED`, `RAPID`, `REGULAR` and `STABLE`. Defaults to `REGULAR`. | `string` | `"REGULAR"` | no |
| remove\_default\_node\_pool | Remove default node pool while setting up the cluster | `bool` | `false` | no |
| service\_account | The service account to run nodes as if not overridden in `node_pools`. The create\_service\_account variable default value (true) will cause a cluster-specific service account to be created. This service account should already exists and it will be used by the node pools. If you wish to only override the service account name, you can use service\_account\_name variable. | `string` | `""` | no |
| subnetwork | The subnetwork to host the cluster in (required) | `string` | n/a | yes |
| upstream\_nameservers | If specified, the values replace the nameservers taken by default from the node’s /etc/resolv.conf | `list(string)` | `[]` | no |
| zones | The zones to host the cluster in (optional if regional cluster / required if zonal) | `list(string)` | `[]` | no |



<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## node_pools variable


The node_pools variable takes the following parameters:

| Name | Description | Default | Requirement |
| --- | --- | --- | --- |
| auto_repair | Whether the nodes will be automatically repaired | true | Optional |
| autoscaling | Configuration required by cluster autoscaler to adjust the size of the node pool to the current cluster usage | true | Optional |
| auto_upgrade | Whether the nodes will be automatically upgraded | true (if cluster is regional) | Optional |
| disk_size_gb | Size of the disk attached to each node, specified in GB. The smallest allowed disk size is 10GB | 100 | Optional |
| disk_type | Type of the disk attached to each node (e.g. 'pd-standard' or 'pd-ssd') | pd-standard | Optional |
| enable_gcfs | Google Container File System (gcfs) has to be enabled for image streaming to be active. Needs image_type to be set to COS_CONTAINERD. | false | Optional |
| enable_gvnic | gVNIC (GVE) is an alternative to the virtIO-based ethernet driver. Needs a Container-Optimized OS node image. | false | Optional |
| enable_integrity_monitoring | Enables monitoring and attestation of the boot integrity of the instance. The attestation is performed against the integrity policy baseline. This baseline is initially derived from the implicitly trusted boot image when the instance is created. | true | Optional |
| enable_secure_boot | Secure Boot helps ensure that the system only runs authentic software by verifying the digital signature of all boot components, and halting the boot process if signature verification fails. | false | Optional |
| image_type | The image type to use for this node. Note that changing the image type will delete and recreate all nodes in the node pool | COS_CONTAINERD | Optional |
| initial_node_count | The initial number of nodes for the pool. In regional or multi-zonal clusters, this is the number of nodes per zone. Changing this will force recreation of the resource. Defaults to the value of min_count | " " | Optional |
| local_ssd_count | The amount of local SSD disks that will be attached to each cluster node and may be used as a `hostpath` volume or a `local` PersistentVolume.  | 0 | Optional |
| machine_type | The name of a Google Compute Engine machine type | e2-medium | Optional |
| total_max_count | Total maximum number of nodes in the NodePool. Must be >= min_count. Cannot be used with per zone limits. | null | Optional |
| total_min_count | Total minimum number of nodes in the NodePool. Must be >=0 and <= max_count. Should be used when autoscaling is true. Cannot be used with per zone limits. | null | Optional |
| name | The name of the node pool |  | Required |
| node_count | The number of nodes in the nodepool when autoscaling is false. Otherwise defaults to 1. Only valid for non-autoscaling clusters |  | Required |
| node_locations | The list of zones in which the cluster's nodes are located. Nodes must be in the region of their regional cluster or in the same region as their cluster's zone for zonal clusters. Defaults to cluster level node locations if nothing is specified | " " | Optional |
| preemptible | A boolean that represents whether or not the underlying node VMs are preemptible | false | Optional |
| spot | A boolean that represents whether the underlying node VMs are spot | false | Optional |
| service_account | The service account to be used by the Node VMs | " " | Optional |
| tags | The list of instance tags applied to all nodes | | Required |



## Requirements

Before this module can be used on a project, you must ensure that the following pre-requisites are fulfilled:

1. Terraform and kubectl are [installed](#software-dependencies) on the machine where Terraform is executed.
2. The Service Account you execute the module with has the right [permissions](#configure-a-service-account).
3. The Compute Engine and Kubernetes Engine APIs are [active](#enable-apis) on the project you will launch the cluster in.
4. If you are using a Shared VPC, the APIs must also be activated on the Shared VPC host project and your service account needs the proper permissions there.

The [project factory](https://github.com/terraform-google-modules/terraform-google-project-factory) can be used to provision projects with the correct APIs active and the necessary Shared VPC connections.

### Software Dependencies
#### Kubectl
- [kubectl](https://github.com/kubernetes/kubernetes/releases) 1.9.x
#### Terraform and Plugins
- [Terraform](https://www.terraform.io/downloads.html) 0.13+
- [Terraform Provider for GCP][terraform-provider-google] v4.51
#### gcloud
Some submodules use the [terraform-google-gcloud](https://github.com/terraform-google-modules/terraform-google-gcloud) module. By default, this module assumes you already have gcloud installed in your $PATH.
See the [module](https://github.com/terraform-google-modules/terraform-google-gcloud#downloading) documentation for more information.

### Configure a Service Account
In order to execute this module you must have a Service Account with the
following project roles:
- roles/compute.viewer
- roles/compute.securityAdmin (only required if `add_cluster_firewall_rules` is set to `true`)
- roles/container.clusterAdmin
- roles/container.developer
- roles/iam.serviceAccountAdmin
- roles/iam.serviceAccountUser
- roles/resourcemanager.projectIamAdmin (only required if `service_account` is set to `create`)

Additionally, if `service_account` is set to `create` and `grant_registry_access` is requested, the service account requires the following role on the `registry_project_ids` projects:
- roles/resourcemanager.projectIamAdmin

### Enable APIs
In order to operate with the Service Account you must activate the following APIs on the project where the Service Account was created:

- Compute Engine API - compute.googleapis.com
- Kubernetes Engine API - container.googleapis.com

[terraform-provider-google]: https://github.com/terraform-providers/terraform-provider-google
[12.3.0]: https://registry.terraform.io/modules/terraform-google-modules/kubernetes-engine/google/12.3.0
[terraform-0.13-upgrade]: https://www.terraform.io/upgrade-guides/0-13.html



# Terraform Service Accounts Module

This module allows easy creation of one or more service accounts, and granting them basic roles.

The resources/services/activations/deletions that this module will create/trigger are:

- one or more service accounts
- optional project-level IAM role bindings for each service account
- one optional billing IAM role binding per service account, at the organization or billing account level
- two optional organization-level IAM bindings per service account, to enable the service accounts to create and manage Shared VPC networks
- one optional service account key per service account

## Compatibility
This module is meant for use with Terraform 0.13+ and tested using Terraform 1.0+. If you find incompatibilities using Terraform >=0.13, please open an issue.
 If you haven't
[upgraded](https://www.terraform.io/upgrade-guides/0-13.html) and need a Terraform
0.12.x-compatible version of this module, the last released version
intended for Terraform 0.12.x is [v3.0.1](https://registry.terraform.io/modules/terraform-google-modules/-service-accounts/google/v3.0.1).

## Usage

Basic usage of this module is as follows:

```hcl
module "service_accounts" {
  source        = "terraform-google-modules/service-accounts/google"
  version       = "4.2.1"
  for_each      = { for account in var.service_accounts_list : account.display_name => account }
  project_id    = each.value.project_id
  prefix        = each.value.prefix
  display_name  = each.value.display_name
  names         = each.value.names
  project_roles = each.value.project_roles
  description   = each.value.description
}

```

Functional examples are included in the
[examples](./examples/) directory.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| description | Default description of the created service accounts (defaults to no description) | `string` | `""` | no |
| display\_name | Display names of the created service accounts (defaults to 'Terraform-managed service account') | `string` | `"Terraform-managed service account"` | no |
| names | Names of the service accounts to create. | `list(string)` | `[]` | no |
| prefix | Prefix applied to service account names. | `string` | `""` | no |
| project\_id | Project id where service account will be created. | `string` | n/a | yes |
| project\_roles | Common roles to apply to all service accounts, project=>role as elements. | `list(string)` | `[]` | no |



<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Requirements

These sections describe requirements for using this module.

### Software

The following dependencies must be available:

- [Terraform](https://www.terraform.io/downloads.html) >= 0.13.0
- [Terraform Provider for GCP][terraform-provider-gcp] plugin >= v2.0

### IAM

Service account or user credentials with the following roles must be used to provision the resources of this module:

- Service Account Admin: `roles/iam.serviceAccountAdmin`
- (optional) Service Account Key Admin: `roles/iam.serviceAccountKeyAdmin` when `generate_keys` is set to `true`
- (optional) roles needed to grant optional IAM roles at the project or organizational level

## Contributing

Refer to the [contribution guidelines](./CONTRIBUTING.md) for
information on contributing to this module.

[iam-module]: https://registry.terraform.io/modules/terraform-google-modules/iam/google
[project-factory-module]: https://registry.terraform.io/modules/terraform-google-modules/project-factory/google
[terraform-provider-gcp]: https://www.terraform.io/docs/providers/google/index.html
[terraform]: https://www.terraform.io/downloads.html