require 'spec_helper'

describe LatitudeValidator do
  let(:klass) do
    Class.new do
      include ActiveModel::Validations
      attr_accessor :lat
      validates :lat, latitude: true
    end
  end

  subject { klass.new }

  it { is_expected.to allow_value(-90).for(:lat) }
  it { is_expected.to allow_value(90).for(:lat) }
  it { is_expected.to allow_value(0).for(:lat) }
  it { is_expected.to allow_value(9.33).for(:lat) }

  it { is_expected.not_to allow_value(-90.1).for(:lat) }
  it { is_expected.not_to allow_value(90.1).for(:lat) }

  it { is_expected.not_to allow_value(nil).for(:lat) }
  it { is_expected.not_to allow_value('').for(:lat) }
end
