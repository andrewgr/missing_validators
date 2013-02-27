require 'spec_helper'

describe EmailValidator do
  let(:klass) do
    Class.new do
      include ActiveModel::Validations
      attr_accessor :email, :name
      validates :email, email: true
    end
  end

  context do
    subject(:model){ klass.new }

    it { should ensure_valid_email_format_of(:email) }
    it { should_not ensure_valid_email_format_of(:name) }

    specify "is valid with a valid email address" do
      model.email = "super.user@example.com"
      expect(model).to be_valid
    end

    specify "is valid with a valid email address" do
      model.email = "user@example.com"
      expect(model).to be_valid
    end

    specify "fields have different value" do
      model.email = "user_example.com"
      expect(model).to be_invalid
    end
  end
end
