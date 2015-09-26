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
    if user_allowed?
      Todo.create(body: body, user_id: user_id)
    else
      user.unconfirmed_tries += 1
      user.save
      errors.add(:confirmed_at, 'Not confirmed')
    end
  end

  private

  def user
    @user ||= User[id: user_id]
  end

  def todo_count
    Todo.where(user_id: user.id).count
  end

  def user_allowed?
    return true if user.confirmed?
    todo_count < 3
  end

end
