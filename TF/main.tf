provider "aws" {
  region = var.aws_region
}

# Key Pair for SSH Access
resource "aws_key_pair" "my_key_pair" {
  key_name   = "my-key-pair"
  public_key = file("~/.ssh/my-key-pair.pub") # Update with the path to your public SSH key
}
