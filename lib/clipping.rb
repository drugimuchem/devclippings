require 'dm-core'
require 'dm-migrations'
require './lib/markeline'

#DataMapper.setup(:default, 'mysql://root@localhost/chtshtdb')
DataMapper.setup(:default, 'mysql://magineo_chtshtu:321Jebud!!!@mysql-573360.vipserv.org/magineo_chtsht')

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

