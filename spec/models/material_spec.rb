# == Schema Information
#
# Table name: materials
#
#  id          :integer         not null, primary key
#  material_id :integer
#  user_id     :integer
#  name        :string(255)
#  status      :string(255)
#  comment     :string(255)
#  count       :integer
#  duration    :decimal(, )
#  distance_km :decimal(, )
#  lastchange  :datetime
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#

require 'spec_helper'

describe Material do
  let(:user) { FactoryGirl.create(:user) }
  before do 
  	@material = user.materials.build(
  								material_id: "123", 
  								name: "material1", 
  								status: "", 
  								count: 1, 
  								duration: 12.23, 
  								distance_km: 100.00, 
  								lastchange: Time.now) 
	end

  subject { @material }

  
  it { should respond_to(:user_id) }
  it { should respond_to(:material_id) }
  it { should respond_to(:name) }
  it { should respond_to(:status) }
  it { should respond_to(:count) }
  it { should respond_to(:duration) }
  it { should respond_to(:distance_km) }
  it { should respond_to(:lastchange) }

  its(:user) { should == user }

  it { should be_valid }

  describe "when user_id is not present" do
  	before { @material.user_id = nil }
  	it { should_not be_valid }
  end

  # describe "accessible attributes" do
  #   it "should not allow access to user_id" do
  #     expect do
  #       Material.new(user_id: user.id)
  #     end.should raise_error(ActiveModel::MassAssignmentSecurity::Error)
  #   end    
  # end
end
