require 'spec_helper'

describe LongitudeValidator do
  let(:klass) do
    Class.new do
      include ActiveModel::Validations
      attr_accessor :lon
      validates :lon, longitude: true
    end
  end

  subject { klass.new }

  it { is_expected.to allow_value(-180).for(:lon) }
  it { is_expected.to allow_value(180).for(:lon) }
  it { is_expected.to allow_value(0).for(:lon) }
  it { is_expected.to allow_value(9.33).for(:lon) }

  it { is_expected.not_to allow_value(-181.1).for(:lon) }
  it { is_expected.not_to allow_value(181.1).for(:lon) }

  it { is_expected.not_to allow_value(nil).for(:lon) }
  it { is_expected.not_to allow_value('').for(:lon) }
end
