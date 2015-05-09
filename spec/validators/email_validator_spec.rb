require 'spec_helper'

describe EmailValidator do
  subject { klass.new }

  context 'email must be in the valid format' do
    let(:klass) do
      Class.new do
        include ActiveModel::Validations
        attr_accessor :email, :name
        validates :email, email: true
      end
    end

    it { is_expected.to allow_value('super.user@example.com').for(:email) }
    it { is_expected.to allow_value('super+user@example.com').for(:email) }
    it { is_expected.not_to allow_value('user_example.com').for(:email) }

    it { is_expected.to ensure_valid_email_format_of(:email) }
    it { is_expected.not_to ensure_valid_email_format_of(:name) }
  end

  context 'email must be in the specific domain' do
    context 'no email domain is specified' do
      let(:klass) do
        Class.new do
          include ActiveModel::Validations
          attr_accessor :email, :name
          validates :email, email: { domain: nil }
        end
      end

      it { is_expected.to allow_value('user@example.edu').for(:email) }
      it { is_expected.to allow_value('user@example.com').for(:email) }
    end

    context 'email domain is specified as string' do
      let(:klass) do
        Class.new do
          include ActiveModel::Validations
          attr_accessor :email, :name
          validates :email, email: { domain: '.edu' }
        end
      end

      it { is_expected.to allow_value('user@example.edu').for(:email) }
      it { is_expected.not_to allow_value('user@example.com').for(:email) }
    end

    context 'email domains are specified as an array of strings and symbols' do
      let(:klass) do
        Class.new do
          include ActiveModel::Validations
          attr_accessor :email, :name
          validates :email, email: { domain: %w(.com .edu .Com.Au example.org) }
        end
      end

      it { is_expected.to allow_value('user@example.com').for(:email) }
      it { is_expected.to allow_value('user@example.edu').for(:email) }
      it { is_expected.to allow_value('user@example.org').for(:email) }
      it { is_expected.to allow_value('user@example.com.au').for(:email) }
      it { is_expected.to allow_value('user@example.Com.Au').for(:email) }
      it { is_expected.not_to allow_value('user@example.net').for(:email) }
    end
  end
end
