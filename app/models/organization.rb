class Organization < ActiveRecord::Base
  has_secure_password validations: true

  validates :email, presence: true, uniqueness: true
  validates :password_confirmation, presence: true, if: -> r { r.password.present? }

  validates :Name, presence: true
  validates :Address, presence: true
  validates :Description, presence: true
  validates :RFC, presence: true
  validates :Paypal, presence: true

end
