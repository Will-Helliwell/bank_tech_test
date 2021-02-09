require_relative './transaction.rb'
require 'terminal-table'

class Account

  INITIAL_BALANCE = 0
  MINIMUM_BALANCE = 0
  STATEMENT_HEADINGS = ["Date", "Credit", "Debit", "Balance"]

  attr_accessor :balance, :transactions

  def initialize
    @balance = INITIAL_BALANCE
    @transactions = []
  end

  def print_balance
    "Your current balance is #{self.balance}"
  end

  def deposit(amount:, transaction: Transaction.new(amount, nil, self.balance + amount))
    check_if_integer(amount)
    self.balance += amount
    self.transactions << transaction
    deposit_confirmation_message(amount)
  end

  def withdraw(amount, transaction=Transaction.new(nil, amount, self.balance - amount))
    check_if_integer(amount)
    check_above_minimum_balance(amount)
    self.balance -= amount
    self.transactions << transaction
    withdrawl_confirmation_message(amount)
  end

  def print_statement
    return "No recorded transactions" if self.transactions.length == 0
    rows = generate_table_rows(self.transactions)
    print_table(rows)
    rows
  end



  private
  def deposit_confirmation_message(amount)
    "#{amount} was added to the account"
  end
  def withdrawl_confirmation_message(amount)
    "#{amount} was withdrawn from the account"
  end

  def check_if_integer(amount)
    raise TypeError.new("Incorrect usage - integer argument expected") if amount.class != Integer
  end
  def check_above_minimum_balance(amount)
    raise("Failed to withdraw - cannot exceed minimum balance") if self.balance - amount < MINIMUM_BALANCE
  end

  def generate_table_rows(transactions)
    rows = [STATEMENT_HEADINGS]
    transactions.each{ |transaction|
      rows << [transaction.date, transaction.credit, transaction.debit, transaction.balance]
    }
    rows
  end
  def print_table(rows)
    table = Terminal::Table.new :rows => rows
    puts table
  end

end
