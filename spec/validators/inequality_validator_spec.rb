require 'spec_helper'

describe InequalityValidator do
  subject(:model) { klass.new }

  describe do
    let(:klass) do
      Class.new do
        include ActiveModel::Validations
        attr_accessor :attr
        validates :attr, inequality: { to: 'invalid value' }
      end
    end

    it { should allow_value('valid value').for(:attr) }
    it { should_not allow_value('invalid value').for(:attr) }
  end

  describe do
    let(:klass) do
      Class.new do
        include ActiveModel::Validations
        attr_accessor :origin, :destination, :airline
        validates :origin, inequality: { to: ->(o) { o.destination } }
      end
    end

    specify 'both fields have same values' do
      model.origin = model.destination = 'MOW'
      expect(model).to be_invalid
    end

    specify 'fields have different value' do
      model.origin = 'NYC'
      model.destination = 'MOW'
      expect(model).to be_valid
    end

    specify 'first field has value, the second is nil' do
      model.origin = 'NYC'
      model.destination = nil
      expect(model).to be_valid
    end

    specify 'first field is nil, the second has value' do
      model.origin = nil
      model.destination = 'NYC'
      expect(model).to be_valid
    end

    specify 'both fields are nil' do
      model.origin = model.destination = nil
      expect(model).to be_invalid
    end
  end
end
