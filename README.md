# Firebase::Auth::IDTokenKeeper

## Errors

### Response body

```json
{
  "error": "<message>"
}
```

### Type

- `JWT::ExpiredSignature`
    - code: 401
    - message: "Signature has expired."
    - You should refresh your token on the client side.
- `JWT::DecodeError`
    - code: 401
    - message: "Invalid JWT format."
    - You should send JWT with valid format.


## Test

We provide test id token generate method.

It can use like this.

```ruby
decoded_jwt = {
  "iss"=>"https://example.com/project-id",
  "name"=>"Test Example",
  "picture"=>"https://example.com",
  "aud"=>"project-id",
  "auth_time"=>1535353624,
  "user_id"=>"badcd9971aa1ba6a46bf3379db78",
  "sub"=>"badcd9971aa1ba6a46bf3379db78",
  "iat"=>1535353624,
  "exp"=>2000000000,
  "email"=>"test.example@example.com",
  "email_verified"=>false,
  "firebase"=>{"identities"=>{"github.com"=>["xxxxxx"], "email"=>["test.example@example.com"]}, "sign_in_provider"=>"github.com"}
}

encoded_jwt = Firebase::Auth::IDTokenKeeper::Testing.generate_test_id_token(decoded_jwt)
# => "eyJ0eXAiOiJKV1QiLCJhbGciOiJub25lIn0.eyJpc3MiOiJodHRwczovL2V4YW1wbGUuY29tL3Byb2plY3QtaWQiLCJuYW1lIjoiVGVzdCBFeGFtcGxlIiwicGljdHVyZSI6Imh0dHBzOi8vZXhhbXBsZS5jb20iLCJhdWQiOiJwcm9qZWN0LWlkIiwiYXV0aF90aW1lIjoxNTM1MzUzNjI0LCJ1c2VyX2lkIjoiYmFkY2Q5OTcxYWExYmE2YTQ2YmYzMzc5ZGI3OCIsInN1YiI6ImJhZGNkOTk3MWFhMWJhNmE0NmJmMzM3OWRiNzgiLCJpYXQiOjE1MzUzNTM2MjQsImV4cCI6MjAwMDAwMDAwMCwiZW1haWwiOiJ0ZXN0LmV4YW1wbGVAZXhhbXBsZS5jb20iLCJlbWFpbF92ZXJpZmllZCI6ZmFsc2UsImZpcmViYXNlIjp7ImlkZW50aXRpZXMiOnsiZ2l0aHViLmNvbSI6WyJ4eHh4eHgiXSwiZW1haWwiOlsidGVzdC5leGFtcGxlQGV4YW1wbGUuY29tIl19LCJzaWduX2luX3Byb3ZpZGVyIjoiZ2l0aHViLmNvbSJ9fQ."

Firebase::Auth::IDTokenKeeper::Testing.decode_test_id_token(encoded_jwt)
# => {
#      "iss"=>"https://example.com/project-id",
#      "name"=>"Test Example",
#      "picture"=>"https://example.com",
#      "aud"=>"project-id",
#      "auth_time"=>1535353624,
#      "user_id"=>"badcd9971aa1ba6a46bf3379db78",
#      "sub"=>"badcd9971aa1ba6a46bf3379db78",
#      "iat"=>1535353624,
#      "exp"=>2000000000,
#      "email"=>"test.example@example.com",
#      "email_verified"=>false,
#      "firebase"=>{"identities"=>{"github.com"=>["xxxxxx"], "email"=>["test.example@example.com"]}, "sign_in_provider"=>"github.com"}
#    }
```

### For RSpec

Make a support file `spec/support/firebase_auth_id_token_keeper.rb` which contains following code.

```ruby
require 'firebase/auth/id_token_keeper/testing/request_helpers'

RSpec.configure do |config|
  config.include Firebase::Auth::IDTokenKeeper::Testing::RequestHelpers, type: :request
end
```

Load the support file in your `spec/rails_helper.rb`.

```ruby
...
# Add additional requires below this line. Rails is not loaded until this point!
require 'support/firebase_auth_id_token_keeper'
...
```

Now, we can decode test ID Token which is generated via `Firebase::Auth::IDTokenKeeper::Testing.generate_test_id_token` method in `Firebase::Auth::IDTokenKeeper::IDToken#verified_id_token` method.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'firebase-auth-id_token_keeper'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install firebase-auth-id_token_keeper

## Usage

TODO: Write usage instructions here

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/firebase-auth-id_token_keeper. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Firebase::Auth::IDTokenKeeper project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/firebase-auth-id_token_keeper/blob/master/CODE_OF_CONDUCT.md).
