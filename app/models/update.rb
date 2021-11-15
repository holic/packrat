class Update < ApplicationRecord
  belongs_to :project

  validates :project, :title, :body, :category, :publish_at, presence: true
end
