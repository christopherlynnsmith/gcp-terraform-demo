

resource "google_cloud_identity_group" "cloud_identity_group_basic" {

  for_each = var.groupsMetaData

  display_name         = each.value["display_name"]
  description          = each.value["description"]
  initial_group_config = var.devops_initial_group_config

# value from Account >> Account Settings
# https://admin.google.com/u/1/ac/accountsettings/profile?hl=en

  parent =  var.cloud_identity_org_parent

  group_key {
      id = each.value["principal"]
  }

  labels = {
    "cloudidentity.googleapis.com/groups.discussion_forum" = ""
  }
}

resource "google_cloud_identity_group_membership" "project_groups_membership" {
 
  for_each = var.groupMembers

  group = google_cloud_identity_group.cloud_identity_group_basic[each.value.group_name].id

 preferred_member_key {
    id = each.value.member
  }


  roles {
    name = "MEMBER"
  }
}

# add roles to group for the seed project

resource "google_project_iam_member" "project_service_identity_roles" {
 

  project = var.project_id
  role    = "roles/editor"
  member  = "group:engineers@globalmatchpassport.com"
}


resource "google_project_iam_member" "project_service_storage_admin_roles" {
 
 depends_on = [
    google_cloud_identity_group.cloud_identity_group_basic
  ]

  project = var.project_id
  role    = "roles/storage.admin"
  member  = "group:engineers@globalmatchpassport.com"
}
/*
# see https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_project_iam.html#google_project_iam_policy
resource "google_project_iam_policy" "project" {
  project     = "your-project-id"
  policy_data = data.google_iam_policy.admin.policy_data
}

data "google_iam_policy" "admin" {
  binding {
    role = "roles/editor"

    members = [
      "user:jane@example.com",
    ]
  }
}

*/

/*
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


*/

