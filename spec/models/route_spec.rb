# == Schema Information
#
# Table name: routes
#
#  id          :integer         not null, primary key
#  route_id    :integer
#  name        :string(255)
#  km          :decimal(, )
#  gpsies      :string(255)
#  comment     :text
#  lastchanged :datetime
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#

require 'spec_helper'

describe Route do
  
	#let(:user) { FactoryGirl.create(:user) }
	#before { @route = user.routes.build(FactoryGirl.create(:route)) }
	let(:route) { FactoryGirl.create(:route) }

	subject { route }

	it { should respond_to(:route_id) } 
	it { should respond_to(:name) } 
	it { should respond_to(:km) } 
	it { should respond_to(:gpsies) } 
	it { should respond_to(:comment) } 
	it { should respond_to(:lastchanged) } 
	
	it { should respond_to(:users) } 

	it { should be_valid }

	describe "when name is not present" do
    before { route.name = " " }
    it { should_not be_valid }
  end

  describe "when route_id is not present" do
    before { route.route_id = nil }
    it { should_not be_valid }
  end 

end
