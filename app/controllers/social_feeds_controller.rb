class SocialFeedsController < ApplicationController

  def index
    feed_response = SocialFeedRequest.new.call

    if feed_response.success?
      render json: feed_response.data, status: :ok
    else
      render json: { error_message: 'Something went wrong.' }, status: 500
    end
  end
end
