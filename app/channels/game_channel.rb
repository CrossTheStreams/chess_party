class GameChannel < ApplicationCable::Channel

  def subscribed
    game = Game.find(params[:id])
    stream_for(game)
    Rails.logger.info("Successfully subscribed!")
  end

end
