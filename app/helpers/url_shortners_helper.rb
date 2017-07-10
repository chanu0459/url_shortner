module UrlShortnersHelper
	# It will generate a unique key of length 7 
	def generate_unique_code
		key = UrlShortnersHelper.get_unique_key
		short_url = UrlShortner.where(unique_code: key).where("expires_at > ?" , Time.now()).first
	  	while short_url.present? && short_url.unique_code.present?
	  		key = UrlShortnersHelper.get_unique_key
	  		short_url = UrlShortner.where(unique_code: key).where("expires_at > ?" , Time.now()).first
	  	end
	  	key
	end

	def get_unique_key
		key = rand(2**222).to_s(22)[0..7]
		key
	end
	module_function :generate_unique_code,:get_unique_key
end
