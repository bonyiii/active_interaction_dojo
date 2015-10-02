class ListTodos < ActiveInteraction::Base
  integer :user_id,
    desc: 'Todos owner user id'

  def execute
    if AllowedUser.run(user_id: user_id).result
      Todo.all
    else
      errors.add(:confirmed_at, 'Not confirmed')
    end
  end

end
