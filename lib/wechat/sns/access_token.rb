require 'jsonclient'

class Wechat::SNS::AccessToken

  extend Wechat::Core::Common

  # 附：检验授权凭证（access_token）是否有效
  # http://mp.weixin.qq.com/wiki/9/01f711493b5a02f24b04365ac5d8fd95.html#.E9.99.84.EF.BC.9A.E6.A3.80.E9.AA.8C.E6.8E.88.E6.9D.83.E5.87.AD.E8.AF.81.EF.BC.88access_token.EF.BC.89.E6.98.AF.E5.90.A6.E6.9C.89.E6.95.88
  #
  # Return hash format if success:
  # {
  #   errcode: 0,
  #   errmsg:  'ok'
  # }
  #
  # Return hash format if failure:
  # {
  #   errcode: 40003,
  #   errmsg:  'invalid openid'
  # }
  def self.load(access_token, opend_id)

    assert_present! :access_token, access_token
    assert_present! :opend_id,     opend_id
    #raise ArgumentError.new('The access_token argument is required.') if access_token.blank?

    message = ::JSONClient.new.get 'https://api.weixin.qq.com/sns/auth',
      {
        access_token: access_token,
        openid:       opend_id
      }
    message.body
  end

  # 第三步：刷新access_token（如果需要）
  # http://mp.weixin.qq.com/wiki/9/01f711493b5a02f24b04365ac5d8fd95.html#.E7.AC.AC.E4.B8.89.E6.AD.A5.EF.BC.9A.E5.88.B7.E6.96.B0access_token.EF.BC.88.E5.A6.82.E6.9E.9C.E9.9C.80.E8.A6.81.EF.BC.89
  #
  # Return hash format if success:
  # {
  #   access_token:  <ACCESS_TOKEN>,  # 网页授权接口调用凭证,注意：此access_token与基础支持的access_token不同
  #   expires_in:    7200,            # access_token接口调用凭证超时时间，单位（秒）
  #   refresh_token: <REFRESH_TOKEN>, # 用户刷新access_token
  #   openid:        <OPEN_ID>,       # 用户唯一标识，请注意，在未关注公众号时，用户访问公众号的网页，也会产生一个用户和公众号唯一的OpenID
  #   scope:         <SCOPE>          # 用户授权的作用域，使用逗号（,）分隔
  # }
  #
  # Return hash format if failure:
  # {
  #   errcode: <ERROR_CODE>,
  #   errmsg:  <ERROR_MESSAGE>
  # }
  def self.update(app_id, refresh_token)

    assert_present! :app_id, app_id
    # raise ArgumentError.new('The app_id argument is required.') if app_id.blank?

    message = ::JSONClient.new.get 'https://api.weixin.qq.com/sns/oauth2/refresh_token',
      {
        appid:         app_id,
        grant_type:    'refresh_token',
        refresh_token: refresh_token
      }
    message.body
  end

  # 第二步：通过code换取网页授权access_token
  # http://mp.weixin.qq.com/wiki/9/01f711493b5a02f24b04365ac5d8fd95.html#.E7.AC.AC.E4.BA.8C.E6.AD.A5.EF.BC.9A.E9.80.9A.E8.BF.87code.E6.8D.A2.E5.8F.96.E7.BD.91.E9.A1.B5.E6.8E.88.E6.9D.83access_token
  #
  # Return hash format if success:
  # {
  #   access_token:  <ACCESS_TOKEN>,  # 网页授权接口调用凭证,注意：此access_token与基础支持的access_token不同
  #   expires_in:    7200,            # access_token接口调用凭证超时时间，单位（秒）
  #   refresh_token: <REFRESH_TOKEN>, # 用户刷新access_token
  #   openid:        <OPEN_ID>,       # 用户唯一标识，请注意，在未关注公众号时，用户访问公众号的网页，也会产生一个用户和公众号唯一的OpenID
  #   scope:         <SCOPE>,         # 用户授权的作用域，使用逗号（,）分隔
  #   unionid:       <UNION_ID>       # 只有在用户将公众号绑定到微信开放平台帐号后，才会出现该字段。
  # }
  #
  # Return hash format if failure:
  # {
  #   errcode: <ERROR_CODE>,
  #   errmsg:  <ERROR_MESSAGE>
  # }
  def self.create(app_id, app_secret, code, grant_type: 'authorization_code')

    raise ArgumentError.new('The app_id argument is required.') if app_id.blank?

    message = ::JSONClient.new.get 'https://api.weixin.qq.com/sns/oauth2/access_token',
      {
        appid:      app_id,
        secret:     app_secret,
        code:       code,
        grant_type: grant_type
      }
    message.body
    #body = message.body
    #body.is_a?(Hash) ? body : JSON.parse(body)
  end

end
