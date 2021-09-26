class SocialAccount < ApplicationRecord
  belongs_to :business, optional: true
end
