require 'mongoid'

module Cheatsheet
  class << self
  
    def connect()
      Mongoid.load!("mongoid.yml",:development)
      #@db = Mongo::Connection.new(config[:server],config[:port]||27017).db(config[:db])
    end

    def find(search)
      if search == :all
        #return all
        return nil_or_array(@db.collection('cheatsheets').find.to_a)
      else
        return find_with_criteria(search)
      end
    end

    private

    def find_with_criteria(search)
      stringify_keys(search)
    end

    def stringify_keys(hash)
      hash.each_key do |key|
        hash[key.to_s] = hash.delete(key)
      end
      hash
    end

    def nil_or_array(results)
      if results.size == 0
        return nil 
      else
        return results
      end
    end

  end
end

