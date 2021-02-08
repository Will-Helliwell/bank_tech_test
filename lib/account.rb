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
    self.balance += amount
    deposit_confirmation_message(amount)
  end

  def withdraw(amount)
    raise("Failed to withdraw - cannot exceed minimum balance") if self.balance - amount < MINIMUM_BALANCE
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

end
