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

  it { should allow_value(-90).for(:lat) }
  it { should allow_value(90).for(:lat) }
  it { should allow_value(0).for(:lat) }
  it { should allow_value(9.33).for(:lat) }

  it { should_not allow_value(-90.1).for(:lat) }
  it { should_not allow_value(90.1).for(:lat) }

  it { should_not allow_value(nil).for(:lat) }
  it { should_not allow_value('').for(:lat) }
end
