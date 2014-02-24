require 'spec_helper'

describe LongitudeValidator do
  context "Longitude has a valid value" do
    let(:klass) do
      Class.new do
        include ActiveModel::Validations
        attr_accessor :lon
        validates :lon, longitude: true
      end
    end

    subject { klass.new }

    it { should allow_value(-180).for(:lon) }
    it { should allow_value(180).for(:lon) }
    it { should allow_value(0).for(:lon) }
    it { should allow_value(9.33).for(:lon) }

    it { should_not allow_value(-181.1).for(:lon) }
    it { should_not allow_value(181.1).for(:lon) }
  end
end
