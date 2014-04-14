require 'spec_helper'

describe ImeiValidator do
  context "IMEI has valid format" do
    let(:klass) do
      Class.new do
        include ActiveModel::Validations
        attr_accessor :imei, :name
        validates :imei, imei: true
      end
    end

    subject { klass.new }

    it { should ensure_valid_imei_format_of(:imei) }
    it { should_not ensure_valid_imei_format_of(:name) }

    it { should allow_value(356843052637512).for(:imei) }
    it { should allow_value("356843052637512").for(:imei) }
    it { should allow_value("35-684305-2637512").for(:imei) }
    it { should allow_value("35-684305.263.7512").for(:imei) }

    context "value too short" do
      it { should_not allow_value("3568430537512").for(:imei) }
      it { should_not allow_value("3").for(:imei) }
    end

    it "can't be too long" do
      should_not allow_value("35684305263751233").for(:imei)
    end

    context "checksum doesn't match" do
      it { should_not allow_value("356843052637513").for(:imei) }
      it { should_not allow_value("156843052637512").for(:imei) }
    end

    it { should_not allow_value("invalid").for(:imei) }
  end
end
