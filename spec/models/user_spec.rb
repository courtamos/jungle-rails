require 'rails_helper'

RSpec.describe User, type: :model do
  describe "Validations" do

    it "validates without errors when valid" do
      @user = User.new(
        first_name: 'Prince',
        last_name: 'Vegeta',
        email: 'vegeta@email.com',
        password: 'password',
        password_confirmation: 'password'
      )

      @user.save

      expect(@user.errors.full_messages).to eq([])
    end

    it "validates password" do
      @user = User.new(
        first_name: 'Prince',
        last_name: 'Vegeta',
        email: 'vegeta@email.com',
        password: 'password',
        password_confirmation: 'notpassword'
      )

      @user.save

      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it "validates that password isn't empty" do
      @user = User.new(
        first_name: 'Prince',
        last_name: 'Vegeta',
        email: 'vegeta@email.com',
        password: nil,
        password_confirmation: nil
      )

      @user.save

      expect(@user.errors.full_messages).to include("Password can't be blank")
    end

    it "validates that emails are unique" do
      @user = User.new(
        first_name: 'Prince',
        last_name: 'Vegeta',
        email: 'vegeta@email.com',
        password: 'password',
        password_confirmation: 'password'
      )
      @user.save

      @usercopy = User.new(
        first_name: 'Prince',
        last_name: 'Vegeta',
        email: 'vegeta@email.com',
        password: 'password',
        password_confirmation: 'password'
      )
      @usercopy.valid?

      expect(@usercopy.errors.full_messages).to include("Email has already been taken")
    end


  end
end
