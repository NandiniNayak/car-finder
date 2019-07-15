class Car < ApplicationRecord
    belongs_to :seller
    # associate to the active storage images
    has_many_attached :pictures
    # while listing the car the buyer value could be nil
    belongs_to :buyer, optional: true
end
