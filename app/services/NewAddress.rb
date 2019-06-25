require 'lob'
class NewAddress < ActiveInteraction::Base
	string :first_name
	string :last_name
	# string :verification_code
	string :line1
	string :line2
	string :city
	string :state
	string :zip
	# string :date
	# string :expiration_date

	

	def execute
		lob = Lob::Client.new(api_key: Rails.application.credentials.dig(:lob, :api_key))
		uuid = SecureRandom.uuid
		date = DateTime.now.to_date
		expiration_date = date.next_day(60)
		letter = lob.letters.create(description: "Address Verification",
to: { address_line1: line1,
address_line2: line2, 
address_city: city, 
address_state: state, 
address_zip: zip, 
name: "#{first_name} #{last_name}"},
from: "adr_ff1159f828ab056e",
# from: "adr_e2fb4570168d5a26", # scenic 
file: "tmpl_10151c8d0b33226",  # testing
# file: "tmpl_f6017546a2aebe7",
merge_variables: {name: first_name, date: date.strftime('%B %e, %Y'), expiration_date: expiration_date.strftime('%B %e, %Y'), verification_code: uuid}, color: false)
		address = Address.create!(
			first_name: first_name,
			last_name: last_name,
			city: city,
			state: state,
			zip: zip,
			line1: line1,
			line2: line2,
			letter_status: 'created',
			letter_id: letter["id"],
			letter: letter,
			verification_code: uuid
		)
		address
	end
end