if Rails.env.production?
  CarrierWave.configure do |config|
    config.fog_credentials = {
      # Configuration for Amazon S3
      # Have to record the access key and the secret key when first creating
      # a user because cannot find the secret key again - I have emailed to myself
      :provider              => 'AWS',
      :aws_access_key_id     => ENV['S3_ACCESS_KEY'],
      :aws_secret_access_key => ENV['S3_SECRET_KEY'],
      :region                => ENV['S3_REGION']
    }
    config.fog_directory     =  ENV['S3_BUCKET']
  end
end