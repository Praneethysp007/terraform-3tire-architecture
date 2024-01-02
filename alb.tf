resource "aws_lb" "nop" {
  name               = "nopcommerce"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.lb-sg.id]
  subnets            = [aws_subnet.nop-subnets[0].id, aws_subnet.nop-subnets[1].id]

  enable_deletion_protection = false


  tags = {
    Name = "nop-lb"
  }
  depends_on = [ aws_instance.nop1,aws_instance.nop2 ]
}
resource "aws_lb_target_group" "nop-tg" {
  name     = "nop-lb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.nopvpc.id

  health_check {
    path = "/"
    port = "traffic-port"
  }
}
resource "aws_lb_target_group_attachment" "target-1" {
  target_group_arn = aws_lb_target_group.nop-tg.arn
  target_id        = aws_instance.nop1.id
  port             = 80
}
resource "aws_lb_target_group_attachment" "target-2" {
  target_group_arn = aws_lb_target_group.nop-tg.arn
  target_id        = aws_instance.nop2.id
  port             = 80
}
resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.nop.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.nop-tg.arn
  }
}

output "lb-name" {
  value = aws_lb.nop.dns_name

}







