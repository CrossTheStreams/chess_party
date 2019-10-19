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
    color = if ["white", "black"].include?(create_params[:side_of_board])
      create_params[:side_of_board] 
    end

    if color.present?
      opponent_color = if color == "white"
        "black" 
      else
        "white" 
      end
      opponent = User.where(email: create_params[:opponent]).first
      opponent = if opponent.blank?
        # If opponent is new, for now, give a temporary pw.
        temp_password = SecureRandom.hex
        user = User.create!(email: create_params[:opponent], password: temp_password, password_confirmation: temp_password)
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
    @game = Game.find(update_params[:id])
    if @game.fen == update_params[:old_fen]
      if @game.update(fen: update_params[:fen])
        GameChannel.broadcast_to(@game, game: @game)
      end
    else
      raise StandardError.new("not the current user's turn")
    end
    respond_to do |format|
      format.json do
        render json: {game: @game}.to_json
      end
    end
  end

  private 

  def create_params
    params.require(:game).permit(:opponent, :side_of_board)
  end

  def update_params
    params.require(:game).permit(:id, :fen, :old_fen)
  end

end
