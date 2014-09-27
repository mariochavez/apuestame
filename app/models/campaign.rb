class Campaign < ActiveRecord::Base
  belongs_to :organization

  validates :name, :organization_id, :amount, :end_date, :description, presence: true
end
