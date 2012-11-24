require "spec_helper"

describe Answer do
  describe "accept" do
    let(:mail) { Answer.accept }

    it "renders the headers" do
      mail.subject.should eq("Accept")
      mail.to.should eq(["to@example.org"])
      mail.from.should eq(["from@example.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match("Hi")
    end
  end

  describe "reject" do
    let(:mail) { Answer.reject }

    it "renders the headers" do
      mail.subject.should eq("Reject")
      mail.to.should eq(["to@example.org"])
      mail.from.should eq(["from@example.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match("Hi")
    end
  end

end
