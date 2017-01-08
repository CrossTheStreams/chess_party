class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :games_as_white_user, foreign_key: "white_user_id", class_name: "Game"
  has_many :games_as_black_user, foreign_key: "black_user_id", class_name: "Game"

  def games
    Game.where("white_user_id = (?) OR black_user_id = (?)", self.id, self.id)
  end

  def opponent_for_game(game)
    game.players.find do |player|
      player != self
    end
  end
  
end
