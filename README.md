# Wechat SNS 微信社交库

[![License](https://img.shields.io/badge/license-MIT-green.svg)](http://opensource.org/licenses/MIT)
[![Gem Version](https://badge.fury.io/rb/wechat-sns.svg)](https://badge.fury.io/rb/wechat-sns)

Wechat SNS library is a low level library for Wechat SNS APIs. 微信社交库是一个调用[微信社交API](http://mp.weixin.qq.com/wiki/9/01f711493b5a02f24b04365ac5d8fd95.html)的低层库。

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'wechat-sns'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install wechat-sns

## Usage

Generate an authorize URL.
```ruby
redirect_to Wechat::SNS::AuthorizeLink.create(Rails.application.secrets.wechat_app_id, 'http://project.company.com/dashboards/~')
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/topbitdu/wechat-sns. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

