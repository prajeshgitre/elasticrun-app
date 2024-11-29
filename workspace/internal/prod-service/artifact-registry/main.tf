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

# Module to create VM
module "artifact_registry" {
  source = "../../../../modules/terraform-google-artifact-registry"
  providers = {
    google      = google.project
    google-beta = google-beta.project-beta
  }
  for_each    = { for i in var.artifact_registry : i.id => i }
  project_id  = each.value.project_id
  location    = each.value.location
  description = each.value.description
  format      = each.value.format
  id          = each.value.id
  labels      = each.value.labels
  iam         = each.value.iam
}
