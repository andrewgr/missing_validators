require 'spec_helper'

describe IpAddressValidator do
  subject { klass.new }

  context 'ip_address must be in the valid format' do
    let(:klass) do
      Class.new do
        include ActiveModel::Validations
        attr_accessor :ip, :name
        validates :ip, ip_address: true
      end
    end

    it { is_expected.to allow_value('192.168.10.0').for(:ip) }
    it { is_expected.to allow_value('127.0.0.1').for(:ip) }
    it { is_expected.not_to allow_value('129.512.12.0').for(:ip) }

    it { is_expected.to ensure_valid_ip_address_format_of(:ip) }
    it { is_expected.not_to ensure_valid_ip_address_format_of(:name) }
  end

end
