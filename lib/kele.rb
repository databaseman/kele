require 'httparty'
require 'json'
require 'roadmap'

class Kele
  include HTTParty
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

	def get_roadmap(roadmap_id) #31
		response = self.class.get( "/roadmaps/#{roadmap_id}", headers: {'authorization' => @auth_token} )
		JSON.parse(response.body)
	end

	def get_checkpoint(checkpoint_id) #2160
		response = self.class.get( "/checkpoints/#{checkpoint_id}", headers: {'authorization' => @auth_token} )
		JSON.parse(response.body)
	end

end
