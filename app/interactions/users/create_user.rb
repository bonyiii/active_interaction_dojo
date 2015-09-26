class CreateUser < ActiveInteraction::Base
  string :name
  string :email

  validates :name,
    presence: true
  validates :email,
    presence: true

  def execute
    User.create(name: name, email: email)
  end
end
