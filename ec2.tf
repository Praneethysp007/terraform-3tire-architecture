resource "aws_instance" "nop1" {
  ami             = data.aws_ami.ubuntu.id
  instance_type   = var.instance_type
  subnet_id       = aws_subnet.nop-subnets[2].id
  security_groups = [aws_security_group.app-sg.id]
  key_name        = "ysp"
  depends_on      = [aws_nat_gateway.nat-1, aws_nat_gateway.nat-2]
  
  connection {
    type = "ssh"
    user = "ubuntu"
    private_key = file("/home/ubuntu/id_rsa")
    host = self.public_ip
  }
  provisioner "file" {
    source = "nopcommerce.yaml"
    destination = "/home/ubuntu/nopcommerce.yaml"
  }
  provisioner "file" {
    source = "default"
    destination = "/home/ubuntu/default"
    
  }
  provisioner "file" {
    source = "nopCommerce.service"
    destination = "/home/ubuntu/nopCommerce.service"
    
  }
  provisioner "file" {
    source = "hosts"
    destination = "/home/ubuntu/hosts"
    
  }
  provisioner "remote-exec" {
    inline = [ 
      "sudo apt update",
      "sudo apt install software-properties-common",
      "sudo add-apt-repository --yes --update ppa:ansible/ansible",
      "sudo apt install ansible -y",
      "ansible-playbook -i hosts nopcomeerce.yaml"
     ]
  }

}
resource "aws_instance" "nop2" {
  ami             = data.aws_ami.ubuntu.id
  instance_type   = var.instance_type
  subnet_id       = aws_subnet.nop-subnets[3].id
  security_groups = [aws_security_group.app-sg.id]
  key_name        = "ysp"
  depends_on      = [aws_nat_gateway.nat-1, aws_nat_gateway.nat-2]

    connection {
    type = "ssh"
    user = "ubuntu"
    private_key = file("/home/ubuntu/id_rsa")
    host = self.public_ip
  }
  provisioner "file" {
    source = "/home/ubuntu/terraform-3tire-architecture/nopcommerce.yaml"
    destination = "/home/ubuntu/nopcommerce.yaml"
  }
  provisioner "file" {
    source = "/home/ubuntu/terraform-3tire-architecture/default"
    destination = "/home/ubuntu/default"
    
  }
  provisioner "file" {
    source = "/home/ubuntu/terraform-3tire-architecture/nopCommerce.service"
    destination = "/home/ubuntu/nopCommerce.service"
    
  }
  provisioner "file" {
    source = "/home/ubuntu/terraform-3tire-architecture/hosts"
    destination = "/home/ubuntu/hosts"
    
  }
  provisioner "remote-exec" {
    inline = [ 
      "sudo apt update",
      "sudo apt install software-properties-common",
      "sudo add-apt-repository --yes --update ppa:ansible/ansible",
      "sudo apt install ansible -y",
      "ansible-playbook -i hosts nopcommerce.yaml"
     ]
  }

}
resource "aws_instance" "bastion" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = var.instance_type
  associate_public_ip_address = true
  subnet_id                   = aws_subnet.nop-subnets[0].id
  security_groups             = [aws_security_group.app-sg.id]
  key_name                    = "ysp"
  depends_on                  = [aws_nat_gateway.nat-1, aws_nat_gateway.nat-2]

}


