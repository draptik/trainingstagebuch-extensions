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

class Material < ActiveRecord::Base
	belongs_to :user

	attr_accessible :material_id, :name, :status, 
		:comment, :count, :duration, :distance_km, :lastchange

	validates :user_id, presence: true

	validates_uniqueness_of :user_id, scope: :material_id

	default_scope order: 'materials.material_id ASC'
end
