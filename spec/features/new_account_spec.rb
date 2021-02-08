require 'account'

describe "new account" do
  let(:account) {Account.new}

  it "a new user starts with a fresh account" do
    expect(account.print_balance).to eq("Your current balance is 0")
  end
end
