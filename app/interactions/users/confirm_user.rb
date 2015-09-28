class ConfirmUser < ActiveInteraction::Base
  integer :id,
    desc: 'User id'

  def execute
    User.where(id: id).update(confirmed_at: Time.now)
  end
end
