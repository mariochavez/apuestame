class Donation < ActiveRecord::Base
  belongs_to :reward
  belongs_to :identity
end
