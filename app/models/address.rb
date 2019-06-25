class Address < ApplicationRecord
	has_one_attached :verification_letter
end
