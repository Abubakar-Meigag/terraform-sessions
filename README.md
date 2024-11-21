# **Terraform Infrastructure Deployment Project**

This project automates the creation of an AWS infrastructure using Terraform. The infrastructure includes a VPC, public and private subnets, an Internet Gateway, security groups, EC2 instances (web and database), and an S3 bucket.

---

## **Infrastructure Components**
1. **VPC**: A Virtual Private Cloud with a CIDR block of `10.0.0.0/16`.
2. **Subnets**:
   - Public Subnet: CIDR block `10.0.1.0/24`.
   - Private Subnet: CIDR block `10.0.2.0/24`.
3. **Internet Gateway**: Provides internet access for the public subnet.
4. **Route Table**: Routes internet traffic from the public subnet through the Internet Gateway.
5. **Security Groups**:
   - Web Security Group: Allows inbound traffic on ports 80 (HTTP) and 443 (HTTPS).
   - Database Security Group: Allows inbound traffic on port 22 (SSH).
6. **EC2 Instances**:
   - Web Instance: A public-facing instance running a basic web server.
   - Database Instance: A private instance with no internet access.
7. **S3 Bucket**: A secure bucket with public access blocked, not associated with any EC2 instance.

---

## **Prerequisites**
1. AWS CLI installed and configured with valid credentials.
2. Terraform installed (version 1.3+ recommended).
3. An IAM user or role with sufficient permissions to create the above AWS resources.

---

## **Setup Instructions**

### 1. **Clone the Repository**
```bash
git clone <repository-url>
cd <repository-folder>
```

### 2. **Initialize Terraform**
Initialize the Terraform environment to download the necessary providers and modules.
```bash
terraform init
```

### 3. **Validate the Configuration**
Ensure the configuration is valid.
```bash
terraform validate
```

### 4. **Plan the Infrastructure**
Generate an execution plan to preview the resources that Terraform will create.
```bash
terraform plan
```

### 5. **Apply the Configuration**
Deploy the infrastructure by applying the Terraform configuration. Type `yes` to confirm.
```bash
terraform apply
```

**Example Output**:
```bash
Apply complete! Resources: 14 added, 0 changed, 0 destroyed.

Outputs:
db_private_ip = "10.0.2.238"
s3_bucket_name = "db-storage-20241121193314796000000001"
web_public_ip = "51.24.36.34"
```

### 6. **Access the Resources**
- **Web Instance**: Navigate to the public IP (`web_public_ip`) in your browser to verify the web server.
- **Database Instance**: Access the private IP (`db_private_ip`) using SSH from a system within the VPC or a bastion host.
- **S3 Bucket**: The bucket is securely created and can be managed via the AWS Management Console or CLI.

### 7. **Destroy the Infrastructure**
To clean up and remove all resources, run:
```bash
terraform destroy
```
Type `yes` to confirm.

**Example Output**:
```bash
Destroy complete! Resources: 14 destroyed.
```

---

## **File Structure**
- **`main.tf`**: Contains the main Terraform configuration for the infrastructure.
- **`variables.tf`**: Stores configurable variables for the project.
- **`outputs.tf`**: Defines the outputs to display after the infrastructure is created.
- **`server-script.sh`**: A bash script to initialize the web server on the web instance.

---

## **Project Details**

### **Outputs**
- `web_public_ip`: The public IP of the web instance.
- `db_private_ip`: The private IP of the database instance.
- `s3_bucket_name`: The name of the created S3 bucket.

### **Variables**
- `region`: The AWS region to deploy resources (`default = "eu-west-2"`).
- `ami`: The Amazon Machine Image ID for EC2 instances.
- `instance_type`: The instance type for EC2 instances (`default = "t2.micro"`).
- CIDR blocks for VPC and subnets.

---

## **Notes**
1. Ensure your AWS account has sufficient limits for creating EC2 instances and associated resources.
2. Customize the `server-script.sh` file to install additional software or services on the web server.
3. Follow security best practices by reviewing the security group rules and IAM permissions.
