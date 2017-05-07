class Content < ApplicationRecord
  belongs_to :url

  validates_associated :url
end
