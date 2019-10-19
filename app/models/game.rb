class Game < ApplicationRecord

  belongs_to :white_user, class_name: "User", inverse_of: :games_as_white_user
  belongs_to :black_user, class_name: "User", inverse_of: :games_as_black_user

  def players
    [white_user, black_user]
  end

end
