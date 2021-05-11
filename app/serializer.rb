# require 'pry-byebug'
require 'date'

class Serializer < SimpleDelegator
  class << self
    def attribute(name, &block)
      @attributes ||= {}
      @attributes[name] = block
    end

    def attributes
      return @attributes
    end
  end

  alias_method :object, :__getobj__

  def serialize
    self.class.attributes.reduce({}) do |hash, (attribute, transformation_proc)|
      value = transformation_proc ? instance_eval(&transformation_proc) : object.public_send(attribute)

      hash[attribute] = value

      hash
    end
  end
end
