class Address < ApplicationRecord
  belongs_to :user

  validates :name, :phone, :line1, :city, :state, :pincode, presence: true

  def full_address
    line1 + " " + city + " " + state + " " + pincode
  end
end
