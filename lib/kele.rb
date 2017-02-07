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
	
	# Since I don't know how to get more than 10 records per page#, I just going to return the 10 records per page#
	def get_messages( page=0 )
	  result = []
	  if page > 0
	    response = self.class.get( '/message_threads', body: { page: page }, headers: {'authorization' => @auth_token} )
	    JSON.parse( response.body )
	  else
	    response = self.class.get( '/message_threads', body: { page: 1 }, headers: {'authorization' => @auth_token} )
      for page in 1..(response["count"]/10 + 1)
        response = self.class.get( '/message_threads', body: { page: page }, headers: {'authorization' => @auth_token} )
        result << JSON.parse(response.body)
      end
      result
	  end
	end # get_message
	
	def create_message ( email, recipient_id, token, subject, text )
	  body = 
	  { 
	    sender: email,
      recipient_id: recipient_id,
      token: token,
      subject: subject,
      "stripped-text": text
    }
    self.class.post( "/messages", body: body, headers: {'authorization' => @auth_token} ) 
	end
	
end
