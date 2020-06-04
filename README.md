# sisimai-web

Simple [Sinatra][] web application to inspect bounce emails using [Sisimai][].

## Installation

Download the code, install the dependencies and start the server.

```console
$ git clone https://github.com/digineo/sisimai-web
$ cd sisimai-web
$ bundle install
$ bundle exec ruby app.rb
```

The endpoint becomes available at http://localhost:3000/ (API-only)

## Usage

Have a bounce mail:

```console
$ head -5 message.eml
Received: by m.sender.com (Postfix)
	id 7A3371230; Sun, 22 Jan 2012 22:17:05 -0800 (PST)
Date: Sun, 22 Jan 2012 22:17:05 -0800 (PST)
From: MAILER-DAEMON@sender.com (Mail Delivery System)
Subject: Undelivered Mail Returned to Sender
```

... and POST it to the endpoint:

```
$ curl -sXPOST --data-binary @message.eml http://localhost:3000/ | \
  jq 'with_entries(select(.key == ("action","reason","softbounce")))'
{
  "action": "failed",
  "reason": "userunknown",
  "softbounce": 0
}
```

## Credits

[Sisimai][] is an excellent bounce mail parser library by [azumakuniyuki][].

The test messages for the test suite were extracted from
[emiles-go-bounce-parser][].

## License

Copyright (c) 2020, Dominik Menke, Digineo GmbH

MIT, see [LICENSE](./LICENSE) for details.

[Sisimai]: https://libsisimai.org
[azumakuniyuki]: https://github.com/azumakuniyuki
[emiles-go-bounce-parser]: https://github.com/e-miles/emiles-go-bounce-parser/
