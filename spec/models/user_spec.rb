require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it 'is valid with a valid email, first name, last name, password, and password_confirmation' do
      user = User.new(email: 'test@example.com', first_name: 'Test', last_name: 'User', password: 'password', password_confirmation: 'password')
      expect(user).to be_valid
    end

    it 'is not valid without an email' do
      user = User.new(email: nil)
      expect(user).to_not be_valid
      expect(user.errors[:email]).to include("can't be blank")
    end

    it 'is not valid without a first name' do
      user = User.new(first_name: nil)
      expect(user).to_not be_valid
      expect(user.errors[:first_name]).to include("can't be blank")
    end

    it 'is not valid without a last name' do
      user = User.new(last_name: nil)
      expect(user).to_not be_valid
      expect(user.errors[:last_name]).to include("can't be blank")
    end

    it 'is not valid if the password and password_confirmation do not match' do
      user = User.new(password: 'password', password_confirmation: 'different')
      expect(user).to_not be_valid
    end

    it 'is not valid without a password' do
      user = User.new(password: nil)
      expect(user).to_not be_valid
    end

    it 'requires a unique email (not case sensitive)' do
      User.create(email: 'test@example.com', first_name: 'Test', last_name: 'User', password: 'password', password_confirmation: 'password')
      user = User.new(email: 'TEST@example.com')
      expect(user).to_not be_valid
      expect(user.errors[:email]).to include("has already been taken")
    end

    it 'has a password with a minimum length' do
      user = User.new(password: 'short')
      expect(user).to_not be_valid
    end
  end

  describe '.authenticate_with_credentials' do
    before do
      @user = User.create(email: 'example@domain.com', first_name: 'Example', last_name: 'User', password: 'password123', password_confirmation: 'password123')
    end

    context 'with valid credentials' do
      it 'returns the user' do
        expect(User.authenticate_with_credentials('example@domain.com', 'password123')).to eq(@user)
      end
    end

    context 'with incorrect password' do
      it 'returns nil' do
        expect(User.authenticate_with_credentials('example@domain.com', 'wrongpassword')).to be_nil
      end
    end

    context 'with upcase email' do
      it 'authenticates user irrespective of email case' do
        expect(User.authenticate_with_credentials('EXAMPLE@DOMAIN.COM', 'password123')).to eq(@user)
      end
    end

    context 'with leading/trailing spaces in email' do
      it 'authenticates user successfully' do
        expect(User.authenticate_with_credentials('  example@domain.com  ', 'password123')).to eq(@user)
      end
    end
  end
end