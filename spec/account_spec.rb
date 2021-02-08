require 'account'

describe Account do
  let(:account) {Account.new}

  it "is created with a balance of zero" do
    expect(account.print_balance).to eq("Your current balance is #{Account::INITIAL_BALANCE}")
  end

  describe "#deposit" do
    it "raises an error if an integer not given as an argument" do
      expect{account.deposit("hello")}.to raise_error("Incorrect usage - integer argument expected")
    end
    it "returns a confirmation message when given an integer" do
      expect(account.deposit(100)).to eq("100 was added to the account")
    end
    it "returns adds the deposit to the balance" do
      account.deposit(100)
      expect(account.print_balance).to eq("Your current balance is #{Account::INITIAL_BALANCE + 100}")
    end
  end

  describe "#withdraw" do
    before(:each) do
      account.deposit(100)
    end
    it "raises an error if an integer not given as an argument" do
      expect{account.deposit("hello")}.to raise_error("Incorrect usage - integer argument expected")
    end
    it "returns a confirmation message when given an integer" do
      expect(account.withdraw(50)).to eq("50 was withdrawn from the account")
    end
    it "subtracts the deposit to the balance" do
      account.withdraw(50)
      expect(account.print_balance).to eq("Your current balance is #{Account::INITIAL_BALANCE + 100 - 50}")
    end
    it "returns an error if withdrawl will take below MINIMUM_BALANCE" do
      expect{account.withdraw(1000)}.to raise_error("Failed to withdraw - cannot exceed minimum balance")
    end
  end

  describe "#print_statement" do
    it "prints nothing for an account with no transactions" do
      expect(account.print_statement).to eq("No recorded transactions")
    end
  end

end
