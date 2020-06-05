require "spec_helper"

RSpec.describe "mail classification" do
  SOFT = 1
  HARD = 0
  UNKNOWN = -1

  {
    "auto_earthlink"   => { bounce: UNKNOWN, reason: "vacation",     replycode: "" },
    "bounce_aol"       => { bounce: HARD,    reason: "userunknown",  replycode: "550" },
    "bounce_att"       => { bounce: SOFT,    reason: "spamdetected", replycode: "521" },
    "bounce_charter"   => { bounce: HARD,    reason: "userunknown",  replycode: "550" },
    "bounce_cox"       => { bounce: SOFT,    reason: "suspend",      replycode: "550" },
    "bounce_earthlink" => { bounce: HARD,    reason: "userunknown",  replycode: "550" },
    "bounce_exchange"  => { bounce: HARD,    reason: "userunknown",  replycode: "550" },
    "bounce_gmail"     => { bounce: HARD,    reason: "userunknown",  replycode: "550" },
    "bounce_hotmail"   => { bounce: HARD,    reason: "userunknown",  replycode: "550" },
    "bounce_me"        => { bounce: HARD,    reason: "userunknown",  replycode: "550" },
    "bounce_postfix"   => { bounce: HARD,    reason: "userunknown",  replycode: "550" },
    "bounce_spam"      => { bounce: SOFT,    reason: "spamdetected", replycode: "554" },
    "bounce_yahoo"     => { bounce: SOFT,    reason: "filtered",     replycode: "554" },
    "ordinary_gmail"   => { bounce: false },
  }.each do |fixture, options|
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
