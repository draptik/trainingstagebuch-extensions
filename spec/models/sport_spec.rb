# == Schema Information
#
# Table name: sports
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  comment    :string(255)
#  lastchange :datetime
#  created_at :datetime        not null
#  updated_at :datetime        not null
#
require 'spec_helper'

describe Sport do

  let(:user) { FactoryGirl.create(:user) }
  before { 
    @sport = user.sports.build(name: "Hiking", comment: "", lastchange: "2012-04-01 1:00:00")
  }

  subject { @sport }

  it { should respond_to(:name) }
  it { should respond_to(:comment) }
  it { should respond_to(:lastchange) } 
  it { should respond_to(:users) }

  it { should be_valid } # <- NOT VALID. WHY?
  
  describe "when name is not present" do
    before { @sport.name = " " }
    it { should_not be_valid }
  end

  # describe "when name is present" do
  #   before { @sport.name = "fpp" }
  #   puts "XXXXX"
  #   pp @sport
  #   it { should be_valid }
  # end
  
end
