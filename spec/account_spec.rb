require 'account'

describe Account do
  let(:account) {Account.new}

  it "is created with a balance of zero" do
    expect(account.print_balance).to eq("Your current balance is 0")
  end

  describe "#deposit" do
    it "returns a confirmation message when given an integer" do
      expect(account.deposit(100)).to eq("100 was added to the account")
    end
  end

end
