require 'jsonclient'

class Wechat::SNS::UserProfile

  extend Wechat::Core::Common

  # 第四步：拉取用户信息(需scope为 snsapi_userinfo)
  # http://mp.weixin.qq.com/wiki/9/01f711493b5a02f24b04365ac5d8fd95.html#.E7.AC.AC.E5.9B.9B.E6.AD.A5.EF.BC.9A.E6.8B.89.E5.8F.96.E7.94.A8.E6.88.B7.E4.BF.A1.E6.81.AF.28.E9.9C.80scope.E4.B8.BA_snsapi_userinfo.29
  #
  # Return hash format if success:
  # {
  #   openid:     <OPEN_ID>,
  #   nickname:   <NICK_NAME>,
  #   sex:        <GENDER_CODE>,                         # 用户的性别，值为1时是男性，值为2时是女性，值为0时是未知
  #   city:       <CITY_NAME>,                           # 普通用户个人资料填写的城市
  #   province:   <PROVINCE_NAME>,                       # 用户个人资料填写的省份
  #   country:    <COUNTRY_NAME>,                        # 国家，如中国为CN
  #   headimgurl: <HEAD_IMAGE_LINK>,                     # 用户头像，最后一个数值代表正方形头像大小（有0、46、64、96、132数值可选，0代表640*640正方形头像），用户没有头像时该项为空。若用户更换头像，原有头像URL将失效。
  #   privilege:  [ <PRIVILEGE_1>, <PRIVILEGE_2>, ... ], # 用户特权信息，json 数组，如微信沃卡用户为（chinaunicom）
  #   unionid:    <UNION_ID>                             # 只有在用户将公众号绑定到微信开放平台帐号后，才会出现该字段。
  # }
  #
  # Return hash format if failure:
  # {
  #   errcode: <ERROR_CODE>,
  #   errmsg:  <ERROR_MESSAGE>
  # }
  def self.load(access_token, open_id, language: Wechat::Core::Common::LANGUAGE_SIMPLIFIED_CHINESE)

    assert_present! :access_token, access_token
    assert_present! :open_id, open_id
    #raise ArgumentError.new('The access_token argument is required.') if access_token.blank?

    message = ::JSONClient.new.get 'https://api.weixin.qq.com/sns/userinfo',
      {
        access_token: access_token,
        openid:       open_id,
        lang:         language
      }
    message.body
    #body = message.body
    #body.is_a?(Hash) ? body : JSON.parse(body)
  end

end
