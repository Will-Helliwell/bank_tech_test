require 'transaction'

describe Transaction do

  let(:transaction) {Transaction.new(10, 20, 30)}

  describe "initialization" do
    it "takes 3 arguments" do
      expect(described_class).to respond_to(:new).with(3).arguments
    end
    it "is created with a date attribute of the current date" do
      expect(transaction.date).to eq(Time.new.strftime("%d/%m/%Y"))
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
