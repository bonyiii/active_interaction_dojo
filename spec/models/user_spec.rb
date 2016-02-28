require_relative '../spec_helper'

describe User do
  it "should be true" do
    expect(1).to eq(1)
  end

  it "shoul create a user" do
    expect {
      User.create(name: "John Doe", email: "john@doe.com")
    }.to change(User, :count).by(1)
  end
end
