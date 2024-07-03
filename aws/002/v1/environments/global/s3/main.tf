resource "aws_s3_bucket" "artifacts" {
  bucket = "antonputra-artifacts"

  tags = {
    Name = "Artifacts"
  }
}
