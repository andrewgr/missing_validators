require 'spec_helper'

describe EmailValidator do
  class User
    include ActiveModel::Validations
    attr_accessor :email, :name
    validates :email, email: true
  end

  context do
    subject(:user){ User.new }

    it { should ensure_valid_email_format_of(:email) }
    it { should_not ensure_valid_email_format_of(:name) }

    specify "is valid with a valid email address" do
      user.email = "super.user@example.com"
      expect(user).to be_valid
    end

    specify "is valid with a valid email address" do
      user.email = "user@example.com"
      expect(user).to be_valid
    end

    specify "fields have different value" do
      user.email = "user_example.com"
      expect(user).to be_invalid
    end
  end
end
