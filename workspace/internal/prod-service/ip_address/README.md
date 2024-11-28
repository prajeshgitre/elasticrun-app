
# Terraform Google Cloud NAT Module

This module handles opinionated Google Cloud Platform Cloud NAT creation and configuration.


## Compatibility
This module is meant for use with Terraform 0.13+ and tested using Terraform 1.0+. If you find incompatibilities using Terraform >=0.13, please open an issue.
 If you haven't
[upgraded](https://www.terraform.io/upgrade-guides/0-13.html) and need a Terraform
0.12.x-compatible version of this module, the last released version
intended for Terraform 0.12.x is [v1.4.0](https://registry.terraform.io/modules/terraform-google-modules/-cloud-nat/google/v1.4.0).


```hcl
module "address" {
  source       = "../../../../modules/terraform_google_address"
  for_each     = { for ip in var.reserve_static_ip : ip.name => ip }
  names        = [each.value.name]
  region       = each.value.region
  project_id   = each.value.project_id
  global       = false
  address_type = each.value.address_type
}

//module to create Cloud_NAT
module "cloud-nat" {
  source                             = "../../../../modules/terraform-google-network/modules/cloud_nat"
  for_each                           = { for nat in var.cloud_nat : nat.nat_name => nat }
  router                             = each.value.router_name
  project_id                         = each.value.project_id
  nat_ips                            = [for i in toset(each.value.static_ip_name) : module.address["${i}"].self_links[0]]
  region                             = each.value.region
  name                               = each.value.nat_name
  network                            = each.value.router_network
  create_router                      = each.value.create_router
  source_subnetwork_ip_ranges_to_nat = each.value.source_subnetwork_ip_ranges_to_nat
}
```
## Creation  Cloud NAT from tfvars
```hcl
reserve_static_ip = [
 
     {
     name         = "sip-bootstrap-seed-static-nat-ip-02"
     project_id   = "wiai-bootstrap-seed"
     region       = "asia-south1"
     address_type = "EXTERNAL"
     subnetwork   = null
   },
]
 cloud_nat = [
  {
    project_id                          = "wiai-bootstrap-seed"
    router_network                      = "vpc-seed-wiai-asso1-primary"
    region                              = "asia-south1"
    nat_name                            = "nat-bootstrap-seed-asso1-gateway"
    router_name                         = "router-bootstrap-seed-asso1-nat-01"
    create_router                       = true
    log_config_enable                   = false
    log_config_filter                   = "ALL"
    enable_dynamic_port_allocation      = true
    enable_endpoint_independent_mapping = false
    min_ports_per_vm                    = 2048
    //static address should be declared in above static_ip_name variable
    static_ip_name                     = ["sip-bootstrap-seed-static-nat-ip-01"]
    source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
    // "LIST_OF_SUBNETWORKS"
    subnetworks = [
    ]
  },
]
```

Then perform the following commands on the root folder:

- `terraform init` to get the plugins
- `terraform plan` to see the infrastructure plan
- `terraform apply` to apply the infrastructure build

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| create\_router | Create router instead of using an existing one, uses 'router' variable for new resource name. | `bool` | `false` | no |
| enable\_dynamic\_port\_allocation | Enable Dynamic Port Allocation. If minPorts is set, minPortsPerVm must be set to a power of two greater than or equal to 32. | `bool` | `false` | no |
| enable\_endpoint\_independent\_mapping | Specifies if endpoint independent mapping is enabled. | `bool` | `null` | no |
| icmp\_idle\_timeout\_sec | Timeout (in seconds) for ICMP connections. Defaults to 30s if not set. Changing this forces a new NAT to be created. | `string` | `"30"` | no |
| log\_config\_enable | Indicates whether or not to export logs | `bool` | `false` | no |
| log\_config\_filter | Specifies the desired filtering of logs on this NAT. Valid values are: "ERRORS\_ONLY", "TRANSLATIONS\_ONLY", "ALL" | `string` | `"ALL"` | no |
| max\_ports\_per\_vm | Maximum number of ports allocated to a VM from this NAT. This field can only be set when enableDynamicPortAllocation is enabled.This will be ignored if enable\_dynamic\_port\_allocation is set to false. | `string` | `null` | no |
| min\_ports\_per\_vm | Minimum number of ports allocated to a VM from this NAT config. Defaults to 64 if not set. Changing this forces a new NAT to be created. | `string` | `"64"` | no |
| name | Defaults to 'cloud-nat-RANDOM\_SUFFIX'. Changing this forces a new NAT to be created. | `string` | `""` | no |
| nat\_ips | List of self\_links of external IPs. Changing this forces a new NAT to be created. Value of `nat_ip_allocate_option` is inferred based on nat\_ips. If present set to MANUAL\_ONLY, otherwise AUTO\_ONLY. | `list(string)` | `[]` | no |
| network | VPN name, only if router is not passed in and is created by the module. | `string` | `""` | no |
| project\_id | The project ID to deploy to | `string` | n/a | yes |
| region | The region to deploy to | `string` | n/a | yes |
| router | The name of the router in which this NAT will be configured. Changing this forces a new NAT to be created. | `string` | n/a | yes |
| router\_asn | Router ASN, only if router is not passed in and is created by the module. | `string` | `"64514"` | no |
| router\_keepalive\_interval | Router keepalive\_interval, only if router is not passed in and is created by the module. | `string` | `"20"` | no |
| source\_subnetwork\_ip\_ranges\_to\_nat | Defaults to ALL\_SUBNETWORKS\_ALL\_IP\_RANGES. How NAT should be configured per Subnetwork. Valid values include: ALL\_SUBNETWORKS\_ALL\_IP\_RANGES, ALL\_SUBNETWORKS\_ALL\_PRIMARY\_IP\_RANGES, LIST\_OF\_SUBNETWORKS. Changing this forces a new NAT to be created. | `string` | `"ALL_SUBNETWORKS_ALL_IP_RANGES"` | no |
| subnetworks | Specifies one or more subnetwork NAT configurations | <pre>list(object({<br>    name                     = string,<br>    source_ip_ranges_to_nat  = list(string)<br>    secondary_ip_range_names = list(string)<br>  }))</pre> | `[]` | no |
| tcp\_established\_idle\_timeout\_sec | Timeout (in seconds) for TCP established connections. Defaults to 1200s if not set. Changing this forces a new NAT to be created. | `string` | `"1200"` | no |
| tcp\_time\_wait\_timeout\_sec | Timeout (in seconds) for TCP connections that are in TIME\_WAIT state. Defaults to 120s if not set. | `string` | `"120"` | no |
| tcp\_transitory\_idle\_timeout\_sec | Timeout (in seconds) for TCP transitory connections. Defaults to 30s if not set. Changing this forces a new NAT to be created. | `string` | `"30"` | no |
| udp\_idle\_timeout\_sec | Timeout (in seconds) for UDP connections. Defaults to 30s if not set. Changing this forces a new NAT to be created. | `string` | `"30"` | no |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Requirements

Before this module can be used on a project, you must ensure that the following pre-requisites are fulfilled:

1. Terraform are [installed](#software-dependencies) on the machine where Terraform is executed.
2. The Service Account you execute the module with has the right [permissions](#iam-roles).
3. The APIs are [active](#enable-apis) on the project you will launch the cluster in.
4. If you are using a Shared VPC, the APIs must also be activated on the Shared VPC host project and your service account needs the proper permissions there.


### Configure a Service Account

In order to execute this module you must have a Service Account with the
following project roles:

- [roles/compute.networkAdmin](https://cloud.google.com/nat/docs/using-nat#iam_permissions)

### Enable APIs

In order to operate with the Service Account you must activate the following APIs on the project where the Service Account was created:

- Compute Engine API - compute.googleapis.com

# Terraform Google Cloud DNS Module

This module makes it easy to create Google Cloud DNS zones of different types, and manage their records. It supports creating private zones.

The resources/services/activations/deletions that this module will create/trigger are:

- One `google_dns_managed_zone` for the zone
- Zero or more `google_dns_record_set` for the zone records

## Compatibility
This module is meant for use with Terraform 0.13+ and tested using Terraform 1.0+. If you find incompatibilities using Terraform >=0.13, please open an issue.
 If you haven't
[upgraded](https://www.terraform.io/upgrade-guides/0-13.html) and need a Terraform
0.12.x-compatible version of this module, the last released version
intended for Terraform 0.12.x is [v3.1.0](https://registry.terraform.io/modules/terraform-google-modules/-cloud-dns/google/v3.1.0).

## Usage

Basic usage of this module for a private zone is as follows:

```hcl
// DATA Block for fetching network self link url
data "google_compute_network" "network" {
  name    = "<network-name>"
  project = "<host-project-id>"
}

module "cloud-dns" {
  source                             = "../../modules/terraform-google-cloud-dns"
  for_each                           = { for dns in var.cloud_dns : dns.name => dns }
  project_id                         = var.host_project_id
  type                               = each.value.type
  name                               = each.value.name
  domain                             = each.value.domain
  private_visibility_config_networks = [data.google_compute_network.network.self_link]
  recordsets                         = each.value.recordsets
}
```
## Creation of cloud DNS  from the tfvars
```hcl
dns_network    = "vpc-seed-wiai-asso1-primary"
dns_project_id = "wiai-bootstrap-seed"
cloud_dns = [
  {
    type   = "private"
    name   = "accounts-google-com"
    domain = "accounts.google.com."
    recordsets = [
      {
        name = "private"
        type = "A"
        ttl  = 300
        records = [
          "199.36.153.8", "199.36.153.9", "199.36.153.10", "199.36.153.11"
        ]
      },
      {
        name = "*"
        type = "CNAME"
        ttl  = 300
        records = [
          "private.accounts.google.com.",
        ]
      },
      {
        name = ""
        type = "A"
        ttl  = 300
        records = [
          "199.36.153.8", "199.36.153.9", "199.36.153.10", "199.36.153.11"
        ]
      },
    ]
  },
]
```
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| default\_key\_specs\_key | Object containing default key signing specifications : algorithm, key\_length, key\_type, kind. Please see https://www.terraform.io/docs/providers/google/r/dns_managed_zone#dnssec_config for futhers details | `any` | `{}` | no |
| default\_key\_specs\_zone | Object containing default zone signing specifications : algorithm, key\_length, key\_type, kind. Please see https://www.terraform.io/docs/providers/google/r/dns_managed_zone#dnssec_config for futhers details | `any` | `{}` | no |
| description | zone description (shown in console) | `string` | `"Managed by Terraform"` | no |
| dnssec\_config | Object containing : kind, non\_existence, state. Please see https://www.terraform.io/docs/providers/google/r/dns_managed_zone#dnssec_config for futhers details | `any` | `{}` | no |
| domain | Zone domain, must end with a period. | `string` | n/a | yes |
| enable\_logging | Enable query logging for this ManagedZone | `bool` | `false` | no |
| force\_destroy | Set this true to delete all records in the zone. | `bool` | `false` | no |
| labels | A set of key/value label pairs to assign to this ManagedZone | `map(any)` | `{}` | no |
| name | Zone name, must be unique within the project. | `string` | n/a | yes |
| private\_visibility\_config\_networks | List of VPC self links that can see this zone. | `list(string)` | `[]` | no |
| project\_id | Project id for the zone. | `string` | n/a | yes |
| recordsets | List of DNS record objects to manage, in the standard terraform dns structure. | <pre>list(object({<br>    name    = string<br>    type    = string<br>    ttl     = number<br>    records = list(string)<br>  }))</pre> | `[]` | no |
| service\_namespace\_url | The fully qualified or partial URL of the service directory namespace that should be associated with the zone. This should be formatted like https://servicedirectory.googleapis.com/v1/projects/{project}/locations/{location}/namespaces/{namespace_id} or simply projects/{project}/locations/{location}/namespaces/{namespace\_id}. | `string` | `""` | no |
| target\_name\_server\_addresses | List of target name servers for forwarding zone. | `list(map(any))` | `[]` | no |
| target\_network | Peering network. | `string` | `""` | no |
| type | Type of zone to create, valid values are 'public', 'private', 'forwarding', 'peering', 'reverse\_lookup' and 'service\_directory'. | `string` | `"private"` | no |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->


### Service Account

User or service account credentials with the following roles must be used to provision the resources of this module:

- DNS Administrator: `roles/dns.admin`

The [Project Factory module][project-factory-module] and the
[IAM module][iam-module] may be used in combination to provision a
service account with the necessary roles applied.

### APIs

A project with the following APIs enabled must be used to host the
resources of this module:

- Google Cloud DNS API: `dns.googleapis.com`

# Google Cloud VPC Firewall Rules

This module allows creation of custom VPC firewall rules.

## Usage

Variable `rules` details are available [here](#rules). Basic usage of this module is as follows:

```hcl
module "firewall_rules" {
  source       = "../../modules/terraform-google-network/modules/firewall-rules"
  project_id   = var.project_id
  network_name = module.vpc.network_name

  rules = [{
    name                    = "allow-ssh-ingress"
    description             = null
    direction               = "INGRESS"
    priority                = null
    source_ranges           = ["0.0.0.0/0"]
    source_tags             = null
    source_service_accounts = null
    target_tags             = ["ssh"]
    target_service_accounts = null
    allow = [{
      protocol = "tcp"
      ports    = ["22"]
    }]
    deny = []
    log_config = {
      metadata = "INCLUDE_ALL_METADATA"
    }
  }]
}
```
## Creation of firewall rules from the tfvars
```hcl
firewall_rules_list = {
  fw-gcp-ingress-iap-gcp-allow = {
    network_name = "vpc-seed-wiai-asso1-primary"
    project_id   = "wiai-bootstrap-seed"
    rules = [
      {
        name                    = "fw-bootstrap-seed-asso1-allow-iap"
        priority                = 1000
        description             = "allow iap acccess to vm"
        direction               = "INGRESS"
        ranges                  = ["35.235.240.0/20"]
        source_tags             = null
        source_service_accounts = null
        target_tags             = ["ssh","jenkins" ]
        target_service_accounts = null
        log_config              = null
        deny                    = []
        allow = [{
          protocol = "tcp"
          ports    = ["22","8080",]
        }]
      }
    ]
  }
  }
  ```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| egress\_rules | List of egress rules. This will be ignored if variable 'rules' is non-empty | <pre>list(object({<br>    name                    = string<br>    description             = optional(string, null)<br>    priority                = optional(number, null)<br>    destination_ranges      = optional(list(string), [])<br>    source_ranges           = optional(list(string), [])<br>    source_tags             = optional(list(string))<br>    source_service_accounts = optional(list(string))<br>    target_tags             = optional(list(string))<br>    target_service_accounts = optional(list(string))<br><br>    allow = optional(list(object({<br>      protocol = string<br>      ports    = optional(list(string))<br>    })), [])<br>    deny = optional(list(object({<br>      protocol = string<br>      ports    = optional(list(string))<br>    })), [])<br>    log_config = optional(object({<br>      metadata = string<br>    }))<br>  }))</pre> | `[]` | no |
| ingress\_rules | List of ingress rules. This will be ignored if variable 'rules' is non-empty | <pre>list(object({<br>    name                    = string<br>    description             = optional(string, null)<br>    priority                = optional(number, null)<br>    destination_ranges      = optional(list(string), [])<br>    source_ranges           = optional(list(string), [])<br>    source_tags             = optional(list(string))<br>    source_service_accounts = optional(list(string))<br>    target_tags             = optional(list(string))<br>    target_service_accounts = optional(list(string))<br><br>    allow = optional(list(object({<br>      protocol = string<br>      ports    = optional(list(string))<br>    })), [])<br>    deny = optional(list(object({<br>      protocol = string<br>      ports    = optional(list(string))<br>    })), [])<br>    log_config = optional(object({<br>      metadata = string<br>    }))<br>  }))</pre> | `[]` | no |
| network\_name | Name of the network this set of firewall rules applies to. | `string` | n/a | yes |
| project\_id | Project id of the project that holds the network. | `string` | n/a | yes |
| rules | This is DEPRICATED and available for backward compatiblity. Use ingress\_rules and egress\_rules variables. List of custom rule definitions | <pre>list(object({<br>    name                    = string<br>    description             = optional(string, null)<br>    direction               = optional(string, "INGRESS")<br>    priority                = optional(number, null)<br>    ranges                  = optional(list(string), [])<br>    source_tags             = optional(list(string))<br>    source_service_accounts = optional(list(string))<br>    target_tags             = optional(list(string))<br>    target_service_accounts = optional(list(string))<br><br>    allow = optional(list(object({<br>      protocol = string<br>      ports    = optional(list(string))<br>    })), [])<br>    deny = optional(list(object({<br>      protocol = string<br>      ports    = optional(list(string))<br>    })), [])<br>    log_config = optional(object({<br>      metadata = string<br>    }))<br>  }))</pre> | `[]` | no |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## rules
In a [firewall rule](https://cloud.google.com/firewall/docs/firewalls), you specify a set of components that define what the rule does. Some of the values are optional and some have default value. For sample code check [firewall rules][examples](https://github.com/terraform-google-modules/terraform-google-network/tree/master/examples) folder. variable `rule.ranges` is kept for backward compatibility and should not be set at the same time as `rule.destination_ranges` OR `rule.source_ranges` otherwise module will generate an error message `ranges may not be set at the same time as destination_ranges OR source_ranges`.

- `ranges`: IP address range. This may not be set at the same time as `destination_ranges` OR `source_ranges`.
- `source_ranges`: (Optional) If source ranges are specified, the firewall will apply only to traffic that has source IP address in these ranges. These ranges must be expressed in CIDR format. `source_ranges` may not be set at the same time as `ranges`
- `destination_ranges`: (Optional) If destination ranges are specified, the firewall will apply only to traffic that has destination IP address in these ranges. These ranges must be expressed in CIDR format. `destination_ranges` may not be set at the same time as `ranges`
- `name`: (Required) Name of the resource. Provided by the client when the resource is created. The name must be 1-63 characters long, the first character must be a lowercase letter, and all following characters must be a dash, lowercase letter, or digit, except the last character, which cannot be a dash.
- `description`: (Optional) An optional description of this resource. Provide this property when you create the resource
- `direction`: (Optional) Direction of traffic to which this firewall applies; default is INGRESS
- `priority`: (Optional) Priority for this rule. This is an integer between 0 and 65535, both inclusive. When not specified, the value assumed is 1000

# Terraform Routes Module

It creates the individual vpc routes.

It supports creating:

- Routes within vpc network.

## Usage

Basic usage of this submodule is as follows:

```hcl
module "vpc" {
    source  = "../../modules/terraform-google-network/modules/routes"
    project_id   = "<PROJECT ID>"
    network_name = "example-vpc"

    routes = [
        {
            name                   = "egress-internet"
            description            = "route through IGW to access internet"
            destination_range      = "0.0.0.0/0"
            tags                   = "egress-inet"
            next_hop_internet      = "true"
        },
        {
            name                   = "app-proxy"
            description            = "route through proxy to reach app"
            destination_range      = "10.50.10.0/24"
            tags                   = "app-proxy"
            next_hop_instance      = "app-proxy-instance"
            next_hop_instance_zone = "us-west1-a"
        },
    ]
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| module\_depends\_on | List of modules or resources this module depends on. | `list(any)` | `[]` | no |
| network\_name | The name of the network where routes will be created | `string` | n/a | yes |
| project\_id | The ID of the project where the routes will be created | `string` | n/a | yes |
| routes | List of routes being created in this VPC | `list(map(string))` | `[]` | no |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

### Routes Input

The routes list contains maps, where each object represents a route. For the next_hop_* inputs, only one is possible to be used in each route. Having two next_hop_* inputs will produce an error. Each map has the following inputs (please see examples folder for additional references):

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| name | The name of the route being created  | string | - | no |
| description | The description of the route being created | string | - | no |
| tags | The network tags assigned to this route. This is a list in string format. Eg. "tag-01,tag-02"| string | - | yes |
| destination\_range | The destination range of outgoing packets that this route applies to. Only IPv4 is supported | string | - | yes
| next\_hop\_internet | Whether the next hop to this route will the default internet gateway. Use "true" to enable this as next hop | string | `"false"` | yes |
| next\_hop\_ip | Network IP address of an instance that should handle matching packets | string | - | yes |
| next\_hop\_instance |  URL or name of an instance that should handle matching packets. If just name is specified "next\_hop\_instance\_zone" is required | string | - | yes |
| next\_hop\_instance\_zone |  The zone of the instance specified in next\_hop\_instance. Only required if next\_hop\_instance is specified as a name | string | - | no |
| next\_hop\_vpn\_tunnel | URL to a VpnTunnel that should handle matching packets | string | - | yes |
| next\_hop\_ilb | The URL to a forwarding rule of type loadBalancingScheme=INTERNAL that should handle matching packets. | string | - | no |
| priority | The priority of this route. Priority is used to break ties in cases where there is more than one matching route of equal prefix length. In the case of two routes with equal prefix length, the one with the lowest-numbered priority value wins | string | `"1000"` | yes |

# Terraform Network Module

This module makes it easy to set up a new VPC Network in GCP by defining your network and subnet ranges in a concise syntax.

It supports creating:

- A Google Virtual Private Network (VPC)
- Subnets within the VPC
- Secondary ranges for the subnets (if applicable)

Sub modules are provided for creating individual vpc, subnets, and routes. See the modules directory for the various sub modules usage.

## Compatibility

This module is meant for use with Terraform 1.3+ and tested using Terraform 1.4+.
If you find incompatibilities using Terraform `>=1.3`, please open an issue.

If you haven't [upgraded][terraform-0.13-upgrade] and need a Terraform
0.12.x-compatible version of this module, the last released version
intended for Terraform 0.12.x is [2.6.0].

## Usage
You can go to the examples folder, however the usage of the module could be like this in your own main.tf file:

```hcl
module "vpc" {
    source  = "../../modules/terraform-google-network"
    project_id   = "<PROJECT ID>"
    network_name = "example-vpc"

    subnets = [
        {
        subnet_name           = "subnet -asso1-01"
        subnet_ip             = "10.100.1.0/24"
        subnet_region         = "asia-south1"
        subnet_private_access = "true"
        subnet_flow_logs      = "false"
        description           = "subnet for  project"
      },
    
    ]

    secondary_ranges = {
        subnet-01 = [
            {
                range_name    = "subnet-01-secondary-01"
                ip_cidr_range = "192.168.64.0/24"
            },
        ]

        subnet-02 = []
    }
}
```
## Creation of VPC and subnet from tfvars
```hcl
vpc_list = {
  vpc-common-service-wiai-asso1-primary = {
    vpc_name                               = "vpc-seed-wiai-asso1-primary"
    project_id                             = "wiai-bootstrap-seed"
    delete_default_internet_gateway_routes = false
    subnets = [
      {
        subnet_name           = "subnet-seed-asso1-01"
        subnet_ip             = "10.100.1.0/24"
        subnet_region         = "asia-south1"
        subnet_private_access = "true"
        subnet_flow_logs      = "false"
        description           = "subnet for seed project"
      },
    ]
  

      secondary_ranges = {

      }
}
}

```

Then perform the following commands on the root folder:

- `terraform init` to get the plugins
- `terraform plan` to see the infrastructure plan
- `terraform apply` to apply the infrastructure build

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| auto\_create\_subnetworks | When set to true, the network is created in 'auto subnet mode' and it will create a subnet for each region automatically across the 10.128.0.0/9 address range. When set to false, the network is created in 'custom subnet mode' so the user can explicitly connect subnetwork resources. | `bool` | `false` | no |
| delete\_default\_internet\_gateway\_routes | If set, ensure that all routes within the network specified whose names begin with 'default-route' and with a next hop of 'default-internet-gateway' are deleted | `bool` | `false` | no |
| description | An optional description of this resource. The resource must be recreated to modify this field. | `string` | `""` | no |
| egress\_rules | List of egress rules. This will be ignored if variable 'rules' is non-empty | <pre>list(object({<br>    name                    = string<br>    description             = optional(string, null)<br>    priority                = optional(number, null)<br>    destination_ranges      = optional(list(string), [])<br>    source_ranges           = optional(list(string), [])<br>    source_tags             = optional(list(string))<br>    source_service_accounts = optional(list(string))<br>    target_tags             = optional(list(string))<br>    target_service_accounts = optional(list(string))<br><br>    allow = optional(list(object({<br>      protocol = string<br>      ports    = optional(list(string))<br>    })), [])<br>    deny = optional(list(object({<br>      protocol = string<br>      ports    = optional(list(string))<br>    })), [])<br>    log_config = optional(object({<br>      metadata = string<br>    }))<br>  }))</pre> | `[]` | no |
| firewall\_rules | This is DEPRICATED and available for backward compatiblity. Use ingress\_rules and egress\_rules variables. List of firewall rules | <pre>list(object({<br>    name                    = string<br>    description             = optional(string, null)<br>    direction               = optional(string, "INGRESS")<br>    priority                = optional(number, null)<br>    ranges                  = optional(list(string), [])<br>    source_tags             = optional(list(string))<br>    source_service_accounts = optional(list(string))<br>    target_tags             = optional(list(string))<br>    target_service_accounts = optional(list(string))<br><br>    allow = optional(list(object({<br>      protocol = string<br>      ports    = optional(list(string))<br>    })), [])<br>    deny = optional(list(object({<br>      protocol = string<br>      ports    = optional(list(string))<br>    })), [])<br>    log_config = optional(object({<br>      metadata = string<br>    }))<br>  }))</pre> | `[]` | no |
| ingress\_rules | List of ingress rules. This will be ignored if variable 'rules' is non-empty | <pre>list(object({<br>    name                    = string<br>    description             = optional(string, null)<br>    priority                = optional(number, null)<br>    destination_ranges      = optional(list(string), [])<br>    source_ranges           = optional(list(string), [])<br>    source_tags             = optional(list(string))<br>    source_service_accounts = optional(list(string))<br>    target_tags             = optional(list(string))<br>    target_service_accounts = optional(list(string))<br><br>    allow = optional(list(object({<br>      protocol = string<br>      ports    = optional(list(string))<br>    })), [])<br>    deny = optional(list(object({<br>      protocol = string<br>      ports    = optional(list(string))<br>    })), [])<br>    log_config = optional(object({<br>      metadata = string<br>    }))<br>  }))</pre> | `[]` | no |
| mtu | The network MTU (If set to 0, meaning MTU is unset - defaults to '1460'). Recommended values: 1460 (default for historic reasons), 1500 (Internet default), or 8896 (for Jumbo packets). Allowed are all values in the range 1300 to 8896, inclusively. | `number` | `0` | no |
| network\_firewall\_policy\_enforcement\_order | Set the order that Firewall Rules and Firewall Policies are evaluated. Valid values are `BEFORE_CLASSIC_FIREWALL` and `AFTER_CLASSIC_FIREWALL`. (default null or equivalent to `AFTER_CLASSIC_FIREWALL`) | `string` | `null` | no |
| network\_name | The name of the network being created | `string` | n/a | yes |
| project\_id | The ID of the project where this VPC will be created | `string` | n/a | yes |
| routes | List of routes being created in this VPC | `list(map(string))` | `[]` | no |
| routing\_mode | The network routing mode (default 'GLOBAL') | `string` | `"GLOBAL"` | no |
| secondary\_ranges | Secondary ranges that will be used in some of the subnets | `map(list(object({ range_name = string, ip_cidr_range = string })))` | `{}` | no |
| shared\_vpc\_host | Makes this project a Shared VPC host if 'true' (default 'false') | `bool` | `false` | no |
| subnets | The list of subnets being created | <pre>list(object({<br>    subnet_name                      = string<br>    subnet_ip                        = string<br>    subnet_region                    = string<br>    subnet_private_access            = optional(string)<br>    subnet_private_ipv6_access       = optional(string)<br>    subnet_flow_logs                 = optional(string)<br>    subnet_flow_logs_interval        = optional(string)<br>    subnet_flow_logs_sampling        = optional(string)<br>    subnet_flow_logs_metadata        = optional(string)<br>    subnet_flow_logs_filter          = optional(string)<br>    subnet_flow_logs_metadata_fields = optional(list(string))<br>    description                      = optional(string)<br>    purpose                          = optional(string)<br>    role                             = optional(string)<br>    stack_type                       = optional(string)<br>    ipv6_access_type                 = optional(string)<br>  }))</pre> | n/a | yes |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

### Subnet Inputs

The subnets list contains maps, where each object represents a subnet. Each map has the following inputs (please see examples folder for additional references):

| Name                         | Description                                                                                                     |  Type  |         Default          | Required |
| ---------------------------- | --------------------------------------------------------------------------------------------------------------- | :----: | :----------------------: | :------: |
| subnet\_name                 | The name of the subnet being created                                                                            | string |            -             |   yes    |
| subnet\_ip                   | The IP and CIDR range of the subnet being created                                                               | string |            -             |   yes    |
| subnet\_region               | The region where the subnet will be created                                                                     | string |            -             |   yes    |
| subnet\_private\_access      | Whether this subnet will have private Google access enabled                                                     | string |        `"false"`         |    no    |
| subnet\_private\_ipv6\_access| The private IPv6 google access type for the VMs in this subnet                                                  | string |            -             |    no    |
| subnet\_flow\_logs           | Whether the subnet will record and send flow log data to logging                                                | string |        `"false"`         |    no    |
| subnet\_flow\_logs\_interval | If subnet\_flow\_logs is true, sets the aggregation interval for collecting flow logs                           | string |    `"INTERVAL_5_SEC"`    |    no    |
| subnet\_flow\_logs\_sampling | If subnet\_flow\_logs is true, set the sampling rate of VPC flow logs within the subnetwork                     | string |         `"0.5"`          |    no    |
| subnet\_flow\_logs\_metadata | If subnet\_flow\_logs is true, configures whether metadata fields should be added to the reported VPC flow logs | string | `"INCLUDE_ALL_METADATA"` |    no    |
| subnet\_flow\_logs\_filter | Export filter defining which VPC flow logs should be logged, see https://cloud.google.com/vpc/docs/flow-logs#filtering for formatting details  | string | `"true"` |    no    |
| subnet\_flow\_logs\_metadata\_fields | List of metadata fields that should be added to reported logs. Can only be specified if VPC flow logs for this subnetwork is enabled and "metadata" is set to CUSTOM_METADATA.  | any | - |    no    |
| description                         | An optional description of this resource. Provide this property when you create the resource. This field can be set only at resource creation time  | string | - |    no    |
| purpose | The purpose of the subnet usage. Whether it is to be used as a regular subnet or for proxy or loadbalacing purposes, see https://cloud.google.com/vpc/docs/subnets#purpose for more details  | string | `"PRIVATE"` |    no    |
| role                         | The role of the subnet when using it as a proxy or loadbalancer network. Whether it is to be used as the active or as a backup subnet, see https://cloud.google.com/load-balancing/docs/proxy-only-subnets#proxy_only_subnet_create for more details  | string |            -             |    no    |
| stack\_type                  | `IPV4_ONLY` or `IPV4_IPV6` for dual-stack networking | string | - | no |
| ipv6\_access\_type           | `INTERNAL` or `EXTERNAL`. `INTERNAL` requires ULA be enabled on the VPC | string | - | no |

## Requirements
### Configure a Service Account
In order to execute this module you must have a Service Account with the following roles:

- roles/compute.networkAdmin on the organization or folder

If you are going to manage a Shared VPC, you must have either:

- roles/compute.xpnAdmin on the organization
- roles/compute.xpnAdmin on the folder (beta)

### Enable API's
In order to operate with the Service Account you must activate the following API on the project where the Service Account was created:

- Compute Engine API - compute.googleapis.com


# Google Cloud Shared VPC Access Configuration

This module allows configuring service project access to a Shared VPC, created with the top-level network module. The module allows:

- attaching service projects to the Shared VPC host project
- assigning IAM roles for each Shared VPC subnet

The resources created/managed by this module are:

- one `google_compute_shared_vpc_service_project` resource for each project where full VPC access is needed
- one `google_compute_subnetwork_iam_binding` for each subnetwork where individual subnetwork access is needed



<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| host\_project\_id | Project id of the shared VPC host project. | `string` | n/a | yes |
| host\_service\_agent\_role | Assign host service agent role to users in host\_service\_agent\_users variable. | `bool` | `false` | no |
| host\_service\_agent\_users | List of IAM-style users that will be granted the host service agent role on the host project. | `list(string)` | `[]` | no |
| host\_subnet\_regions | List of subnet regions, one per subnet. | `list(string)` | `[]` | no |
| host\_subnet\_users | Map of comma-delimited IAM-style members to which network user roles for subnets will be assigned. | `map(any)` | `{}` | no |
| host\_subnets | List of subnet names on which to grant network user role. | `list(string)` | `[]` | no |
| service\_project\_ids | Ids of the service projects that will be attached to the Shared VPC. | `list(string)` | n/a | yes |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

