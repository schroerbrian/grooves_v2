require 'spec_helper'

	describe CitiesController do
		describe "home" do 
			it "renders the city template" do
				get :city
				expect(response).to render_template("city")
		end
	
		# describe "home" do 
		# 	it "should gather several cities"
		# 		get :city
		# 		expect()

			
		end

	end



end 

