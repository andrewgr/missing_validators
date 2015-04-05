require 'spec_helper'

describe ImeiValidator do
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

  context 'value is valid' do
    it { should allow_value(356_843_052_637_512).for(:imei) }
    it { should allow_value('356843052637512').for(:imei) }
    it { should allow_value('35-684305-2637512').for(:imei) }
    it { should allow_value('35-684305.263.7512').for(:imei) }
  end

  context 'value too short' do
    it { should_not allow_value('3568430537512').for(:imei) }
    it { should_not allow_value('3').for(:imei) }
  end

  context 'value is too long' do
    it { should_not allow_value('35684305263751233').for(:imei) }
  end

  context 'luhn checksum does not match' do
    it { should_not allow_value('356843052637513').for(:imei) }
    it { should_not allow_value('156843052637512').for(:imei) }
  end
end
