require 'account'

describe Account do
  let(:account) {Account.new}
  let(:fake_transaction_1) {double("fake transaction 1", :date => 01/01/20, :credit => 100, :debit => nil, :balance => 100)}
  let(:fake_transaction_2) {double("fake transaction 1", :date => 01/01/20, :credit => nil, :debit => 20, :balance => 80)}

  it "is created with a balance of zero" do
    expect(account.print_balance).to eq("Your current balance is #{Account::INITIAL_BALANCE}")
  end

  describe "#deposit" do
    it "raises an error if an integer not given as an argument" do
      expect{account.deposit("hello")}.to raise_error(TypeError)
    end
    it "returns a confirmation message when given an integer" do
      expect(account.deposit(100, fake_transaction_1)).to eq("100 was added to the account")
    end
    it "adds the deposit to the balance" do
      account.deposit(100, fake_transaction_1)
      expect(account.print_balance).to eq("Your current balance is #{Account::INITIAL_BALANCE + 100}")
    end
    it "adds a the transaction to the transaction history" do
      account.deposit(100, fake_transaction_1)
      expect(account.print_statement).to eq([
        Account::STATEMENT_HEADINGS,
        [01/01/20, 100, nil, 100]
        ])
    end
  end

  describe "#withdraw" do
    before(:each) do
      account.deposit(100, fake_transaction_1)
    end
    it "raises an error if an integer not given as an argument" do
      expect{account.deposit("hello")}.to raise_error(TypeError)
    end
    it "returns a confirmation message when given an integer" do
      expect(account.withdraw(50, fake_transaction_2)).to eq("50 was withdrawn from the account")
    end
    it "subtracts the deposit to the balance" do
      account.withdraw(50, fake_transaction_2)
      expect(account.print_balance).to eq("Your current balance is #{Account::INITIAL_BALANCE + 100 - 50}")
    end
    it "returns an error if withdrawl will take below MINIMUM_BALANCE" do
      expect{account.withdraw(1000, fake_transaction_2)}.to raise_error("Failed to withdraw - cannot exceed minimum balance")
    end
    it "adds a the transaction to the transaction history" do
      account.withdraw(20, fake_transaction_2)
      expect(account.print_statement).to eq([
        Account::STATEMENT_HEADINGS,
        [01/01/20, 100, nil, 100],
        [01/01/20, nil, 20, 80]
        ])
    end
  end

  describe "#print_statement" do
    context("")
    it "prints nothing for an account with no transactions" do
      expect(account.print_statement).to eq("No recorded transactions")
    end
    it "prints correctly for an account with one transaction" do
      account.deposit(100, fake_transaction_1)
      expect(account.print_statement).to eq([
        Account::STATEMENT_HEADINGS,
        [01/01/20, 100, nil, 100]
        ])
    end
    it "prints correctly for an account with many transactions" do
      account.deposit(100, fake_transaction_1)
      account.deposit(100, fake_transaction_1)
      account.deposit(100, fake_transaction_1)
      account.withdraw(20, fake_transaction_2)
      account.withdraw(20, fake_transaction_2)
      expect(account.print_statement).to eq([
        Account::STATEMENT_HEADINGS,
        [01/01/20, 100, nil, 100],
        [01/01/20, 100, nil, 100],
        [01/01/20, 100, nil, 100],
        [01/01/20, nil, 20, 80],
        [01/01/20, nil, 20, 80]
        ])
    end
  end

end
