require 'dm-core'
require 'dm-migrations'
require './lib/markeline'

# use env variable DM_SETUP for custom DB for DataMapper 
dm_setups = Hash.new('mysql://root@localhost/chtshtdb');
dm_setups['vipserv'] = 'mysql://magineo_chtshtu:321Jebud!!!@mysql-573360.vipserv.org/magineo_chtsht'
DataMapper.setup(:default,dm_setups[ENV['DM_SETUP']])

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

