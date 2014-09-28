class Campaign < ActiveRecord::Base
  belongs_to :identity
  has_many :rewards

  accepts_nested_attributes_for :rewards, allow_destroy: true

  delegate :name, to: :identity, prefix: true
  delegate :id, to: :identity, prefix: true

  validates :name, :identity_id, :address, :amount,
    :end_date, :description, presence: true
  validates :end_date, future_date: true
  validates :amount, numericality: { greater_than_or_equal_to: 1000 }

  geocoded_by :address
  after_validation :geocode, :if => :address_changed?

  def tags_flat=(value)
    tag_values = value.split(',').each{|tag| tag.strip!}
    self.tags = tag_values
  end

  def tags_flat
    self.tags.join(',')
  end

  scope :active, -> { where('end_date >= ?', Date.today)  }
  scope :my_campaigns, ->(identity) { where(identity: identity) }
  scope :recent, -> { order('created_at DESC') }

end
