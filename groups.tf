resource "google_cloud_identity_group" "cloud_identity_group_basic" {
  display_name         = "devOps group"
  description          = "devOps group working on cloud platform"
  initial_group_config = "WITH_INITIAL_OWNER"

# value from Account >> Account Settings
# https://admin.google.com/u/1/ac/accountsettings/profile?hl=en

  parent = "customers/C00n10ucq"

  group_key {
      id = "devops@globalmatchpassport.com"
  }

  labels = {
    "cloudidentity.googleapis.com/groups.discussion_forum" = ""
  }
}

# group for security viewer
resource "google_cloud_identity_group" "cloud_identity_security_viewer_group" {
  display_name         = "security viewers group"
  description          = "security viewers group - read only"
  initial_group_config = "WITH_INITIAL_OWNER"

# value from Account >> Account Settings
# https://admin.google.com/u/1/ac/accountsettings/profile?hl=en

  parent = "customers/C00n10ucq"

  group_key {
      id = "security-viewers@globalmatchpassport.com"
  }

  labels = {
    "cloudidentity.googleapis.com/groups.discussion_forum" = ""
  }
}


resource "google_cloud_identity_group_membership" "cloud_identity_group_membership_basic" {

    for_each = toset([
    "tariq@globalmatchpassport.com", 
    "jarrett@globalmatchpassport.com"
  ])


  group    = google_cloud_identity_group.cloud_identity_group_basic.id

  preferred_member_key {
    id = each.value
  }

  roles {
    name = "MEMBER"
  }

  #roles {
  #  name = "MANAGER"
  #}
}


# add roles to group for the seed project

resource "google_project_iam_member" "project_service_identity_roles" {
 

  project = var.project_id
  role    = "roles/editor"
  member  = "group:devops@globalmatchpassport.com"
}


resource "google_project_iam_member" "project_service_storage_admin_roles" {
 
 depends_on = [
    google_cloud_identity_group.cloud_identity_group_basic
  ]

  project = var.project_id
  role    = "roles/storage.admin"
  member  = "group:devops@globalmatchpassport.com"
}


/*
# associate the security group to the gcp organization
resource "google_organization_iam_member" "organization" {

   depends_on = [
    google_cloud_identity_group.cloud_identity_group_basic
  ]


  org_id  = "920033224664"
  role    = "roles/viewer"
  member  = "group:security-viewers@globalmatchpassport.com"
}
*/