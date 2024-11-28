/*
 * Copyright 2023 Niveus Solutions Pvt. Ltd.
 *
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
locals {
  filtered_vms = [for x in var.list_of_vms : x if x.static_ip_name != null]
}
data "google_compute_address" "ip" {
  provider = google.project
  for_each = { for x in local.filtered_vms : x.instance_name => x }
  project  = each.value.project_id
  region   = each.value.network_interface.0.nic_subnetwork_region
  name     = each.value.static_ip_name
}
# Module to create VM
module "compute_instance" {
  providers = {
    google      = google.project
    google-beta = google-beta.project-beta
  }
  for_each                  = { for x in var.list_of_vms : x.instance_name => x }
  source                    = "../../../../modules/terraform-google-vm/compute_instance"
  project_id                = each.value.project_id
  zone                      = each.value.zone
  source_image              = each.value.source_image
  machine_type              = each.value.machine_type
  hostname                  = ""
  boot_disk_type            = each.value.boot_disk_type
  boot_size                 = each.value.boot_size == null ? 10 : each.value.boot_size
  boot_auto_delete          = each.value.boot_auto_delete
  deletion_protection       = each.value.deletion_protection
  tags                      = each.value.tags
  svc_account_id            = each.value.svc_account_id
  instance_name             = each.value.instance_name
  network_interface         = each.value.network_interface
  nic0_network_ip           = each.value.static_ip_name != null ? data.google_compute_address.ip[each.value.instance_name].address : ""
  labels                    = each.value.labels
  can_ip_forward            = false
  additional_disks          = each.value.additional_disks == null ? [] : each.value.additional_disks
  allow_stopping_for_update = true
  enable_secure_boot        = each.value.enable_secure_boot
  depends_on                = [data.google_compute_address.ip]
}