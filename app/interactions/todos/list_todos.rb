class ListTodos < ActiveInteraction::Base
  integer :user_id

  def execute
    if user_allowed?
      Todo.all
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

  def user_allowed?
    user.confirmed?
  end

end
