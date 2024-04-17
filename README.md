# sisimai-web

Simple [Sinatra][] web application to inspect bounce emails using [Sisimai][].

We try to follow the [Sisimai releases][sisimai-releases]. Feel free to
[open an issue][issues] or create a pull request, should we fall behind.

## Installation from source

Download the code, install the dependencies and start the server.

```console
$ git clone https://github.com/digineo/sisimai-web
$ cd sisimai-web
$ bundle install
$ bundle exec rackup --host 127.0.0.1 --port 3000
```

## Installation with Docker

We automatically build and push Docker images the project's [container registry][ghcr].

```console
$ docker pull ghcr.io/digineo/sisimai-web
$ docker run -d -p 3000:3000 ghcr.io/digineo/sisimai-web
```

| Image tag | corresponds to |
|:----------|:---------------|
| `ghcr.io/digineo/sisimai-web:master`  | latest Git master branch |
| `ghcr.io/digineo/sisimai-web:4`       | latest Release in the 4.x series |
| `ghcr.io/digineo/sisimai-web:4.25.15` | a specific release |
| `ghcr.io/digineo/sisimai-web:latest`  | the latest build from the above |

Note: You might find earlier versions on the Docker Hub, as `digineode/sisimai-web`;
these releases are now deprecated and unsupported. Expect the Docker Hub repository
to vanish in the near future.

## Usage

After starting the application, the (API only) endpoint becomes available
at http://localhost:3000/.

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

[Sinatra]: http://sinatrarb.com
[Sisimai]: https://libsisimai.org
[sisimai-releases]: https://rubygems.org/gems/sisimai/versions
[issues]: https://github.com/digineo/sisimai-web/issues
[ghcr]: https://github.com/digineo/sisimai-web/packages/
[azumakuniyuki]: https://github.com/azumakuniyuki
[emiles-go-bounce-parser]: https://github.com/e-miles/emiles-go-bounce-parser/
