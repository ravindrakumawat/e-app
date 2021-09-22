class Employee < ApplicationRecord
  belongs_to :business

  validates :first_name, :designation, presence: true
  
  def name
    [first_name, last_name].compact.join(" ").titleize
  end
end
