Rack::Utils.multipart_part_limit = 0
if Rails.env.test? or Rails.env.cucumber?
  CarrierWave.configure do |config|
    config.storage = :file
    config.enable_processing = false
    config.store_dir = 'uploads'
    config.cache_dir = '/tmp/mmelection'
  end
else
  CarrierWave.configure do |config|
    config.storage = :fog
    config.fog_credentials = {
      provider:               'AWS',
      aws_access_key_id:      ENV["S3_ACCESS_KEY"],
      aws_secret_access_key:  ENV["S3_SECRET_KEY"],
      region:                 ENV["S3_REGION"],
    }
    config.fog_directory  = ENV["S3_BUCKET"]
    config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}
    config.store_dir = nil
    config.cache_dir = File.join(Rails.root, 'public', 'uploads')
  end
end
