class Url < ApplicationRecord
  has_many :contents

  validates :link,
      presence: true,
      format: {:with => URI::regexp(%w(http https))},
      length: {minimum: 8, maximum: 1000}, # this is for example only
      uniqueness: true
end
