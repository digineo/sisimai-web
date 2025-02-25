require "sisimai"
require "sisimai/fact"

module SisimaiWeb
  def self.classify(message)
    fact = Sisimai::Fact.rise(
      data:      message,
      vacation:  true,
      delivered: true,
      origin:    "ether",
    )&.first
    return unless fact

    with_backward_compat(fact)
  end

  # Sisimai::Fact has removed #softbounce in v5.1.0.
  # For backward compatibility we'll keep it though.
  def self.to_softbounce(fact)
    return  0 if fact.hardbounce
    return -1 if %w[delivered feedback vacation].include?(fact.reason)

    1
  end

  def self.with_backward_compat(fact)
    fact.damn.tap { |r|
      r["softbounce"]  = to_softbounce(fact) unless r.key? "softbounce"  # 5.1.0
      r["smtpagent"]   = fact.decodedby      unless r.key? "smtpagent"   # 5.2.0
      r["smtpcommand"] = fact.command        unless r.key? "smtpcommand" # 5.2.0
    }
  end
end
