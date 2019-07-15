class Car < ApplicationRecord
    belongs_to :seller
    # associate to the active storage images
    has_many_attached :pictures

    belongs_to :buyer
end
