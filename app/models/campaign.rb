class Campaign < ActiveRecord::Base
  belongs_to :organization

  validates :name, :organization_id, :amount, :end_date, :description, presence: true

  def tags_flat=(value)
    tag_values = value.split(',').each{|tag| tag.strip!}
    self.tags = tag_values
  end

  def tags_flat
    self.tags.join(',')
  end
end
