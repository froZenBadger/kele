require 'HTTParty'
require 'json'
class Kele
  include HTTParty

  def initialize(email, password)
    @base_url = "https://www.bloc.io/api/v1"
    response = self.class.post(@base_url+"/sessions", body: {email: email, password: password})
    @auth_token = response["auth_token"]
    raise "Invalid email password combo" if response.code != 200
    url = @base_url+'/users/me'
    response = self.class.get(url, headers: { "authorization" => @auth_token })
    user_data = JSON.parse(response.body)
    @mentor_id = user_data["current_enrollment"]["mentor_id"]
    @roadmap_id = user_data["current_enrollment"]["roadmap_id"]
  end

  def get_me
    url = @base_url+'/users/me'
    response = self.class.get(url, headers: { "authorization" => @auth_token })
    user_data = JSON.parse(response.body)
    return "Name: #{user_data["name"]}; Email: #{user_data["email"]}"
  end

  def get_mentor_availability
    url = @base_url+"/mentors/#{@mentor_id}/student_availability"
    response = self.class.get(url, headers: { "authorization" => @auth_token }, body: {id: @mentor_id})
    mentor_availability = JSON.parse(response.body)
  end

  def get_roadmap
    url = @base_url+"/roadmaps/#{@roadmap_id}"
    response = self.class.get(url, headers: { "authorization" => @auth_token }, body: {id: @roadmap_id})
    roadmap = JSON.parse(response.body)
  end
end
