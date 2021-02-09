class Transaction

  DATE_FORMAT = "%d/%m/%Y"

  attr_reader :date, :credit, :debit, :balance

  def initialize(date: Time.new.strftime(DATE_FORMAT), credit:, debit:, balance:)
    @date = date
    @credit = credit
    @debit = debit
    @balance = balance
  end

end
