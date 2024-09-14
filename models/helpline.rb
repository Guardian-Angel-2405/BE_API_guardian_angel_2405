class Helpline
  attr  :id,
        :name,
        :description,
        :website,
        :country,
        :timezone,
        :topics,
        :phone_number,
        :web_chat_url

  def initialize(data)
    @id = data[:id]
    @name = data[:name]
    @description = data[:description]
    @website = data[:website]
    @country = data[:country]
    @timezone = data[:timezone]
    @topics = data[:topics]
    @phone_number = data[:phoneNumber]
    @web_chat_url = data[:webChatUrl]
  end
end