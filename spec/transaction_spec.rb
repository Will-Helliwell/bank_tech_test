require 'transaction'

describe Transaction do

  describe "initialization" do
    it "takes 3 arguments" do
      expect(described_class).to respond_to(:new).with(3).arguments
    end
    xit "is created with a date attribute of the current date" do
    end
  end

end
