require 'dm-core'
require 'dm-migrations'
require './lib/markeline'

# use env variable DB_URL to change database
DataMapper.setup( :default, ENV['DB_URL'] || 'mysql://root@localhost/chtshtdb' )

class Clipping
  include DataMapper::Resource
  include Markeline

  property :id                , Serial
  property :title             , String
  property :content           , Text
  property :content_markelined, Text

  before :save do
    self.content_markelined = content_as_html
  end

  def content_as_html
    Markeline.to_html(content)
  end

end

DataMapper.auto_upgrade!
DataMapper.finalize

