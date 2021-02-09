# frozen_string_literal: true

require_relative './transaction.rb'
require 'terminal-table'

class Account
  INITIAL_BALANCE = 0
  MINIMUM_BALANCE = 0
  STATEMENT_HEADINGS = %w[Date Credit Debit Balance].freeze
  DATE_FORMAT = '%d/%m/%Y'

  attr_accessor :balance, :transactions

  def initialize
    @balance = INITIAL_BALANCE
    @transactions = []
  end

  def print_balance
    "Your current balance is #{balance}"
  end

  def deposit(amount:, date: generate_date, transaction: Transaction.new(date: date, credit: amount, debit: nil, balance: balance + amount))
    check_if_integer(amount)
    self.balance += amount
    transactions << transaction
    deposit_confirmation_message(amount)
  end

  def withdraw(amount:, date: generate_date, transaction: Transaction.new(date: date, credit: nil, debit: amount, balance: self.balance - amount))
    check_if_integer(amount)
    check_above_minimum_balance(amount)
    self.balance -= amount
    transactions << transaction
    withdrawal_confirmation_message(amount)
  end

  def print_statement
    return 'No recorded transactions' if transactions.empty?

    rows = generate_table_rows(transactions)
    print_table(rows)
    rows
  end

  private

  def deposit_confirmation_message(amount)
    "#{amount} was added to the account"
  end

  def withdrawal_confirmation_message(amount)
    "#{amount} was withdrawn from the account"
  end

  def generate_date
    Time.new.strftime(DATE_FORMAT)
  end

  def check_if_integer(amount)
    if amount.class != Integer
      raise TypeError, 'Incorrect usage - integer argument expected'
    end
  end

  def check_above_minimum_balance(amount)
    if self.balance - amount < MINIMUM_BALANCE
      raise('Failed to withdraw - cannot exceed minimum balance')
    end
  end

  def generate_table_rows(transactions)
    rows = [STATEMENT_HEADINGS]
    transactions.each do |transaction|
      rows << [transaction.date, transaction.credit, transaction.debit, transaction.balance]
    end
    rows
  end

  def print_table(rows)
    table = Terminal::Table.new rows: rows
    puts table
  end
end
