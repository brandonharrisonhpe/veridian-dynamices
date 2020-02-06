pid_file = "./pidfile"

vault {
   address = "http://3.91.104.217:8200"
}

auto_auth {
   method "aws" {
       mount_path = "auth/aws"
       config = {
           type = "iam"
           role = "dev-role-iam"
       }
   }

   sink "file" {
       config = {
           path = "/opt/vault-agent/vault-token-via-agent"
       }
   }
}

cache {
  use_auto_auth_token = true
}

listener "tcp" {
  address = "127.0.0.1:8200"
  tls_disable = true
}

template {
  source = "/opt/vault-agent/template.ctmpl"
  destination = "/opt/flask/mysqldbcreds.json"
}
