require 'transaction'

describe Transaction do

  let(:transaction) {Transaction.new(credit: 10, debit: 20, balance: 30)}

  describe "initialization" do
    it "is created with a date attribute of the current date" do
      expect(transaction.date).to eq(Time.new.strftime(Transaction::DATE_FORMAT))
    end
    it "is created with a credit attribute that can be accessed" do
      expect(transaction.credit).to eq(10)
    end
    it "is created with a debit attribute that can be accessed" do
      expect(transaction.debit).to eq(20)
    end
    it "is created with a balance attribute that can be accessed" do
      expect(transaction.balance).to eq(30)
    end
  end

end
