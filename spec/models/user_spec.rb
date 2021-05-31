require 'rails_helper'

RSpec.describe User, type: :model do
  describe "Validations" do

    before(:each) do
      @user = User.new
    end

    it "validates password" do
      @user.password = 'password'
      @user.password_confirmation = 'notpassword'

      @user.save

      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

  end
end
