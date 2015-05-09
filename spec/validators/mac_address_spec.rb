require 'spec_helper'

describe MacAddressValidator do
  let(:klass) do
    Class.new do
      include ActiveModel::Validations
      attr_accessor :mac, :name
      validates :mac, mac_address: true
    end
  end

  subject { klass.new }

  it { is_expected.to ensure_valid_mac_address_format_of(:mac) }
  it { is_expected.not_to ensure_valid_mac_address_format_of(:name) }

  context 'when MAC-address is valid' do
    it { is_expected.to allow_value('08:00:2b:01:02:03').for(:mac) }
    it { is_expected.to allow_value('08-00-2B-01-02-03').for(:mac) }
    it { is_expected.to allow_value('08.00.2b.01.02.03').for(:mac) }
    it { is_expected.to allow_value('08 00 2B 01 02 03').for(:mac) }
    it { is_expected.to allow_value('08002b:010203').for(:mac) }
    it { is_expected.to allow_value('08002B.010203').for(:mac) }
    it { is_expected.to allow_value('08002b-010203').for(:mac) }
    it { is_expected.to allow_value('0800.2b01.0203').for(:mac) }
    it { is_expected.to allow_value('0800-2B01-0203').for(:mac) }
    it { is_expected.to allow_value('0800 2b01 0203').for(:mac) }
    it { is_expected.to allow_value('08002b010203').for(:mac) }
  end

  context 'when MAC-address uses different separators' do
    it { is_expected.not_to allow_value('08-00:2b:01:02:03').for(:mac) }
    it { is_expected.not_to allow_value('08.00:2b:01:02:03').for(:mac) }
    it { is_expected.not_to allow_value('08 00:2b:01:02:03').for(:mac) }
    it { is_expected.not_to allow_value('0800-2b01:0203').for(:mac) }
    it { is_expected.not_to allow_value('0800 2B01:0203').for(:mac) }
  end

  context 'when MAC-address is too short' do
    it { is_expected.not_to allow_value('08:00:2b:01:02').for(:mac) }
    it { is_expected.not_to allow_value('08-00-2B-01-02').for(:mac) }
  end

  context 'when MAC-address is too long' do
    it { is_expected.not_to allow_value('08:00:2b:01:02:03:04').for(:mac) }
  end

  context 'when MAC-address includes non-hex digits' do
    it { is_expected.not_to allow_value('qq:00:00:00:00:00').for(:mac) }
  end

  it { is_expected.not_to allow_value('invalid').for(:mac) }
end
