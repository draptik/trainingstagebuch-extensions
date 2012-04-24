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

class Route < ActiveRecord::Base
	has_and_belongs_to_many :users
	attr_accessible :route_id, :name, :comment, :lastchange, :km, :gpsies

  validates :route_id, presence: true, uniqueness: true
  validates :name, presence: true

end
