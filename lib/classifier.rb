require "sisimai"
require "sisimai/fact"

def classify(message)
  fact = Sisimai::Fact.rise(data: message, vacation: true, delivered: true)&.first
  return unless fact

  fact.damn.merge("softbounce" => to_softbounce(fact))
end

# Sisimai::Fact has deprecated and will remove #softbounce in v5.1.0.
# For backward compatibility we'll keep it though.
def to_softbounce(fact)
  return  0 if fact.hardbounce
  return -1 if %w[delivered feedback vacation].include?(fact.reason)

  1
end
