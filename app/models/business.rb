class Business < ApplicationRecord
  validates :name, :address, :city, :state, :post_code, :phone_number, :contact_email, presence: true
  validates :name, uniqueness: true
  
  belongs_to :owner, class_name: "Employee", optional: true
  has_many :employees 

  accepts_nested_attributes_for :employees

  def full_address
    [address, without_street_address].compact.join(', ')
  end

  def without_street_address
    [city, state, post_code].compact.join(', ')
  end
end
