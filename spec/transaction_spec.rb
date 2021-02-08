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
  end

end
