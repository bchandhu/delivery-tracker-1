# == Schema Information
#
# Table name: deliveries
#
#  id                     :bigint           not null, primary key
#  arrived                :boolean
#  description            :string
#  details                :text
#  supposed_to_arrived_on :date
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  user_id                :integer
#
class Delivery < ApplicationRecord
  validates(:description, presence: true)
  validates(:supposed_to_arrived_on, presence: true)
end
