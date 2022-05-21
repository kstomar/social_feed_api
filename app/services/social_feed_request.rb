class SocialFeedRequest < Base
  SOCIAL_NETWORK_DATA_MAPPINGS = {
    facebook: 'status',
    instagram: 'photo',
    twitter: 'tweet'
  }.freeze

  def initialize
    super
    @client = SocialFeedClient.new
  end

  private

  def perform
    threads = []
    SOCIAL_NETWORK_DATA_MAPPINGS.each do |platform, filter|
      threads << Thread.new do
        response = get(platform, filter)
        @data[platform] = result(response)
      end
    end
    threads.each(&:join)
  end

  def get(platform, filter)
    begin
      response = @client.call(platform).get
      if response.code == 200
        { data: JSON.parse(response.body).map { |res| res[filter] } }
      else
        { error_message: I18n.t('errors.messages.something_wrong') }
      end
    rescue RestClient::Exceptions::Timeout
      { error_message: I18n.t('errors.messages.connection_timeout') }
    rescue RestClient::Exception
      { error_message: I18n.t('errors.messages.something_wrong') }
    end
  end

  def result(response)
    return response[:data] if response[:error_message].blank?

    [{ error_message: response[:error_message] }]
  end
end

