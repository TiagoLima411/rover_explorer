require 'rails_helper'

RSpec.describe Movement, type: :model do

  context 'Validates' do
   
    it "Movement must be valid" do
      expect(create(:movement, :first_movement)).to be_valid
    end
    
    it { expect{ create(:movement, :first_movement) }.to change{Movement.all.size}.by(11) }
    
  end

  context 'Associations' do
    it { is_expected.to belong_to(:rover) }
  end
end
