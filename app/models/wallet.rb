class Wallet < ApplicationRecord
  has_many :permissions
  has_many :managed_projects, through: :permissions, source: :project

  has_many :follows
  has_many :projects, through: :follows
end
