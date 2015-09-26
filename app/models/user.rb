class User < Sequel::Model
  one_to_many :todos

  def validate
    super
  end
end
