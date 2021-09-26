class ContactInfo < ApplicationRecord
  belongs_to :business, optional: true

  validates :contact, :contact_type, presence: true
end

# class ContactEmail < ContactInfo; end
# class ContactPhone < ContactInfo; end
