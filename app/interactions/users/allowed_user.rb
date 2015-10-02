class AllowedUser < ActiveInteraction::Base
  integer :user_id,
    desc: 'User to check'

  def execute
    return true if user.confirmed?

    user.unconfirmed_tries += 1
    user.save
    user.unconfirmed_tries < 3
  end

  private

  def user
    @user ||= User[id: user_id]
  end

end
