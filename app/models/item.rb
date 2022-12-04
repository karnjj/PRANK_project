class Item < ApplicationRecord
    has_one_attached :image do |attachable|
        attachable.variant :thumb, resize_to_limit: [64, 64]
      end
end
