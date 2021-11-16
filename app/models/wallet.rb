class Wallet < ApplicationRecord
  has_many :permissions
  has_many :projects, through: :permissions

  has_many :follows
  has_many :projects, through: :follows
end
