variable "vpc_cidr" {
  description = "value of vpc cidr"
  type        = string
  default     = "10.0.0.0/16"

}
variable "az" {
  description = "value of azs"
  type        = list(string)
  default     = ["us-east-2a", "us-east-2b", "us-east-2a", "us-east-2b", "us-east-2a", "us-east-2b"]

}
variable "subnet-names" {
  description = "value of subnet names"
  type        = list(string)
  default     = ["public-1", "public-2", "app-1", "app-2", "db-1", "db-2"]

}

variable "public-ip" {
  description = "value of subnet ip"
  type        = list(bool)
  default     = [true, true, false, false, false, false, ]

}
variable "publicip" {
  type    = list(bool)
  default = [true, false, true, false]

}

variable "spc-sg-rules" {
  type = object({
    name        = string
    description = string

    rules = list(object({
      type        = string
      from_port   = number
      to_port     = number
      protocol    = string
      cidr_blocks = string

    }))
  })

  default = {
    name        = "security_group"
    description = "this is sg of app"

    rules = [{
      type        = "ingress"
      from_port   = "22"
      to_port     = "22"
      protocol    = "tcp"
      cidr_blocks = "0.0.0.0/0"

      },
      {
        type        = "ingress"
        from_port   = "5000"
        to_port     = "5000"
        protocol    = "tcp"
        cidr_blocks = "0.0.0.0/0"
      },
      {
        type        = "ingress"
        from_port   = "80"
        to_port     = "80"
        protocol    = "tcp"
        cidr_blocks = "0.0.0.0/0"

      },
      {
        type        = "egress"
        from_port   = "0"
        to_port     = "65535"
        protocol    = "-1"
        cidr_blocks = "0.0.0.0/0"
      }

    ]
  }

}
variable "dbsecurityrule" {
  type = object({
    name        = string
    description = string
    rules = list(object({
      type        = string
      from_port   = number
      to_port     = number
      protocol    = string
      cidr_blocks = string
    }))
  })
  default = {
    name        = "dbsecurity"
    description = "this is security of db"
    rules = [{
      type        = "ingress"
      from_port   = 3306
      to_port     = 3306
      protocol    = "tcp"
      cidr_blocks = "0.0.0.0/0"
      },
      {
        type        = "egress"
        from_port   = 0
        to_port     = 65535
        protocol    = "tcp"
        cidr_blocks = "0.0.0.0/0"
      }
    ]
  }


}
variable "loadsecurityrule" {
  type = object({
    name        = string
    description = string
    rules = list(object({
      type        = string
      from_port   = number
      to_port     = number
      protocol    = string
      cidr_blocks = string
    }))
  })
  default = {
    name        = "loadbalncersecurity"
    description = "this is load balancer security"
    rules = [{
      type        = "ingress"
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = "0.0.0.0/0"
      },
      {
      type        = "ingress"
      from_port   = 5000
      to_port     = 5000
      protocol    = "tcp"
      cidr_blocks = "0.0.0.0/0"
      },
      {
        type        = "egress"
        from_port   = 0
        to_port     = 65535
        protocol    = "tcp"
        cidr_blocks = "0.0.0.0/0"
      }
    ]
  }


}

variable "ec2-names" {
  description = "value of ec2 names"
  type        = list(string)
  default     = ["nop-1", "nop-2"]

}
variable "instance_type" {
  description = "value of instance type"
  type        = string
  default     = "t2.micro"

}
variable "aws_key_pair" {
  type    = string
  default = "~/.ssh/id_rsa"

}