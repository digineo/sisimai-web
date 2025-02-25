require "spec_helper"

RSpec.describe "mail classification" do
  each_fixture do |fixture, options|
    it "classifies #{fixture}" do
      message = read_fixture("messages/#{fixture}.txt")

      post "/", message, {
        "Content-Type": "message/rfc822",
      }

      expect(last_response).to be_ok

      if options[:bounce]
        result = JSON.parse(last_response.body)

        expect(result["softbounce"]).to eq options[:bounce]
        expect(result["reason"]).to eq options[:reason]
        expect(result["replycode"]).to eq options[:replycode]
      end
    end
  end

  it "doesn't read arbitrary files" do
    post "/", "spec/fixtures/messages/bounce_gmail.txt"

    expect(last_response).to be_ok
    expect(last_response.body).to eq "null"
  end
end
