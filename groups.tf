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

/*
resource "google_cloud_identity_group_membership" "cloud_identity_group_membership_basic" {
  group    = google_cloud_identity_group.cloud_identity_group_basic.id

  preferred_member_key {
    id = "tariq@globalmatchpassport.com"
  }

  roles {
    name = "MEMBER"
  }

  #roles {
  #  name = "MANAGER"
  #}
}
*/

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

/*

resource "google_project_iam_custom_role" "my-custom-role" {
  role_id     = "myCustomRole"
  title       = "My Custom Role"
  description = "A description"
  permissions = ["iam.roles.list", "iam.roles.create", "iam.roles.delete"]
}
*/

# add roles to group for project

resource "google_project_iam_member" "project_service_identity_roles" {
 
    for_each = toset([
    "roles/owner",
    "roles/storage.admin"
  ])

  project = var.project_id
  role    = each.value
  member  = "group:devops@globalmatchpassport.com"
}

