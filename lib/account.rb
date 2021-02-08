class Account

  attr_accessor :balance

  def initialize
    @balance = 0
  end

  def print_balance
    "Your current balance is #{self.balance}"
  end

  def deposit(amount)
    self.balance += amount
    "#{amount} was added to the account"
  end

end
