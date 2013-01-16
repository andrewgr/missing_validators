require 'spec_helper'

describe InequalityValidator do
  class Flight
    include ActiveModel::Validations
    attr_accessor :origin, :destination, :airline
    validates :origin, inequality: { to: :destination }
  end

  context do
    subject(:flight){ Flight.new }

    it { should ensure_inequality_of(:origin).to(:destination) }
    it { should_not ensure_inequality_of(:origin).to(:airline) }

    specify "both fields have same values" do
      flight.origin = flight.destination = "MOW"
      expect(flight).to be_invalid
    end

    specify "fields have different value" do
      flight.origin = "NYC"
      flight.destination = "MOW"
      expect(flight).to be_valid
    end

    specify "first field has value, the second is nil" do
      flight.origin = "NYC"
      flight.destination = nil
      expect(flight).to be_valid
    end

    specify "first field is nil, the second has value" do
      flight.origin = nil
      flight.destination = "NYC"
      expect(flight).to be_valid
    end

    specify "both fields are nil" do
      flight.origin = flight.destination = nil
      expect(flight).to be_invalid
    end
  end
end
