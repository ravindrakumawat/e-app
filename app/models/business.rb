class Business < ApplicationRecord
  validates :name, presence: true
  validates :name, uniqueness: true
  
  belongs_to :owner, class_name: "Employee", optional: true
  has_many :employees, dependent: :destroy 
  has_many :social_accounts, dependent: :destroy
  has_many :contact_infos, dependent: :destroy

  accepts_nested_attributes_for :employees
  accepts_nested_attributes_for :social_accounts
  accepts_nested_attributes_for :contact_infos

  def self.search(query = nil)
    if query
      BusinessSearch.new.find_by_query(query)
    else
      all.as_json(only: [:name, :logo, :domain])
    end
  end

  def self.search_or_create_by_domin(domain_str)
    business = find_by(domain: domain_str)
    return business if business
    
    if params = BusinessSearch.new.search_by_domin(domain_str)
      business = new(params)
      return business if business.save
    end
  end

  def full_address
    [address, without_street_address].compact.join(', ')
  end

  def without_street_address
    [city, state, post_code].compact.join(', ')
  end
end
