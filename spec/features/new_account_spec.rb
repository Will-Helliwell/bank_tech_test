require 'account'

describe "new account" do
  it "a new user starts with a fresh account" do
    expect(account.balance).to eq("Your current balance is 0")
  end
end
