require 'rails_helper'

RSpec.describe GamesController, type: :controller do

  let!(:user) { create(:user) }

  describe "#create" do

    let(:color) { "white" }
    let(:create_params) do
      {
        "game" => {
          "opponent" => "lukeskywalker@rebels.com",
          "side_of_board" => color,
        }
      }
    end

    context "when authenticated" do
      
      before do
        sign_in(user)
      end

      it 'redirects to games#index' do
        post :create, params: create_params
        expect(response).to redirect_to(games_path)
      end

      it 'creates a game' do
        games_count = Game.count
        post :create, params: create_params
        expect(Game.count).to eq(games_count + 1)
      end

      [:white, :black].each do |color|
        
        context "when a user specifies the #{color} side of the board" do

          let(:color) { color }
          
          it "creates a game with the current_user set as the #{color} player" do        
            post :create, params: create_params
            expect(Game.order('created_at desc').limit(1).first.send(:"#{color}_user")).to eq(controller.current_user)
          end

        end

      end

    end

    context "when not authenticated" do

      it 'redirects to /user_sessions/new' do
        post :create, params: create_params
        expect(response).to redirect_to(new_user_session_url)
      end

    end

  end

end
