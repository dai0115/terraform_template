# カスタマ〜マスターキーの生成
resource "aws_kms_key" "example" {
  description             = "Example Customer Master Key"
  enable_key_rotation     = true
  is_enabled              = true
  deletion_window_in_days = 20
}

# カスタマーマスターキーへのエイリアスを設定
resource "aws_kms_alias" "example" {
  name          = "alias/kms"
  target_key_id = aws_kms_key.example.id
}

output "kms_key_arn" {
  value = aws_kms_key.example.arn
}