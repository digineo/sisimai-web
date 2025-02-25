require "spec_helper"

RSpec.describe SisimaiWeb do
  describe ".classify" do
    each_fixture do |fixture, options|
      it "classifies #{fixture}" do
        message = read_fixture("messages/#{fixture}.txt")
        result  = SisimaiWeb.classify(message)

        if options[:bounce]
          expect(result).to be_kind_of(Hash)
          expect(result["softbounce"]).to eq options[:bounce]
          expect(result["reason"]).to eq options[:reason]
          expect(result["replycode"]).to eq options[:replycode]
        else
          expect(result).to be_nil
        end
      end
    end
  end
end
