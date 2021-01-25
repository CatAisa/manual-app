class Release < ApplicationRecord
  belongs_to :user
  belongs_to :manual
end
