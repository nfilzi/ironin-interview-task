require_relative 'serializer'

class FoobarSerializer < Serializer
  attribute :id
  attribute :date do
    date.strftime("%d-%m-%Y")
  end
end

Foobar = Struct.new(:id, :date)

p FoobarSerializer.new(Foobar.new(1, Date.new(2020, 1, 1))).serialize
# => {:id=>1, :date=>"01-01-2020"}
