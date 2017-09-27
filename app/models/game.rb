class Game < ApplicationRecord

  belongs_to :white_user, class_name: "User", inverse_of: :games_as_white_user
  belongs_to :black_user, class_name: "User", inverse_of: :games_as_black_user

  def players
    [white_user, black_user]
  end

  def color_for_user(user)
    if user.id == white_user_id
      "w"
    elsif user.id == black_user_id
      "b"
    end
  end

end
