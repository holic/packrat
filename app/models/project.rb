class Project < ApplicationRecord
  has_many :updates

  has_many :permissions
  has_many :wallets, through: :permissions
end
