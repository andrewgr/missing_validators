require 'spec_helper'

describe EmailValidator do
  subject { klass.new }

  context "email has valid format" do
    let(:klass) do
      Class.new do
        include ActiveModel::Validations
        attr_accessor :email, :name
        validates :email, email: true
      end
    end

    it { should allow_value("super.user@example.com").for(:email) }
    it { should allow_value("super+user@example.com").for(:email) }
    it { should_not allow_value("user_example.com").for(:email) }

    it { should ensure_valid_email_format_of(:email) }
    it { should_not ensure_valid_email_format_of(:name) }
  end

  context "email is in the specific domain" do
    context "email domain specified as string" do
      let(:klass) do
        Class.new do
          include ActiveModel::Validations
          attr_accessor :email
          validates :email, email: { domain: "edu" }
        end
      end

      it { should allow_value("user@example.edu").for(:email) }
      it { should_not allow_value("user@example.com").for(:email) }
    end

    context "email set as an array of strings and symbols" do
      let(:klass) do
        Class.new do
          include ActiveModel::Validations
          attr_accessor :email
          validates :email, email: { domain: ['com', :edu, 'Com.Au'] }
        end
      end

      it { should allow_value("user@example.com").for(:email) }
      it { should allow_value("user@example.edu").for(:email) }
      it { should allow_value("user@example.com.au").for(:email) }
      it { should allow_value("user@example.Com.Au").for(:email) }
      it { should_not allow_value("user@example.org").for(:email) }
    end
  end
end
