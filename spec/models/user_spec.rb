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

    it "validates that password isn't empty" do
      @user.password = nil
      @user.password_confirmation = nil

      @user.save

      expect(@user.errors.full_messages).to include("Password can't be blank")
    end

  end
end
