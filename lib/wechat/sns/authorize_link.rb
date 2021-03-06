##
# Authorize Link 是授权链接类。用于生成授权链接。如：
# Wechat::SNS::AuthorizeLink.create wechat_app_id, redirect_link

class Wechat::SNS::AuthorizeLink

  extend Wechat::Core::Common

  RESPONSE_TYPE_CODE = 'code'.freeze
  SCOPE_BASE         = 'snsapi_base'.freeze
  SCOPE_FULL         = 'snsapi_userinfo'.freeze

  ##
  # 第一步：用户同意授权，获取code
  # http://mp.weixin.qq.com/wiki/9/01f711493b5a02f24b04365ac5d8fd95.html#.E7.AC.AC.E4.B8.80.E6.AD.A5.EF.BC.9A.E7.94.A8.E6.88.B7.E5.90.8C.E6.84.8F.E6.8E.88.E6.9D.83.EF.BC.8C.E8.8E.B7.E5.8F.96code
  def self.create(wechat_app_id, redirect_link, response_type: Wechat::SNS::AuthorizeLink::RESPONSE_TYPE_CODE, scope: Wechat::SNS::AuthorizeLink::SCOPE_FULL, state: nil)

    assert_present! :wechat_app_id, wechat_app_id
    assert_present! :redirect_link, redirect_link
    assert_present! :response_type, response_type
    assert_present! :scope,         scope

    "https://open.weixin.qq.com/connect/oauth2/authorize?appid=#{wechat_app_id}&redirect_uri=#{CGI::escape redirect_link}&response_type=#{response_type}&scope=#{scope}&state=#{state}#wechat_redirect"
  end

end
