class User < Sequel::Model
  plugin :timestamps, update_on_create: true
  plugin :json_serializer

  one_to_many :todos

  def confirmed?
    !!confirmed_at
  end
end
