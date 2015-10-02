class CreateTodo < ActiveInteraction::Base
  string :body,
    desc: 'Todo body'
  integer :user_id,
    desc: 'User whose the todo belongs to'

  validates :user_id,
    presence: true
  validates :body,
    presence: true

  def execute
    if AllowedUser.run(user_id: user_id).result
      Todo.create(body: body, user_id: user_id)
    else
      errors.add(:confirmed_at, 'Not confirmed')
    end
  end

end
