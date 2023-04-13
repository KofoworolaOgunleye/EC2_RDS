## EC2_RDS

### How would a future application obtain the load balancers’ DNS name if it wanted to use this service?
---
The load balancer DNS name can be outputted on the terminal by using the output variable or by using data resource and can be passed to another resource by getting the value from terraform remote state file when remote storage is used to store the statefile.
`E.g data.terraform_remote_state.alb.outputs.dns_name`

```
data "aws_lb" "test" { 
    arn = var.lb_arn
 } 

data.aws_lb.test.dns_name
```

### What aspect needs to be considered to make the terraform code work in a CD pipeline?
---
One thing to consider if there are multiple people working on the same terraform code is a remote backend to store the state file and a locking mechanism to ensure the state files are locked when terraform operations (plan,apply,destroy) are performed. This is done because race conditions may cause the file to be corrupted. AWS services like S3 and Dynamodb can be used.

Another thing to consider is the number of environments being deployed to. CI/CD implies it's being deployed to, for example, a dev/stage/prod environment and the pipeline should deploy to the right environment at the right time. Different CIDR ranges, resource names etc across different environments should be considered and this can be done via variables and modules.

## How does the terraform code successfully and safely get into production?
---
By going through multiple stages of the pipeline with relevant testing completed along the way i.e Deploy to development, run all testing to ensure the code works the way it is expected to before continuing to staging which mirrors production and catches bugs before it is pushed to production. If any tests fail before reaching the production environment, the deployment is stopped until the fault is fixed.

### [Architecture Diagram](/cint.drawio.png)

## Deployment Instructions
---
- To Deploy:`cd/dev` and run `make deploy`
- To destroy: `make destroy`