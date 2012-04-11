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

  before { @sport = Sport.new(name: "Hiking", comment: "", lastchange: "2012-04-01 1:00:00") }

  subject { @sport }

  it { should respond_to(:name) }
  it { should respond_to(:comment) }
  it { should respond_to(:lastchange) }

end
