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
#  sport_id   :integer
#

class Sport < ActiveRecord::Base
  has_and_belongs_to_many :users
  
  attr_accessible :sport_id, :name, :comment, :lastchange
  validates :sport_id, presence: true, uniqueness: true
  validates :name, presence: true
end
