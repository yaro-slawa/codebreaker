require 'spec_helper'

module Codebreaker
  describe Game do
    context "#start" do
      let(:game) {Game.new}

      before {game.start}

      it "generates secret code" do
        expect(game.instance_variable_get(:@secret_code)).not_to be_empty 
      end
      it "saves 4 numbers secret code" do
        expect(game.instance_variable_get(:@secret_code).length).to eql(4)
      end
      it "saves secret code with numbers from 1 to 6" do
        expect(game.instance_variable_get(:@secret_code)).to match(/[1-6]+/)
      end
    end

    context "#guess" do
      let(:game) {Game.new}

      before {game.start}

      it "receive user's guess" do
        allow(game.guess("1234")).to receive(:code)
      end 

      it "increments attempts that are made" do
        old = game.instance_variable_get(:@attempts_made)
        game.guess("1234")
        expect(game.instance_variable_get(:@attempts_made)).to eql(old + 1)
      end

      it "makrs up user's guess"
    end 

    context "#hint" do
      let(:game) {Game.new}

      before {game.start}

      it "increments hints that are made" do
        old = game.instance_variable_get(:@hints_made)
        game.hint
        expect(game.instance_variable_get(:@hints_made)).to eql(old + 1)
      end
    end
  end
end