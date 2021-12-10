# aws-nginx-api-gateway

This project come to demonstarte how to access web-application in private subnet (without internet access) with API-Gateway throug Application Load Balancer.
https://medium.com/swlh/aws-api-gateway-private-integration-with-http-api-and-a-vpc-link-602360a1cd84

### Export your AWS-CLI credientials:
```
export AWS_ACCESS_KEY_ID=xxxxxxxxxxxxxxx
export AWS_SECRET_ACCESS_KEY=xxxxxxxxxxxxxxx
export AWS_DEFAULT_REGION=us-east-1
```

### Installing Terraform 
To deploy this tasks's infrastrucure, you need to install Terraform on your local machine:
https://learn.hashicorp.com/tutorials/terraform/install-cli

Ensure that your system is up to date, and you have the gnupg, software-properties-common, and curl packages installed. You will use these packages to verify HashiCorp's GPG signature, and install HashiCorp's Debian package repository. <br/>

```
sudo apt-get update && sudo apt-get install -y gnupg software-properties-common curl
```

Add the HashiCorp GPG key. <br/>

```
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
```

Add the official HashiCorp Linux repository. <br/>

```
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
```

Update to add the repository, and install the Terraform CLI. <br/>

```
sudo apt-get update && sudo apt-get install terraform
```

Verify that the installation worked by opening a new terminal session and listing Terraform's available subcommands. <br/>

```
terraform -help
```

### Apply the infrastructure
Navigate to the "terraform" folder. <br/>

```
cd terraform/
```

type "terraform plan" <br/>
```
terraform plan
```

type "terraform apply" <br/>
```
terraform apply -auto-approve
```

wait to the process to finish.

### Access the web
Go to API-Gateway in AWS console, click on "app-http-api" and click on the "Invoke URL" <br/>

<p align="center">
  <img src="https://github.com/coheneria/aws-nginx-api-gateway/blob/main/files/photos/api.png" width="100%" height="100%" />
</p>

<p align="center">
  <img src="https://github.com/coheneria/aws-nginx-api-gateway/blob/main/files/photos/result.png" width="100%" height="100%" />
</p>

### Destroy the infrastructure
type "terraform destroy" <br/>
```
terraform destroy -auto-approve
```