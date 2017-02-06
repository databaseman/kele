module Roadmap
  
	def get_roadmap(roadmap_id) #31
		response = self.class.get( "/roadmaps/#{roadmap_id}", headers: {'authorization' => @auth_token} )
		JSON.parse(response.body)
	end

	def get_checkpoint(checkpoint_id) #2160
		response = self.class.get( "/checkpoints/#{checkpoint_id}", headers: {'authorization' => @auth_token} )
		JSON.parse(response.body)
	end

end	