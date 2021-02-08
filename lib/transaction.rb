class Transaction

  attr_reader :date

  def initialize(credit, debit, balance)
    @date = Time.new.strftime("%d/%m/%Y")
  end

end
