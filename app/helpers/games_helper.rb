module GamesHelper

  def current_user_color_for_game(game)
    if current_user == game.white_user
      "white"
    else
      "black"
    end
  end

end
