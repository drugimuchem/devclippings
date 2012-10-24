require 'dm-core'
require 'dm-migrations'
require './lib/markeline'

# use env variable DM_SETUP for custom DB for DataMapper 
DataMapper.setup( :default, ENV['DB_URL'] || 'mysql://root@localhost/chtshtdb' )

class Clipping
  include DataMapper::Resource
  include Markeline

  property :id     , Serial
  property :title  , String
  property :content, Text

  def content_as_html
    Markeline.to_html(content)
  end
end

DataMapper.auto_upgrade!
DataMapper.finalize

