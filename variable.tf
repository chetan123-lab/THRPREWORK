variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-2"
}

variable "bucket_name" {
  description = "S3 bucket name"
  type        = string
  default     = "my-dev-bucket"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
}

variable "vpc_cidr_block" {
  type        = string
  default     = "10.0.0.0/16"
  description = "The CIDR block for the VPC"
}

variable "vpc_name" {
  type        = string
  default     = "example-vpc"
  description = "The name of the VPC"
}

variable "subnet_cidr_block" {
  type        = string
  default     = "10.0.1.0/24"
  description = "The CIDR block for the subnet"
}

variable "subnet_name" {
  type        = string
  default     = "example-subnet"
  description = "The name of the subnet"
}

variable "availability_zone" {
  type        = string
  default     = "us-west-2a"
  description = "The availability zone for the subnet"
}

variable "igw_name" {
  type        = string
  default     = "example-igw"
  description = "The name of the internet gateway"
}

variable "route_table_name" {
  type        = string
  default     = "example-rt"
  description = "The name of the route table"
}

variable "sg_name" {
  type        = string
  default     = "example-sg"
  description = "The name of the security group"
}

variable "sg_description" {
  type        = string
  default     = "Allow all inbound and outbound traffic"
  description = "The description of the security group"
}

variable "key_name" {
  type        = string
  default     = "example-key"
  description = "The name of the key pair"
}

variable "public_key_path" {
  type        = string
  default     = "~/.ssh/id_rsa.pub"
  description = "The path to the public key file"
}

variable "instance_count" {
  type        = number
  default     = 2
  description = "The number of EC2 instances to create"
}

variable "ami_id" {
  type        = string
  default     = "ami-0c55b159cbfafe1f0"
  description = "The ID of the AMI"
}

variable "instance_type" {
  type        = string
  default     = "t2.micro"
  description = "The type of the EC2 instance"
}

variable "instance_name" {
  type        = string
  default     = "example-ec2"
  description = "The name of the EC2 instance"
}

variable "cluster_identifier" {
  type        = string
  description = "The identifier for the Redshift cluster"
}

variable "database_name" {
  type        = string
  description = "The name of the database"
}

variable "master_username" {
  type        = string
  description = "The master username for the Redshift cluster"
}

variable "master_password" {
  type        = string
  description = "The master password for the Redshift cluster"
  sensitive   = true
}

variable "node_type" {
  type        = string
  description = "The node type for the Redshift cluster"
}

variable "cluster_type" {
  type        = string
  description = "The cluster type for the Redshift cluster"
}


variable "publicly_accessible" {
  type        = bool
  description = "Whether the Redshift cluster is publicly accessible"
}

variable "skip_final_snapshot" {
  type        = bool
  description = "Whether to skip the final snapshot"
}




