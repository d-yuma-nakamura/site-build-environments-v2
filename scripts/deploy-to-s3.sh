#!/bin/bash

# エラー時にスクリプトを停止
set -e

# プロジェクト名の取得と確認
PROJECT=$1
if [ -z "$PROJECT" ]; then
  echo "エラー: プロジェクト名が指定されていません。"
  exit 1
fi

# バケット名、リージョン、アップロードディレクトリの変数の設定
BUCKET_NAME_PREFIX="site-build-environments-v2"
BUCKET_NAME="$BUCKET_NAME_PREFIX-$PROJECT"
REGION="ap-northeast-1"
UPLOAD_DIRECTORY="sites/$PROJECT/dist/"

# アップロードディレクトリの存在確認
if [ ! -d "$UPLOAD_DIRECTORY" ]; then
  echo "エラー: アップロードディレクトリが存在しません: $UPLOAD_DIRECTORY"
  exit 1
fi

# 既存バケットの確認
if aws s3api head-bucket --bucket "$BUCKET_NAME" >/dev/null 2>&1; then
  echo "バケットが既に存在しています。サイトを更新します。"
else
  echo "バケットが存在しません。新しいバケットを作成します。"

  # バケットの作成（バケットが存在しない場合）
  aws s3api create-bucket --bucket $BUCKET_NAME --region $REGION --create-bucket-configuration LocationConstraint=$REGION

  # パブリックアクセスの設定
  aws s3api put-public-access-block \
      --bucket $BUCKET_NAME \
      --public-access-block-configuration "BlockPublicAcls=false,IgnorePublicAcls=false,BlockPublicPolicy=false,RestrictPublicBuckets=false"

  # バケットポリシーの生成
  cat <<EOM > bucket-policy.json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "PublicReadGetObject",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::$BUCKET_NAME/*"
    }
  ]
}
EOM

  # 作成したポリシーをバケットに適用
  aws s3api put-bucket-policy --bucket $BUCKET_NAME --policy file://bucket-policy.json

  # 静的ウェブサイトホスティングの設定
  aws s3 website s3://$BUCKET_NAME/ --index-document index.html --error-document 404.html

  echo "バケットの作成と設定が完了しました。"
fi

# ファイルのアップロード
echo "ファイルをアップロード中: $UPLOAD_DIRECTORY -> s3://$BUCKET_NAME/"
aws s3 cp $UPLOAD_DIRECTORY s3://$BUCKET_NAME/ --recursive
echo "ファイルのアップロードが完了しました。"

# 生成されたポリシーファイルの削除
if [ -f "bucket-policy.json" ]; then
  rm bucket-policy.json
fi

echo "スクリプトが正常に終了しました。"
