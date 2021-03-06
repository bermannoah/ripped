require 'rails_helper'

describe "Profile" do
  context "#find_user" do
    it "returns a user's information", :vcr do
        token = ENV["census_token"]
        id = 20
        user = Profile.find_user(token, id)

        expect(user).to be_a(Profile)
        expect(user.first_name).to eq("Anna")
        expect(user.last_name).to eq("Dolan")
        expect(user.cohort).to eq("1608-BE")
    end
  end

  context "#all_users" do
    it "returns an array of all users' information", :vcr do
        token = ENV["census_token"]
        users = Profile.all_users(token)
        user = users.first

        expect(users).to be_an(Array)
        expect(user).to be_a(Profile)
    end
  end
end
