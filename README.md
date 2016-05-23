# Wechat SNS 微信社交库

[![License](https://img.shields.io/badge/license-MIT-green.svg)](http://opensource.org/licenses/MIT)
[![Gem Version](https://badge.fury.io/rb/wechat-sns.svg)](https://badge.fury.io/rb/wechat-sns)

Wechat SNS library is a low level library for Wechat SNS APIs. 微信社交库是一个调用[微信社交API](http://mp.weixin.qq.com/wiki/9/01f711493b5a02f24b04365ac5d8fd95.html)的低层库。



## Recent Update
Check out the [Road Map](ROADMAP.md) to find out what's the next.
Check out the [Change Log](CHANGELOG.md) to find out what's new.



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

[Generate an Authorize URL and Redirect 第一步：用户同意授权，获取code](http://mp.weixin.qq.com/wiki/9/01f711493b5a02f24b04365ac5d8fd95.html#.E7.AC.AC.E4.B8.80.E6.AD.A5.EF.BC.9A.E7.94.A8.E6.88.B7.E5.90.8C.E6.84.8F.E6.8E.88.E6.9D.83.EF.BC.8C.E8.8E.B7.E5.8F.96code)
```ruby
redirect_to Wechat::SNS::AuthorizeLink.create(Rails.application.secrets.wechat_app_id, 'http://product.company.com/promotion/page.html')
```

[Get Access Token per Code 第二步：通过code换取网页授权access_token](http://mp.weixin.qq.com/wiki/9/01f711493b5a02f24b04365ac5d8fd95.html#.E7.AC.AC.E4.BA.8C.E6.AD.A5.EF.BC.9A.E9.80.9A.E8.BF.87code.E6.8D.A2.E5.8F.96.E7.BD.91.E9.A1.B5.E6.8E.88.E6.9D.83access_token)
```ruby
response = Wechat::SNS::AccessToken.create Rails.application.secrets.wechat_app_id, Rails.application.secrets.wechat_app_secret, params[:code]
if response.present?
  access_token  = response['access_token']
  expires_in    = response['expires_in']
  refresh_token = response['refresh_token']
  open_id       = response['openid']
  scope         = response['scope']
  union_id      = response['unionid']
end
```

[Refresh Access Token 第三步：刷新access_token（如果需要）](http://mp.weixin.qq.com/wiki/9/01f711493b5a02f24b04365ac5d8fd95.html#.E7.AC.AC.E4.B8.89.E6.AD.A5.EF.BC.9A.E5.88.B7.E6.96.B0access_token.EF.BC.88.E5.A6.82.E6.9E.9C.E9.9C.80.E8.A6.81.EF.BC.89)
```ruby
response = Wechat::SNS::AccessToken.update Rails.application.secrets.wechat_app_id, refresh_token
if response.present?
  access_token  = response['access_token']
  expires_in    = response['expires_in']
  refresh_token = response['refresh_token']
  open_id       = response['openid']
  scope         = response['scope']
end
```

[Get User Profile per Access Token 第四步：拉取用户信息(需scope为 snsapi_userinfo)](http://mp.weixin.qq.com/wiki/9/01f711493b5a02f24b04365ac5d8fd95.html#.E7.AC.AC.E5.9B.9B.E6.AD.A5.EF.BC.9A.E6.8B.89.E5.8F.96.E7.94.A8.E6.88.B7.E4.BF.A1.E6.81.AF.28.E9.9C.80scope.E4.B8.BA_snsapi_userinfo.29)
```ruby
response = Wechat::SNS::UserProfile.load access_token, open_id
if response.present? && response['errcode'].blank?
  open_id        = response['openid']
  nick_name      = response['nickname']
  sex            = response['sex']
  city           = response['city']
  province       = response['province']
  country        = response['country']
  head_image_url = response['headimgurl']
  privilege      = response['privilege']
  union_id       = response['unionid']
end
```

[Validate Access Token 附：检验授权凭证（access_token）是否有效](http://mp.weixin.qq.com/wiki/9/01f711493b5a02f24b04365ac5d8fd95.html#.E9.99.84.EF.BC.9A.E6.A3.80.E9.AA.8C.E6.8E.88.E6.9D.83.E5.87.AD.E8.AF.81.EF.BC.88access_token.EF.BC.89.E6.98.AF.E5.90.A6.E6.9C.89.E6.95.88)
```ruby
response = Wechat::SNS::AccessToken.load access_token, open_id
if response.present? && 0==response['errcode']
  # valid, do something more with the access_token
  Wechat::SNS::UserProfile.load access_token, open_id
else
  # invalid, the access_token should be updated
  Wechat::SNS::AccessToken.update Rails.application.secrets.wechat_app_id, refresh_token
end
```



## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).



## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/topbitdu/wechat-sns. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.



## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
