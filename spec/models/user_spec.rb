require 'rails_helper'

RSpec.describe User, type: :model do
  
  before :each do
    @user = User.new(
      email: 'test@test.test',
      first_name: 'test',
      last_name: 'test2',
      password: 'test123',
      password_confirmation: 'test123'
    )
  end
  
  describe 'Validations' do

    it "is valid with valid attributes" do
      expect(@user).to be_valid
    end
  
    it "is not valid without an email" do
      @user.email = nil
      @user.save
      expect(@user.errors.full_messages).to include 'Email can\'t be blank'
      expect(@user).to_not be_valid
    end

    it "is not valid with existing email" do
      @user2 = User.new(
        email: 'TEST@test.test',
        first_name: 'test',
        last_name: 'test2',
        password: 'test123',
        password_confirmation: 'test123'
      )
      @user2.save
      @user.save
      expect(@user.errors.full_messages[0]).to eq 'Email has already been taken'
      expect(@user).to_not be_valid
    end
  
    it "is not valid without a first name" do
      @user.first_name = nil
      @user.save
      expect(@user.errors.full_messages[0]).to eq 'First name can\'t be blank'
      expect(@user).to_not be_valid
    end
  
    it "is not valid without a last name" do
      @user.last_name = nil
      @user.save
      expect(@user.errors.full_messages[0]).to eq 'Last name can\'t be blank'
      expect(@user).to_not be_valid
    end
  
    it "is not valid without a password" do
      @user.password = nil
      @user.save
      expect(@user.errors.full_messages[0]).to eq 'Password can\'t be blank'
      expect(@user).to_not be_valid
    end

    it "is not valid without a password match" do
      @user.password_confirmation = 'test321'
      @user.save
      expect(@user.errors.full_messages[0]).to eq 'Password confirmation doesn\'t match Password'
      expect(@user).to_not be_valid
    end

    it "is not valid with a password thats too short" do
      @user.password = 'test'
      @user.password_confirmation = 'test'
      @user.save
      expect(@user.errors.full_messages[0]).to eq 'Password is too short (minimum is 6 characters)'
      expect(@user).to_not be_valid
    end

  end

  describe '.authenticate_with_credentials' do

    before :each do
      @user = User.new(
        email: 'test@test.test',
        first_name: 'test',
        last_name: 'test2',
        password: 'test123',
        password_confirmation: 'test123'
      )
    end

    it "can authenticate with email and password" do
      @user.save
      expect(User.authenticate_with_credentials(@user.email, @user.password)).to eq @user
    end

    it "can authenticate with space leading or trailing email and password" do
      @user.save
      expect(User.authenticate_with_credentials('  ' + @user.email + '  ', @user.password)).to eq @user
    end
    
    it "can authenticate with wrong case email and password" do
      @user.save
      expect(User.authenticate_with_credentials(@user.email.upcase, @user.password)).to eq @user
    end

    it "will not authenticate with incorrect password" do
      @user.save
      expect(User.authenticate_with_credentials(@user.email, 'wrong')).to eq nil
    end

    it "will not authenticate with non-existing email" do
      @user.save
      expect(User.authenticate_with_credentials('wrong', @user.password)).to eq nil
    end

  end
end
