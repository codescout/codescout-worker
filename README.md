# codescout-worker

Sidekiq-based worker application to perform code analysis builds for Code Scout.

## Requirements

- Ruby 2.1
- Redis
- Docker

## Installation

Clone repository and install dependencies:

```
git clone https://github.com/codescout/codescout-worker.git
cd codescout-worker
bundle install
```

Copy sample environment file:

```
cp .env.sample .env
```

Then adjust environment variables in the `.env` file:

## Configuration

Foreman uses `.env` file that contain environment variables:

- `REDIS_URL`     - Redis server connection URL
- `DOCKER_HOST`   - Docker connection string. Example: `tcp://127.0.0.1:5555`.
- `DOCKER_IMAGE`  - Docker image that holds codescout scripts
- `CODESCOUT_URL` - Codescout service URL

## Usage

After you finished configuring worker, you can start it with the following comand:

```
bundle exec foreman start
```

## Testing

This project uses RSpec as a testing framework. Execute tests with:

```
bundle exec rake test
```

## License

The MIT License (MIT)

Copyright (c) 2014 Doejo LLC, <dan@doejo.com>