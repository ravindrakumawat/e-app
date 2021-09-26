class SocialAccount < ApplicationRecord
  belongs_to :business, optional: true
  validates :social_network, presence: true
end
