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

  end

end
