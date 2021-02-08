class Account

  attr_reader :balance

  def initialize
    @balance = 0
  end

  def print_balance
    "Your current balance is #{self.balance}"
  end

end
