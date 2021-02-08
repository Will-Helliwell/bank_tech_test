require 'account'

describe "make a deposit, make a withdrawl, print statement" do
  it "prints the correct statement" do
    account = Account.new
    account.deposit(100)
    account.withdraw(20)
    expect(account.print_statement).to eq([
      [Time.new.strftime(Transaction::DATE_FORMAT), 100, nil, Account::INITIAL_BALANCE + 100],
      [Time.new.strftime(Transaction::DATE_FORMAT), nil, 20, Account::INITIAL_BALANCE + 100 - 20]
      ])
  end
end
