


# VPC Setup with Terraform

## Objective

1. **Design and set up a Virtual Private Cloud (VPC)** with both public and private subnets using Terraform in the AWS EU-West-1 (Ireland) region.
2. **Create separate child modules** for resources and reference them in your root module for readability and reusability.
3. **Write a script** to install Nginx on an EC2 instance in the public subnet.
4. **Write a script** to install PostgreSQL on an EC2 instance in the private subnet.
5. **Clean up resources** on completion using `terraform destroy`.

## Requirements

- VPC: ```KCVPC```, IPv4 CIDR block: ```10.0.0.0/16```
- Public Subnet: ```PublicSubnet```, IPv4 CIDR block: ```10.0.1.0/24```
- Private Subnet: ```PrivateSubnet```, IPv4 CIDR block: ```10.0.2.0/24```
- Internet Gateway: ```KCVPC-IGW```
- NAT Gateway: ```KCVPC-NAT-Gateway```
- Security Groups: ```PublicSecurityGroup```, ```PrivateSecurityGroup```
- Network ACLs: ```PublicSubnetNACL```, ```PrivateSubnetNACL```
- Instances: ```PublicInstance```, ```PrivateInstance```


### 1. Create a VPC
- **Name:** KCVPC
- **IPv4 CIDR block:** 10.0.0.0/16

![VPC Creation Screenshot](practical_screenshots/terraformtask_KCVPC%201%20-%20Terraform%20init.PNG)
![VPC Creation Screenshot](practical_screenshots/terraformtask_KCVPC%204%20-%20Created%20the%20VPC%20using%20terraform.PNG)

### 2. Create Subnets

#### Public Subnet
- **Name:** PublicSubnet
- **IPv4 CIDR block:** 10.0.1.0/24
- **Availability Zone:** eu-west-1 in my case [select yours]


#### Private Subnet
- **Name:** PrivateSubnet
- **IPv4 CIDR block:** 10.0.2.0/24
- **Availability Zone:** eu-west-1 in my case. [Select yours]


### 3. Configure an Internet Gateway (IGW)
- **Create and attach an IGW** to KCVPC.


### 4. Configure Route Tables

#### Public Route Table
- **Name:** PublicRouteTable
- **Associate** with PublicSubnet.
- **Route:** 0.0.0.0/0 -> IGW


#### Private Route Table
- **Name:** PrivateRouteTable
- **Associate** with PrivateSubnet.
- **Route:** 0.0.0.0/0 -> NAT Gateway


### 5. Configure NAT Gateway
- **Create a NAT Gateway** in the PublicSubnet.
- **Allocate an Elastic IP** for the NAT Gateway.
- **Update PrivateRouteTable** to route internet traffic to the NAT Gateway.


### 6. Set Up Security Groups

#### Security Group for Public Instances
- **Allow inbound HTTP (port 80)** and **HTTPS (port 443)** from anywhere (0.0.0.0/0).
- **Allow inbound SSH (port 22)** from a specific IP (e.g., your local IP).
- **Allow all outbound traffic.**

#### Security Group for Private Instances
- **Allow inbound traffic from the PublicSubnet** on required ports (e.g., PostgreSQL port and SSH port).
- **Allow all outbound traffic.**


### 7. Network ACLs

#### Public Subnet NACL
- **Allow inbound HTTP, HTTPS, and SSH traffic.**
- **Allow outbound traffic.**


#### Private Subnet NACL
- **Allow inbound traffic from the public subnet.**
- **Allow outbound traffic** to the public subnet and the internet.




### 8. Deploy Instances

#### Public Subnet EC2 Instance
- **Use the public security group.**
- **Verify that the instance can be accessed via the internet.**

![Public Instance running Screenshot](practical_screenshots/terraformtask_KCVPC%205_2%20-%20%20%20public%20instance%20running%20using%20terraform.PNG)

#### Private Subnet EC2 Instance
- **Use the private security group.**
- **Verify that the instance can access the internet** through the NAT Gateway and communicate with the public instance.

![Private Instance running Screenshot](practical_screenshots/terraformtask_KCVPC%205_1%20-%20%20%20private%20instance%20running%20using%20terraform.PNG)

### Other necessary screenshots (named)

![Terraform Plan Screenshot](practical_screenshots/terraformtask_KCVPC%202%20-%20Terraform%20plan%20in%20a%20text%20file.PNG)

![Terraform apply completed Screenshot](practical_screenshots/terraformtask_KCVPC%203_1%20-%20Terraform%20apply%20command%20complete.PNG)

![SSH into the public instance screenshot](practical_screenshots/terraformtask_KCVPC%206%20-%20I%20SSH%20into%20my%20public%20instance.PNG)

![SSH into the private instance from the public instance](practical_screenshots/terraformtask_KCVPC%206%20-%20I%20SSH%20into%20my%20private%20instance%20from%20my%20public%20instance.PNG)


![Terraform Destroy running Screenshot](practical_screenshots/terraformtask_KCVPC%2010%20-%20Cleaned%20up%20my%20resources%20using%20terraform%20destroy.PNG)

## Deliverables

1. **Detailed report** with screenshots of each step which is above.
2. **Output of `terraform plan`**: 

```bash
terraform plan -out=tfplan.json
```
or

```bash
terraform plan -out=tfplan.txt
```
![Terraform Plan screenshot](practical_screenshots/terraformtask_KCVPC%202%20-%20Terraform%20plan%20in%20a%20text%20file.PNG)


## Cleanup

Run the following command to destroy all resources:

```bash
terraform destroy
```

![Terraform Destroy running Screenshot](practical_screenshots/terraformtask_KCVPC%209%20-%20Cleaning%20up%20my%20resources%20using%20terraform%20destroy.PNG)


![Terraform Destroy completed Screenshot](practical_screenshots/terraformtask_KCVPC%2010%20-%20Cleaned%20up%20my%20resources%20using%20terraform%20destroy.PNG)


