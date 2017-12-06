class ImportGoogleContacts < BaseService
	attr_accessor :access_token, :current_user

	def initialize(access_token, current_user)
		@access_token = access_token
		@current_user = current_user
	end

	def call
		import_contacts
	end

	private

	def get_contacts
		JSON.parse(open("https://www.google.com/m8/feeds/contacts/default/full?max-results=50&alt=json", "Authorization" =>  "Bearer #{access_token}", "GData-Version" => "3.0").read)
	end

	def contacts
		get_contacts["feed"]["entry"].collect{ |p|
      {
        first_name: (p["gd$name"]["gd$givenName"]["$t"] unless p["gd$name"].nil?),
        last_name:  (p["gd$name"]["gd$familyName"]["$t"] unless p["gd$name"].nil? || p["gd$name"]["gd$familyName"].nil?),
        email: (p["gd$email"][0]['address'] unless p["gd$email"].nil?),
        phone: (p["gd$phoneNumber"][0]["$t"] unless p["gd$phoneNumber"].nil?)
      }
    }
	end

	def import_contacts
		contacts.each do |contact|
      begin
      	Contact.create_contact(contact[:email], current_user)
      rescue StandardError => e
        puts "===#{e.inspect}======"
      end
    end
	end
end