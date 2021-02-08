class Transaction

  DATE_FORMAT = "%d/%m/%Y"

  attr_reader :date, :credit, :debit, :balance

  def initialize(credit, debit, balance)
    @date = Time.new.strftime(DATE_FORMAT)
    @credit = credit
    @debit = debit
    @balance = balance
  end

end
