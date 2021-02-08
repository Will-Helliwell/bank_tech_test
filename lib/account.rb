require 'transaction'

class Account

  INITIAL_BALANCE = 0
  MINIMUM_BALANCE = 0

  attr_accessor :balance

  def initialize
    @balance = INITIAL_BALANCE
  end

  def print_balance
    "Your current balance is #{self.balance}"
  end

  def deposit(amount)
    check_if_integer(amount)
    self.balance += amount
    deposit_confirmation_message(amount)
  end

  def withdraw(amount)
    check_if_integer(amount)
    check_above_minimum_balance(amount)
    self.balance -= amount
    withdrawl_confirmation_message(amount)
  end



  private
  def deposit_confirmation_message(amount)
    "#{amount} was added to the account"
  end
  def withdrawl_confirmation_message(amount)
    "#{amount} was withdrawn from the account"
  end

  def check_if_integer(amount)
    raise("Incorrect usage - integer argument expected") if amount.class != Integer
  end
  def check_above_minimum_balance(amount)
    raise("Failed to withdraw - cannot exceed minimum balance") if self.balance - amount < MINIMUM_BALANCE
  end

end
