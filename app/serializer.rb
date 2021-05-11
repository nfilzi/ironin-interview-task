# require 'pry-byebug'
require 'date'

class Serializer
  class << self
    def attribute(name, &block)
      @attributes ||= {}
      @attributes[name] = block
    end

    def attributes
      return @attributes
    end
  end

  attr_reader :object

  def initialize(object)
    @object = object
  end

  def serialize
    data = {}

    self.class.attributes.each do |key, proc|
      if proc
        data[key] = instance_eval(&proc)
      else
        data[key] = object.public_send(key)
      end
    end

    return data
  end
end
