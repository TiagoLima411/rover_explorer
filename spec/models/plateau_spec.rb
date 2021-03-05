require 'rails_helper'

RSpec.describe Plateau, type: :model do
  context 'Validates' do
    it "Plateau must be valid" do
      expect(create(:plateau)).to be_valid
    end
    it { expect{ create(:plateau) }.to change{Plateau.all.size}.by(1) }
    it { is_expected.to validate_presence_of(:size) }
    it { is_expected.to_not allow_value("ZZ").for(:size) }
    it { is_expected.to allow_value("64").for(:size) }
  end

  context 'Associations' do
    it { is_expected.to have_many(:rovers) }
  end

  context 'Instance Methods' do
    before do
      @plateau = create(:plateau)
      @axis = @plateau.build_axis
      @plateau.send(:set_limits)
    end

    it 'Axis should be present' do
      expect(@axis.present?).to eq(true)
    end

    it 'Axis should be Hash' do
      expect(@axis).to be_a_kind_of(Hash)
    end
    
    it 'X axis should be array' do
      expect(@axis[:x]).to be_a_kind_of(Array)
    end

    it 'Y axis should be array' do
      expect(@axis[:y]).to be_a_kind_of(Array)
    end

    it 'X axis should be greater than 2' do
      expect(@axis[:x].size).to be > 2
    end

    it 'Y axis should be greater than 2' do
      expect(@axis[:y].size).to be > 2
    end
    
    it 'limit x equal size[0]' do
      expect(@plateau.size[0]).to eq(@plateau.limit_x.to_s)
    end

    it 'limit y equal size[1]' do
      expect(@plateau.size[1]).to eq(@plateau.limit_y.to_s)
    end
  end
end
