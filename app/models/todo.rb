class Todo < Sequel::Model
  many_to_one :user

  def validate
    super
  end
end
