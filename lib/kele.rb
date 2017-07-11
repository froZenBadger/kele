require 'httparty'

class Kele
  include HTTParty

  def initialize(email, password)
    @base_url = "https://www.bloc.io/api/v1/sessions"
    # @token = JWToken
  end
end
