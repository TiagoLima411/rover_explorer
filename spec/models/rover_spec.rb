require 'rails_helper'

RSpec.describe Rover, type: :model do
  context 'Validates' do
    
    it "Rover must be valid" do
      expect(build(:rover)).to be_valid
    end
    it { is_expected.to validate_presence_of(:comand) }
    it { is_expected.to validate_presence_of(:position) }
  end

  context 'Associations' do
    it { is_expected.to belong_to(:plateau) }
  end

  context 'Instance Methods' do
    before do
      @rover = build(:rover)
      @coordinate = @rover.get_position # takes the first position in the defined area
      @position = @rover.send(:set_position, @coordinate.x, @coordinate.y, @coordinate.orientation)# Create a movement instance
      @orientations = @rover.send(:orientations) # Maps all rover rotation movements
      @run = @rover.send(:forward, @coordinate.x, @coordinate.y) # Moves the rover with respect to its current position
      @move = @rover.comand_move # Use all of the above functions to move the rover.
    end

    it 'X coordinate should be present' do
      expect(@coordinate.x.present?).to eq(true)
    end

    it 'Y coordinate should be present' do
      expect(@coordinate.y.present?).to eq(true)
    end

    it 'coordinate orientation should be present' do
      expect(@coordinate.orientation.present?).to eq(true)
    end

    it 'position should be a instance of Moviment' do
      expect(@position).to be_a_kind_of(Movement)
    end

    it 'orientations should be Hash' do
      expect(@orientations).to be_a_kind_of(Hash)
    end

    it 'orientation should have the Left North key' do
      expect(@orientations.has_key?(:NL)).to eq(true)
    end

    it 'orientation should have the Right North key' do
      expect(@orientations.has_key?(:NR)).to eq(true)
    end

    it 'orientation should have the Left West key' do
      expect(@orientations.has_key?(:WL)).to eq(true)
    end

    it 'orientation should have the Right West key' do
      expect(@orientations.has_key?(:WR)).to eq(true)
    end

    it 'orientation should have the Left South key' do
      expect(@orientations.has_key?(:SL)).to eq(true)
    end

    it 'orientation should have the Right South key' do
      expect(@orientations.has_key?(:SR)).to eq(true)
    end

    it 'orientation should have the Left East key' do
      expect(@orientations.has_key?(:EL)).to eq(true)
    end

    it 'orientation should have the Right East key' do
      expect(@orientations.has_key?(:ER)).to eq(true)
    end

    it 'drive should be Hash' do
      expect(@run).to be_a_kind_of(Hash)
    end

    it 'drive should have the West key' do
      expect(@run.has_key?(:W)).to eq(true)
    end
    
    it 'drive should have the East key' do
      expect(@run.has_key?(:E)).to eq(true)
    end

    it 'drive should have the South key' do
      expect(@run.has_key?(:S)).to eq(true)
    end

    it 'drive should have the North key' do
      expect(@run.has_key?(:N)).to eq(true)
    end

    it 'Last x-axis position' do
      expect(@move.last.x).to eq(1)
    end

    it 'Last y-axis position' do
      expect(@move.last.y).to eq(3)
    end

    it 'Last orientation' do
      expect(@move.last.orientation).to eq("N")
    end
    
  end
end
