class ContactInfo < ApplicationRecord
  belongs_to :business, optional: true
end

# class ContactEmail < ContactInfo; end
# class ContactPhone < ContactInfo; end
