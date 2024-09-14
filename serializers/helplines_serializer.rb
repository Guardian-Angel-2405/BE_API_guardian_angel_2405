class HelplinesSerializer


  def self.format_helpline(helpline)
    {
      data: [
        {
          id: helpline["id"],
          type: "helpline",
          attributes: {
            id: helpline["id"],
            name: helpline["name"],
            description: helpline["description"],
            website: helpline["website"],
            country: helpline["country"]["name"],
            timezone: helpline["timezone"],
            topics: helpline["topics"],
            phone_number: helpline["phoneNumber"],
            sms_number: helpline["smsNumber"],
            web_chat_url: helpline["webChatUrl"],
          }
        }
      ]
    }
  end

  def self.format_helplines(helplines)
    {
      data: helplines.map do |helpline|
        {
          id: helpline["id"],
          type: "helpline",
          attributes: {
            id: helpline["id"],
            name: helpline["name"],
            description: helpline["description"],
            website: helpline["website"],
          }
        }
      end
    }
  end
end
  #using gem -> install 


  # class HelplineSerializer
  #   include JSONAPI:Serializer
  #   attributes  :name,
  #               :description,
  #               :website,
  #               :country,
  #               :timezone,
  #               :topics,
  #               :phone_number,
  #               :sms_number,
  #               :web_chat_url
  # end