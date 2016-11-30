# Sprawl

One challenge in the microservice world is tracking service relationships as an application grows.  

Enter Sprawl!

Sprawl is a simple tool that generates a relationship map or diagram of the microservice components that make up an application based on a simple set of description files.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'sprawl'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install sprawl

## Usage

### CLI

Run `sprawl`

### Service description

In order to define a service you need a yaml file created with the following structure:

```ruby
name: first-service
description: This is our first service
language: Java
datastores:
  - Postgres
messageTypesProduced:
  - HelloThere
  - Status
messageTypesConsumed:
  - ByeBye
  - DoIt
restDependencies:
  - second-service
  - third-service
```

| Field                | Description                                                                                                        |
| -------------------- | ------------------------------------------------------------------------------------------------------------------ |
| name                 | The name of the current service (REQUIRED)                                                                         |
| description          | A short description of the purpose of the service                                                                  |
| language             | The programming language that the service is written in                                                            |
| datastores           | An array of any datastores that the service uses                                                                   |
| messageTypesProduced | If the service utilizes asyncronous messaging, an array of message types that the service produces for the system  |
| messageTypesConsumed | If the service utilizes asyncronous messaging, an array of message types that the service consumes from the system |
| restDependencies     | An array of other services that this service communicates over REST                                                |


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/fortitudetec/sprawl. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
