require 'dm-core'
require 'dm-migrations'
require './lib/html_sheet'

DataMapper.setup(:default, 'mysql://root@localhost/chtshtdb')

class Cheatsheet
  include DataMapper::Resource
  include HtmlSheet

  property :id, Serial
  property :title, String
  property :content, Text

  def content_as_html
    HtmlSheet.to_html(content)
  end
end

DataMapper.auto_upgrade!
DataMapper.finalize

