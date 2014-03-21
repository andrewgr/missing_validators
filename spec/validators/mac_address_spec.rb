require 'spec_helper'

describe MacAddressValidator do
  context "MAC address has valid format" do
    let(:klass) do
      Class.new do
        include ActiveModel::Validations
        attr_accessor :mac, :name
        validates :mac, mac_address: true
      end
    end

    subject { klass.new }

    it { should ensure_valid_mac_address_format_of(:mac) }
    it { should_not ensure_valid_mac_address_format_of(:name) }

    # Valid formats
    it { should allow_value("08:00:2b:01:02:03").for(:mac) }
    it { should allow_value("08-00-2b-01-02-03").for(:mac) }
    it { should allow_value("08.00.2b.01.02.03").for(:mac) }
    it { should allow_value("08 00 2b 01 02 03").for(:mac) }
    it { should allow_value("08002b:010203").for(:mac) }
    it { should allow_value("08002b.010203").for(:mac) }
    it { should allow_value("08002b-010203").for(:mac) }
    it { should allow_value("0800.2b01.0203").for(:mac) }
    it { should allow_value("0800-2b01-0203").for(:mac) }
    it { should allow_value("0800 2b01 0203").for(:mac) }
    it { should allow_value("08002b010203").for(:mac) }

    # Mixed Separators
    it { should_not allow_value("08-00:2b:01:02:03").for(:mac) }
    it { should_not allow_value("08.00:2b:01:02:03").for(:mac) }
    it { should_not allow_value("08 00:2b:01:02:03").for(:mac) }
    it { should_not allow_value("0800-2b01:0203").for(:mac) }
    it { should_not allow_value("0800 2b01 0203").for(:mac) }

    # Too Short
    it { should_not allow_value("08:00:2b:01:02").for(:mac) }
    it { should_not allow_value("08-00-2b-01-02").for(:mac) }

    # Too Long
    it { should_not allow_value("08:00:2b:01:02:03:04").for(:mac) }

    # Non-Hex Characters
    it { should_not allow_value("qq:00:00:00:00:00").for(:mac) }


    it { should_not allow_value("invalid").for(:mac) }
  end
end
