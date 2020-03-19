Aws.config.update({
  region: 'ap-northeast-1',
  credentials: Aws::Credentials.new(ENV['S3_ACCESS_KEY'], ENV['S3_SECRET_KEY']),
})
