class CreateUser < ActiveInteraction::Base
  string :name
  string :email

  def execute
    User.create(name: name, email: email)
  end
end
