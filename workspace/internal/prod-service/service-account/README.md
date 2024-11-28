# Terraform  Shared Service Service Accounts Module

This module allows easy creation of one or more service accounts, and granting them basic roles.

The resources/services/activations/deletions that this module will create/trigger are:

- one or more service accounts

## Usage

Basic usage of this module is as follows:

```hcl
module "service_accounts" {
  source        = "../../../modules/terraform-google-service-account"
  version       = "~> 3.0"
  project_id    = "<PROJECT ID>"
  prefix        = "test-sa"
  names         = ["first", "second"]
  project_roles = [
    "project-foo=>roles/viewer",
    "project-spam=>roles/storage.objectViewer",
  ]
}
```
## Creation of service account from tfvars
```hcl
service_accounts_list = [
  {
    project_id    = "wiai-bootstrap-seed"
    prefix        = ""
    display_name  = "svcacct-bootstrap-seed-jenkins"
    names         = ["svcacct-bootstrap-seed-jenkins"] 
    project_roles = []
  },
]
```
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| billing\_account\_id | If assigning billing role, specificy a billing account (default is to assign at the organizational level). | `string` | `""` | no |
| description | Default description of the created service accounts (defaults to no description) | `string` | `""` | no |
| descriptions | List of descriptions for the created service accounts (elements default to the value of `description`) | `list(string)` | `[]` | no |
| display\_name | Display names of the created service accounts (defaults to 'Terraform-managed service account') | `string` | `"Terraform-managed service account"` | no |
| generate\_keys | Generate keys for service accounts. | `bool` | `false` | no |
| grant\_billing\_role | Grant billing user role. | `bool` | `false` | no |
| grant\_xpn\_roles | Grant roles for shared VPC management. | `bool` | `true` | no |
| names | Names of the service accounts to create. | `list(string)` | `[]` | no |
| org\_id | Id of the organization for org-level roles. | `string` | `""` | no |
| prefix | Prefix applied to service account names. | `string` | `""` | no |
| project\_id | Project id where service account will be created. | `string` | n/a | yes |
| project\_roles | Common roles to apply to all service accounts, project=>role as elements. | `list(string)` | `[]` | no |


<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

### IAM

Service account or user credentials with the following roles must be used to provision the resources of this module:

- Service Account Admin: `roles/iam.serviceAccountAdmin`
- (optional) Service Account Key Admin: `roles/iam.serviceAccountKeyAdmin` when `generate_keys` is set to `true`
- (optional) roles needed to grant optional IAM roles at the project or organizational level
