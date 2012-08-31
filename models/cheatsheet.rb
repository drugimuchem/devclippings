require 'mongoid'

class Cheatsheet
  include Mongoid::Document

  field :title
  field :content
end
