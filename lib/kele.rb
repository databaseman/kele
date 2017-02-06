require 'httparty'
require 'json'
require 'roadmap'

class Kele
  include HTTParty
  include Roadmap
  base_uri 'https://www.bloc.io/api/v1'  
  
  def initialize(email, password)
    post_response = self.class.post( 
      '/sessions',
      body: {
        email: email,
        password: password
      }
    )
    if post_response['auth_token'].nil?
      p "Invalid email or password #{email} / #{password}"
    else
      @auth_token = post_response['auth_token']
    end  
  end

  def get_me
		response = self.class.get( '/users/me', headers: {'authorization' => @auth_token} )
		JSON.parse(response.body)
  end
	
	def get_mentor_availability(mentor_id)
		response = self.class.get( "/mentors/#{mentor_id}/student_availability", headers: {'authorization' => @auth_token} )
		JSON.parse(response.body)
	end
	
	def get_message( page=0 )
	  if page >= 0
	    response = self.class.get( '/message_threads', body: { page: page }, headers: {'authorization' => @auth_token} )
	    JSON.parse( response.body )
	  else
	    p "In here"
	  end   
end
