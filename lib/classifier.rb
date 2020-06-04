require "sisimai"
require "sisimai/data"
require "sisimai/message"

def classify(message)
  msg = Sisimai::Message.new(data: message)
  return if msg.void

  result = Sisimai::Data.make(data: msg, origin: "<MEMORY>")
  return result[0]
end
