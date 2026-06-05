# AWS VPC Infrastructure Automation using Terraform

## Project Overview

This project demonstrates the provisioning of a complete AWS networking environment using **Terraform Infrastructure as Code (IaC)**. The infrastructure is deployed in the **AWS Singapore Region (`ap-southeast-1`)** and follows cloud networking best practices by separating resources into **public** and **private** subnets.

The solution automates the creation of networking components, security controls, and compute resources, enabling repeatable and consistent infrastructure deployments.

---

## Objectives

The primary objectives of this project are:

* Automate AWS infrastructure provisioning using Terraform.
* Create a custom Virtual Private Cloud (VPC).
* Implement network segmentation using public and private subnets.
* Configure secure internet connectivity using an Internet Gateway.
* Manage traffic flow using Route Tables.
* Provision Ubuntu EC2 instances in both public and private subnets.
* Secure resources using AWS Security Groups.
* Demonstrate Infrastructure as Code (IaC) principles and DevOps best practices.

---

## Architecture Diagram

```text
                                    Internet
                                        │
                                        │
                                Internet Gateway
                                        │
                                        ▼
                              Public Route Table
                                        │
                 ┌──────────────────────┴──────────────────────┐
                 │                                             │
                 ▼                                             ▼
       Public Subnet (10.0.1.0/24)                 Private Subnet (10.0.2.0/24)
                 │                                             │
                 │                                             │
                 ▼                                             ▼
       Ubuntu EC2 Instance                          Ubuntu EC2 Instance
        (Public Access)                               (Private Access)
```

---

## Infrastructure Components

### 1. Virtual Private Cloud (VPC)

A custom VPC is created to provide an isolated networking environment for all resources.

| Property   | Value             |
| ---------- | ----------------- |
| Resource   | AWS VPC           |
| CIDR Block | 10.0.0.0/16       |
| Purpose    | Network Isolation |

**Benefits**

* Logical isolation from other AWS networks.
* Custom IP addressing scheme.
* Secure resource communication.

---

### 2. Internet Gateway

An Internet Gateway (IGW) is attached to the VPC to enable internet connectivity for resources located in the public subnet.

| Property   | Value            |
| ---------- | ---------------- |
| Resource   | Internet Gateway |
| Attachment | Custom VPC       |

**Purpose**

* Enables inbound and outbound internet traffic.
* Required for public-facing workloads.

---

### 3. Public Subnet

A public subnet is configured to host internet-accessible resources.

| Property             | Value               |
| -------------------- | ------------------- |
| CIDR Block           | 10.0.1.0/24         |
| Public IP Assignment | Enabled             |
| Accessibility        | Internet Accessible |

**Use Cases**

* Web Servers
* Bastion Hosts
* Public APIs
* Load Balancers

---

### 4. Private Subnet

A private subnet is created for internal workloads that should not be directly exposed to the internet.

| Property             | Value         |
| -------------------- | ------------- |
| CIDR Block           | 10.0.2.0/24   |
| Public IP Assignment | Disabled      |
| Accessibility        | Internal Only |

**Use Cases**

* Databases
* Application Servers
* Backend Services

---

### 5. Route Tables

#### Public Route Table

Configured with a default route to the Internet Gateway.

```text
Destination      Target
0.0.0.0/0        Internet Gateway
```

This allows resources in the public subnet to communicate with the internet.

#### Private Route Table

Contains only local VPC routing.

```text
Destination      Target
10.0.0.0/16      Local
```

This ensures resources remain isolated from direct internet access.

---

### 6. Security Group

The Security Group acts as a virtual firewall controlling inbound and outbound traffic.

#### Inbound Rules

| Protocol | Port | Source           | Purpose      |
| -------- | ---- | ---------------- | ------------ |
| TCP      | 22   | Administrator IP | SSH Access   |
| TCP      | 80   | 0.0.0.0/0        | HTTP Traffic |

#### Outbound Rules

| Protocol | Port | Destination |
| -------- | ---- | ----------- |
| All      | All  | 0.0.0.0/0   |

**Security Features**

* Restricts SSH access to authorized administrators.
* Allows web traffic for application hosting.
* Permits outbound internet access for updates and package installations.

---

### 7. EC2 Instances

#### Public EC2 Instance

An Ubuntu server deployed inside the public subnet.

| Property         | Value            |
| ---------------- | ---------------- |
| Operating System | Ubuntu 22.04 LTS |
| Instance Type    | t3.micro         |
| Network          | Public Subnet    |
| Public IP        | Enabled          |

**Purpose**

* Web Hosting
* Administrative Access
* Jump/Bastion Host

---

#### Private EC2 Instance

An Ubuntu server deployed inside the private subnet.

| Property         | Value            |
| ---------------- | ---------------- |
| Operating System | Ubuntu 22.04 LTS |
| Instance Type    | t3.micro         |
| Network          | Private Subnet   |
| Public IP        | Disabled         |

**Purpose**

* Database Server
* Backend Application Server
* Internal Services

---

## Project Structure

```text
terraform-aws-vpc-project/
│
├── provider.tf
├── variable.tf
├── terraform.tfvars
├── vpc.tf
├── security_group.tf
├── ec2.tf
├── output.tf
├── .terraform.lock.hcl
└── README.md
```

### File Description

| File              | Purpose                                    |
| ----------------- | ------------------------------------------ |
| provider.tf       | AWS provider configuration                 |
| variable.tf       | Variable definitions                       |
| terraform.tfvars  | Variable values                            |
| vpc.tf            | VPC, subnets, route tables, and networking |
| security_group.tf | Security group configuration               |
| ec2.tf            | EC2 instance provisioning                  |
| output.tf         | Terraform outputs                          |
| README.md         | Project documentation                      |

---

## Deployment Steps

### Clone Repository

```bash
git clone <repository-url>
cd terraform-aws-vpc-project
```

### Initialize Terraform

```bash
terraform init
```

### Validate Configuration

```bash
terraform validate
```

### Review Execution Plan

```bash
terraform plan
```

### Deploy Infrastructure

```bash
terraform apply
```

### Destroy Infrastructure

```bash
terraform destroy
```

---

## Terraform Outputs

Upon successful deployment, Terraform returns:

| Output            | Description                     |
| ----------------- | ------------------------------- |
| vpc_id            | VPC Identifier                  |
| public_subnet_id  | Public Subnet Identifier        |
| private_subnet_id | Private Subnet Identifier       |
| ec2_instance_id   | Public EC2 Instance Identifier  |
| db_instance_id    | Private EC2 Instance Identifier |

---

## Security Considerations

* SSH access should be restricted to trusted IP addresses.
* Avoid exposing unnecessary ports to the internet.
* Use separate security groups for web and database tiers in production.
* Store sensitive values using AWS Secrets Manager or Parameter Store.
* Enable VPC Flow Logs and CloudTrail for auditing.

---

## Future Enhancements

* NAT Gateway for private subnet internet access.
* Application Load Balancer (ALB).
* Auto Scaling Groups.
* Multi-AZ deployment.
* RDS deployment in private subnet.
* S3 backend for Terraform state management.
* Remote state locking using DynamoDB.
* CI/CD integration with GitHub Actions.

---

## Key Skills Demonstrated

* Infrastructure as Code (IaC)
* Terraform
* AWS Networking
* VPC Design
* EC2 Provisioning
* Security Group Configuration
* Route Table Management
* Cloud Security Fundamentals
* DevOps Automation

---

## Author

**Gokul**

B.Tech – Artificial Intelligence and Data Science

Cloud Computing | AWS | Terraform | DevOps | Infrastructure Automation

---

## License

This project is intended for educational, learning, and portfolio demonstration purposes.
