# == Schema Information
#
# Table name: gym_classes
#
#  id         :integer          not null, primary key
#  name       :string
#  start_time :string
#  end_time   :string
#  day        :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class GymClass < ActiveRecord::Base
  extend Enumerize

  enumerize :day in: Date::DAYNAMES.downcase

  validates_presence_of :name, :start_time, :end_time


end
