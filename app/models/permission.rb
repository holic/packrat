class Permission < ApplicationRecord
  belongs_to :project
  belongs_to :wallet
end
