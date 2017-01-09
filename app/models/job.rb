class Job < ApplicationRecord
  belongs_to :category
  validates :title, presence:true
end
