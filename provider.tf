# Required if using User ADCs (Application Default Credentials) for Cloud Identity API.
provider "google-beta" {
  user_project_override = true
  billing_project       = "seed-390122"
  credentials = "seed-390122-839a39c28a06.json"
}

