# パブリックサブネットの作成
resource "aws_subnet" "public_0" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "10.0.0.0/24"
  map_public_ip_on_launch = true #このサブネットで起動したインスタンスに自動でパブリックIP振る
  availability_zone       = "ap-northeast-1a"
}

resource "aws_subnet" "public_1" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true #このサブネットで起動したインスタンスに自動でパブリックIP振る
  availability_zone       = "ap-northeast-1c"
}