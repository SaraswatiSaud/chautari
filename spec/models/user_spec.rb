require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }

  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password) }

  it 'is valid with email and password' do
    expect(user).to be_valid
  end

  context 'Email address' do
    it 'is invalid if it is too long' do
      user.email = 'a' * 244 + '@example.com'
      expect(user).to_not be_valid
    end

    it 'is valid upto 255 characters' do
      user.email = 'a' * 243 + '@example.com'
      expect(user).to be_valid
    end

    it 'is reject with invalid email address' do
      invalid_addresses = %w[user@example,com user_at_sign.com user.name@example. foo@bar_baz.com foo@bar+baz.com]
      invalid_addresses.each do |invalid_address|
        user.email = invalid_address
        expect(user).to_not be_valid
      end
    end

    it 'should have valid email address' do
      valid_addresses = %w[user@example.com USER@foo.com U_S-ER@foo.bar.org first.last@foo.jp first+last@foo.com]
      valid_addresses.each do |valid_address|
        user.email = valid_address
        expect(user).to be_valid
      end
    end

    it 'is invalid with duplicate email address' do
      new_user = build(:user, email: user.email)
      new_user.valid?
      expect(new_user.errors[:email]).to include('has already been taken')
    end

    it 'be saved in lower case' do
      mixed_case_email = 'Admin@EXAmple.com'
      user.email = mixed_case_email
      user.save
      expect(mixed_case_email.downcase).to eq(user.reload.email)
    end
  end

  context 'Password' do
    it 'is valid if contain atleast 6 characters long password' do
      user.password = '6 characters long'
      expect(user).to be_valid
    end

    it 'is invalid if less than 6 characters' do
      user.password = 'five'
      expect(user).to_not be_valid
    end
  end
end
