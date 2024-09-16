class HelplineSerializer
  def initialize(helpline)
    @helpline = helpline
  end

  def serialize_index
    {
      id: @helpline['id'],
      name: @helpline['name'],
      description: @helpline['description'],
      website: @helpline['website'] # Comma was missing here before
    }
  end

  def serialize_show
    {
      id: @helpline['id'],
      name: @helpline['name'],
      description: @helpline['description'],
      website: @helpline['website'],
      phoneNumber: @helpline['phoneNumber'],
      smsNumber: @helpline['smsNumber'],
      webChatUrl: @helpline['webChatUrl'],
      topics: @helpline['topics'],
      country: @helpline['country'],
      timezone: @helpline['timeZone']
    }
  end
end
