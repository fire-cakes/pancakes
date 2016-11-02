require 'rails_helper'

RSpec.describe User, type: :model do
	before :each do
		it "should returns email address" do
			user = FactoryGirl.build(:user)
			expect = user.email
			assert_equal  expected, user.name
		end
	end
end
