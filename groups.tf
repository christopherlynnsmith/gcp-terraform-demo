resource "google_cloud_identity_group" "cloud_identity_group_basic" {
  display_name         = var.devops_display_name
  description          = var. devops_description
  initial_group_config = var.devops_initial_group_config

# value from Account >> Account Settings
# https://admin.google.com/u/1/ac/accountsettings/profile?hl=en

  parent =  var.cloud_identity_org_parent

  group_key {
      id = var.devops_principal
  }

  labels = {
    "cloudidentity.googleapis.com/groups.discussion_forum" = ""
  }
}

# group for security viewer
resource "google_cloud_identity_group" "cloud_identity_security_viewer_group" {
  display_name         = var.security_display_name
  description          = var.security_description
  initial_group_config = var.devops_initial_group_config


# value from Account >> Account Settings
# https://admin.google.com/u/1/ac/accountsettings/profile?hl=en

  parent = var.cloud_identity_org_parent

  group_key {
      id = var.security_group_principal
  }

  labels = {
    "cloudidentity.googleapis.com/groups.discussion_forum" = ""
  }
}


resource "google_cloud_identity_group_membership" "cloud_identity_group_membership_basic" {

    for_each = toset( var.devops_engineer_users)


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