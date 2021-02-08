require 'account'

describe Account do
  let(:account) {Account.new}

  it "is created with a balance of zero" do
    expect(account.print_balance).to eq("Your current balance is 0")
  end

end
