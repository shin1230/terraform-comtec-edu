data "aws_subnet_ids" "EDUID"" {
  vpc_id = var.vpc_id
}

data "aws_subnet" "EDU" {
  for_each = data.aws_subnet_ids.EDUID.ids
  id       = each.value
}