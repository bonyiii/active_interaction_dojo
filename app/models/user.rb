class User < Sequel::Model
  plugin :json_serializer

  one_to_many :todos

  def validate
    super
  end
end
