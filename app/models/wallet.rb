class Wallet < ApplicationRecord
  has_many :permissions
  has_many :projects, through: :permissions
end
