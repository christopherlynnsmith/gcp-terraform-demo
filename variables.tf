variable "project_id" {
  description = "Google Project ID."
  type        = string
  default     = "seed-390122"
}

# groups configuration variables
variable "devops_display_name" {
  description = "group display name"
  type        = string
  default     = ""
}

variable "devops_description" {
  description = "group description"
  type        = string
  default     = ""
}

variable "devops_initial_group_config" {
  description = "group description"
  type        = string
  default     = "WITH_INITIAL_OWNER"
}


variable "cloud_identity_org_parent" {
  description = "group description"
  type        = string
  default     = "customers/C00n10ucq"
}

variable "devops_principal" {
  description = "group description"
  type        = string
  default     = "devops@globalmatchpassport.com"
}

# security groups

# groups configuration variables
variable "security_display_name" {
  description = "group display name"
  type        = string
  default     = ""
}


variable "security_group_principal" {
  description = "group description"
  type        = string
  default     = "security-viewers@globalmatchpassport.com"
}


variable "devops_engineer_users" {
    type    = list(string)
    default = ["tariq@globalmatchpassport.com", "jarrett@globalmatchpassport.com"]
    description = "list of engineers"
}



variable "groupsMetaData" {

  description = "groups data"

  type =map (

    object(

      {
          display_name  = string
          description   = string
          principal = string
      }))
      default = {

        developers = {
          display_name  = "developers"
          description   = "testdescription"
          principal = "developers@globalmatchpassport.com"

        },

        engineers = {
          display_name  = "engineers"
          description   = "testdescription"
          principal = "engineers@globalmatchpassport.com"

        },
        data-scientists = {
          display_name  = "data-scientists"
          description   = "testdescription"
          principal = "data-scientists@globalmatchpassport.com"

        },
        pipeline-admins = {
          display_name  = "pipeline-admins"
          description   = "testdescription"
          principal = "pipeline-admins@globalmatchpassport.com"

        },
        network-operations = {
          display_name  = "network-operations"
          description   = "testdescription"
          principal = "network-operations@globalmatchpassport.com"

        },        
        info-security = {
          display_name  = "info-security"
          description   = "testdescription"
          principal = "info-security@globalmatchpassport.com"

        }

      }
}


variable "groupMembers" {

  description = "groups data"

  type =map (

    object(

      {
          member  = string
          group_name   = string
        }))
      default = {

        m1 = {
          member= "csmith@globalmatchpassport.com"
          group_name  = "developers"

        },

        m2 = {
          member= "csmith@globalmatchpassport.com"
          group_name  = "engineers"          
 
  
        },
        m3 = {
          member= "csmith@globalmatchpassport.com"
          group_name  = "data-scientists"


        },
        m4 = {
          member= "csmith@globalmatchpassport.com"          
          group_name  = "pipeline-admins"
  

        },
        m5= {
          member= "csmith@globalmatchpassport.com"          
          group_name  = "network-operations"

        },        
        m6= {
          member= "csmith@globalmatchpassport.com"
          group_name  = "info-security"

        }

      }
}