require 'spec_helper'

describe InequalityValidator do
  class FlightBase
    include ActiveModel::Validations
    attr_accessor :origin, :destination, :airline
  end
=begin
  context "" do
    class Flight1 < FlightBase
      validates :origin, inequality: { to: :non_existing_attribute }
    end

    let(:flight){ Flight1.new }

    specify { flight.should ensure_inequality_of(:origin).to(:non_existing_attribute) }

    specify "fields have different values" do
      flight.origin = "MOW"
      flight.destination = "NYC"
      expect(-> {flight.valid?}).to raise_error(NoMethodError)
    end
  end
=end
  context "" do
    class Flight < FlightBase
      validates :origin, inequality: { to: :destination }
    end

    let(:flight){ Flight.new }

    specify { flight.should ensure_inequality_of(:origin).to(:destination) }
    specify { flight.should_not ensure_inequality_of(:origin).to(:airline) }

    specify "both fields have same values" do
      flight.origin = "MOW"
      flight.destination = "MOW"
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
      flight.origin = nil
      flight.destination = nil
      expect(flight).to be_invalid
    end
  end
end

