module Messages
  def get_messages(page_number=nil)
    url = @base_url+"/message_threads"
    page_number.nil? ?
      response = self.class.get(url, headers: { "authorization" => @auth_token })
      : response = self.class.get(url+"?page=#{page_number}", headers: { "authorization" => @auth_token })
    messages = JSON.parse(response.body)
  end

  def create_message(sender="cpalmer608@gmail.com", recipient_id=@mentor_id, subject, message)
    url = @base_url+"/messages"
    response = self.class.post(url,
      headers: { "authorization" => @auth_token },
      :body => { "sender" => sender, "recipient_id" => recipient_id, "subject" => subject, "stripped-text" => message })
    message = response
  end
end
