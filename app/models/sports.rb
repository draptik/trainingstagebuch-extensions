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

class Sports < ActiveRecord::Base

  attr_accessible :id, :name, :comment, :lastchange
  validates :id, presence: true, uniqueness: true

end
