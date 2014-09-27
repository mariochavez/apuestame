class Organization < ActiveRecord::Base
  has_secure_password validations: true

  validates :email, presence: true, uniqueness: true
  validates :password_confirmation, presence: true, if: -> r { r.password.present? }

  validates :name, presence: true
  validates :address, presence: true
  validates :description, presence: true
  validates :rfc, presence: true
  validates :paypal, presence: true

end
