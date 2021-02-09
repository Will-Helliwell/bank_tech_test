require 'account'

describe "FEATURE TESTS - print_statement" do
  it "prints the correct statement when user makes a deposit, makse a withdrawl, prints statement" do
    account = Account.new
    account.deposit(amount: 100)
    account.withdraw(amount: 20)
    expect(account.print_statement).to eq([
      Account::STATEMENT_HEADINGS,
      [Time.new.strftime(Account::DATE_FORMAT), 100, nil, Account::INITIAL_BALANCE + 100],
      [Time.new.strftime(Account::DATE_FORMAT), nil, 20, Account::INITIAL_BALANCE + 100 - 20]
      ])
  end
  it "passes acceptance criteria" do
    account = Account.new
    account.deposit(amount: 100, date: "10/01/2012")
    account.deposit(amount: 2000, date: "13/01/2012")
    account.withdraw(amount: 500, date: "14/01/2012")
    expect(account.print_statement).to eq([
      Account::STATEMENT_HEADINGS,
      ["10/01/2012", 100, nil, Account::INITIAL_BALANCE + 100],
      ["13/01/2012", 2000, nil, Account::INITIAL_BALANCE + 100 + 2000],
      ["14/01/2012", nil, 500, Account::INITIAL_BALANCE + 100 + 2000 - 500]
      ])
  end
end
