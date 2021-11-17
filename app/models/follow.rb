class Follow < ApplicationRecord
  belongs_to :wallet
  belongs_to :project
end
