require 'rails_helper'

RSpec.describe User, type: :model do

  let!(:user) { create(:user) }
  let!(:other_user) { create(:user, email: "lukeskywalker@rebels.com") }

  context 'with an email address and password' do

    it 'is valid' do 
      expect(user.email).to be_present
      expect(user.password).to be_present
      expect(user).to be_valid
    end
    
  end

  describe 'associations' do

    sides = [:white, :black]
    sides.each do |side|
      other_side = sides.find do |color|
        color != side
      end
      association = :"games_as_#{side}_user"
      describe association do
        context "when the user has never played a game" do
          it 'is empty' do
            expect(user.send(association)).to be_empty
          end
        end
        context "when a Game has the user as the #{side}_user" do
          let!(:game) do
            create(:game, {:"#{side}_user" => user, :"#{other_side}_user" => other_user})
          end
          it 'contains the game' do
            expect(user.send(association)).to include(game)
          end
        end
      end
      
    end

  end

  describe 'methods' do
    
    describe '#games' do

      context "when the user has never played a game" do
        it 'is empty' do
          expect(user.games).to be_empty
        end
      end

      context "when the user has started a Game" do
        let!(:game) do
          create(:game, white_user: user, black_user: other_user)
        end
        it 'contains the game' do
          expect(user.games).to include(game)
        end
      end

      context "when the user has started two games" do
        let!(:game1) do
          create(:game, white_user: user, black_user: other_user)
        end
        let!(:game2) do
          create(:game, white_user: other_user, black_user: user)
        end
        it 'contains both games' do
          expect(user.games).to include(game1)
          expect(user.games).to include(game2)
        end

      end
      
    end

  end

end
