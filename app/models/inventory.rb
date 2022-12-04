class Inventory < ApplicationRecord
  belongs_to :item
  belongs_to :seller
  belongs_to :user
end
