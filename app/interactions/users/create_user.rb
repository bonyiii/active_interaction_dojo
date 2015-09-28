class CreateUser < ActiveInteraction::Base
  string :name,
    desc: 'User name'
  string :email,
    desc: 'User email'

  validates :name,
    presence: true
  validates :email,
    presence: true

  def execute
    User.create(name: name, email: email)
  end
end
