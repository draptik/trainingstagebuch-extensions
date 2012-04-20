module TtbSessionsHelper

		# TODO Add error checking
		# TODO Nobody should be able to inject!
    def store_ttb_password(ttb_password)
    	session[:ttb_password] = ttb_password
  	end

  	# TODO Add error checking
  	def retrieve_ttb_password
    	session[:ttb_password]
  	end

end
