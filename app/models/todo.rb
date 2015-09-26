class Todo < Sequel::Model
  plugin :timestamps, update_on_create: true
  plugin :json_serializer

  many_to_one :user

  def validate
    super
  end
end
