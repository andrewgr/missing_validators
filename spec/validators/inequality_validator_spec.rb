require 'spec_helper'

describe InequalityValidator do
  let(:klass) do
    Class.new do
      include ActiveModel::Validations
      attr_accessor :origin, :destination, :airline
      validates :origin, inequality: { to: :destination }
    end
  end

  context do
    subject(:model){ klass.new }

    it { should ensure_inequality_of(:origin).to(:destination) }
    it { should_not ensure_inequality_of(:origin).to(:airline) }

    specify "both fields have same values" do
      model.origin = model.destination = "MOW"
      expect(model).to be_invalid
    end

    specify "fields have different value" do
      model.origin = "NYC"
      model.destination = "MOW"
      expect(model).to be_valid
    end

    specify "first field has value, the second is nil" do
      model.origin = "NYC"
      model.destination = nil
      expect(model).to be_valid
    end

    specify "first field is nil, the second has value" do
      model.origin = nil
      model.destination = "NYC"
      expect(model).to be_valid
    end

    specify "both fields are nil" do
      model.origin = model.destination = nil
      expect(model).to be_invalid
    end

    specify "both fields are now" do
      now = DateTime.now
      model.origin = model.destination = now
      expect(model).to be_invalid
    end
  end
end
