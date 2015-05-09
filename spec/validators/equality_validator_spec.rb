require 'spec_helper'

describe EqualityValidator do
  subject(:model) { klass.new }

  describe do
    let(:klass) do
      Class.new do
        include ActiveModel::Validations
        attr_accessor :origin, :destination, :airline
        validates :origin, equality: { to: 'MOW' }
      end
    end

    it { is_expected.to allow_value('MOW').for(:origin) }
    it { is_expected.not_to allow_value('NYC').for(:origin) }
  end

  describe do
    let(:klass) do
      Class.new do
        include ActiveModel::Validations
        attr_accessor :origin, :destination, :airline
        validates :origin, equality: { to: ->(o) { o.destination } }
      end
    end

    specify 'both fields have same values' do
      model.origin = model.destination = 'MOW'
      expect(model).to be_valid
    end

    specify 'fields have different value' do
      model.origin = 'NYC'
      model.destination = 'MOW'
      expect(model).to be_invalid
    end

    specify 'first field has value, the second is nil' do
      model.origin = 'NYC'
      model.destination = nil
      expect(model).to be_invalid
    end

    specify 'first field is nil, the second has value' do
      model.origin = nil
      model.destination = 'NYC'
      expect(model).to be_invalid
    end

    specify 'both fields are nil' do
      model.origin = model.destination = nil
      expect(model).to be_valid
    end
  end
end
