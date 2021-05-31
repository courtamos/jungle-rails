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

    it "validates that emails are not case senstivie" do
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
        email: 'VEGETA@email.com',
        password: 'password',
        password_confirmation: 'password'
      )
      @usercopy.save

      expect(@usercopy.errors.full_messages).to include("Email has already been taken")
    end

    it "validates that first name is required" do
      @user = User.new(
        first_name: nil,
        last_name: 'Vegeta',
        email: 'vegeta@email.com',
        password: 'password',
        password_confirmation: 'password'
      )

      @user.save

      expect(@user.errors.full_messages).to include("First name can't be blank")
    end

    it "validates that last name is require" do
      @user = User.new(
        first_name: 'Prince',
        last_name: nil,
        email: 'vegeta@email.com',
        password: 'password',
        password_confirmation: 'password'
      )

      @user.save

      expect(@user.errors.full_messages).to include("Last name can't be blank")
    end
  
    it "validates that email is required" do
      @user = User.new(
        first_name: 'Prince',
        last_name: 'Vegeta',
        email: nil,
        password: 'password',
        password_confirmation: 'password'
      )

      @user.save

      expect(@user.errors.full_messages).to include("Email can't be blank")
    end

    it "validates that password must have a minimum length of 8 characters" do
      @user = User.new(
        first_name: 'Prince',
        last_name: 'Vegeta',
        email: 'vegeta@email.com',
        password: 'pass',
        password_confirmation: 'pass'
      )

      @user.save

      expect(@user.errors.full_messages).to include("Password is too short (minimum is 8 characters)")
    end


  end

  describe '.authenticate_with_credentials' do
    it "returns the user when credentials are authenticated" do
      @user = User.new(
        first_name: 'Prince',
        last_name: 'Vegeta',
        email: 'vegeta@email.com',
        password: 'password',
        password_confirmation: 'password'
      )

      @user.save
      @authenticated = User.authenticate_with_credentials(@user.email, @user.password)

      expect(@authenticated).to be_present
    end

    it "does not authenticate when credentials are wrong" do
      @user = User.new(
        first_name: 'Prince',
        last_name: 'Vegeta',
        email: 'vegeta@email.com',
        password: 'password',
        password_confirmation: 'password'
      )

      @user.save
      @authenticated = User.authenticate_with_credentials(@user.email, 'notpassword')

      expect(@authenticated).to be false
    end

    it "returns the user when credentials are authenticated with whitespace or mismatching case" do
      @user = User.new(
        first_name: 'Prince',
        last_name: 'Vegeta',
        email: 'vegeta@email.com',
        password: 'password',
        password_confirmation: 'password'
      )

      @user.save
      @email = '  VEGETA@email.com'
      @authenticated = User.authenticate_with_credentials(@email, @user.password)

      expect(@authenticated).to be_present
      expect(@authenticated.email).to eq(@email)
    end

  end
end
