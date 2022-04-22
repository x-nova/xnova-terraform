#The designated project that owns this infra eg. verified, bioregistra
project = "novawallet"

#The environment where the infra will be povisioned
environment = "dev"

#The name of the service to which this infra will be provisioned for
project_component = "discovery"

#Boolean that indicates if this is a new project
new_project = false

#The tech or runtime for the service eg. jaava, node, etc
tech = "java"

#The git repository url for the service
code_repo = "https://github.com/x-nova/nova-service-discovery.git"

#The repo ID, which is typically the appended context behind the github base url. eg. "seamfix/nibbs-mock-service"
repo_id = "x-nova/nova-service-discovery"

#The health check grace period in seconds, set this to a higher value if the service startup time is long, and less if the startup time is lesser
health_check_grace_period_seconds = "60"

#The health check endpoint for the microservice being deployed
health_check_path = "/api/discovery/actuator/health"

#The base context path for the service
listener_rule_pattern = ["/api/discovery*"]

#The port number for the service
container_port = 8672

#For DevOps use
elb_arn     = "arn:aws:elasticloadbalancing:us-east-1:437622698243:loadbalancer/app/dev-novawallet-lb/5330ea0fdc7d5f3a"
vpc_id      = "vpc-0b85e0da060bd3a71"
task_cpu    = "256"
task_memory = "512"
access_key  = "AKIAWLZCYOEBQQMEUZHZ"
region      = "us-east-1"
