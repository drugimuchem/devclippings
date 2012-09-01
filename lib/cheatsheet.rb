require 'mongoid'
require './lib/html_sheet'

class Cheatsheet
  include Mongoid::Document
  include HtmlSheet

  field :title
  field :content

  def content_as_html
    HtmlSheet.to_html(content)
  end
end
