require 'HTTParty'
require 'json'
class Kele
  include HTTParty

  def initialize(email, password)
    @base_url = "https://www.bloc.io/api/v1"
    response = self.class.post(@base_url+"/sessions", body: {email: email, password: password})
    @auth_token = response["auth_token"]
    raise "Invalid email password combo" if @auth_token == nil
  end

  def get_me
    url = @base_url+'/users/me'
    response = self.class.get(url, headers: { "authorization" => @auth_token })
    user_data = JSON.parse(response.body)
  end

end
