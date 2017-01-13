class GamesController < ApplicationController

  before_action :authenticate_user!

  def index
    @games = current_user.games.includes(:white_user, :black_user)
  end

  def show
    @game = Game.find(params[:id])
  end

  def new
    @users = User.all.where.not(id: current_user.id)
  end

  def create
    color = if ["white", "black"].include?(game_params[:side_of_board])
      game_params[:side_of_board] 
    end

    if color.present?
      opponent_color = if color == "white"
        "black" 
      else
        "white" 
      end
      opponent = User.where(email: game_params[:opponent]).first
      opponent = if opponent.blank?
        # If opponent is new, for now, give a temporary pw.
        temp_password = SecureRandom.hex
        user = User.create!(email: game_params[:opponent], password: temp_password, password_confirmation: temp_password)
      end
      if Game.create(:"#{color}_user" => current_user, :"#{opponent_color}_user" => opponent)
        flash[:notice] = "Game successfully created."
        redirect_to games_path
      end
    else
      raise "Not given a valid color"
    end
  end

  def update
  end

  private 

  def game_params 
    params.require(:game).permit(:opponent, :side_of_board)
  end

end
