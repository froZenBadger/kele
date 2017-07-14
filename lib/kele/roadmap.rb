module Roadmap
  def get_roadmap
    url = @base_url+"/roadmaps/#{@roadmap_id}"
    response = self.class.get(url, headers: { "authorization" => @auth_token }, body: {id: @roadmap_id})
    roadmap = JSON.parse(response.body)
  end

  def show_checkpoint_ids
    checkpoint_id_array = []
    id_array = []
    roadmap = get_roadmap
    number_of_sections = roadmap["sections"].count
    number_of_sections.times do |num|
      checkpoint_id_array << roadmap["sections"][num]["checkpoints"][0]["id"]
    end
    checkpoint_id_array
  end

  def get_checkpoint(checkpoint_id)
    url = @base_url+"/checkpoints/#{checkpoint_id}"
    response = self.class.get(url, headers: { "authorization" => @auth_token })
    checkpoint = JSON.parse(response.body)
  end
end
