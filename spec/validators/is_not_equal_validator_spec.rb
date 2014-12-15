require 'spec_helper'

describe IsNotEqualValidator do

  describe do
    let(:klass) do
      Class.new do
        include ActiveModel::Validations
        attr_accessor :attr
        validates :attr, is_not_equal: { to: 1234 }
      end
    end

    subject(:model){ klass.new }

    specify "field is not the same as the result of the validating proc" do
      model.attr = "invalid value"
      expect(model).to be_valid
    end

    specify "field is the same as the result of the validating proc" do
      model.attr = 1234
      expect(model).to be_invalid
    end
  end

  describe do
    let(:klass) do
      Class.new do
        include ActiveModel::Validations
        attr_accessor :origin, :destination
        validates :origin, is_not_equal: { to: 54321 }
        validates :destination, is_not_equal: { to: '12345' }
      end
    end

    subject(:model){ klass.new }

    it { should ensure_is_not_equal(:origin).to(54321) }
    it { should_not ensure_is_not_equal(:origin).to(12345) }
    it { should_not ensure_is_not_equal(:origin).to(nil) }
    it { should_not ensure_is_not_equal(:origin).to([]) }
    it { should_not ensure_is_not_equal(:origin).to('54321') }

    it { should ensure_is_not_equal(:destination).to('12345') }
    it { should_not ensure_is_not_equal(:destination).to('54321') }
    it { should_not ensure_is_not_equal(:destination).to(nil) }
    it { should_not ensure_is_not_equal(:destination).to([]) }
    it { should_not ensure_is_not_equal(:destination).to(12345) }

    specify "invalid value" do
      model.origin = 54321
      model.destination = '12345'
      expect(model).to be_invalid
    end

    specify "fields are nil" do
      model.origin = nil
      model.destination = nil
      expect(model).to be_valid
    end

    specify "incorrect values" do
      model.origin = 12345
      model.destination = 12345
      expect(model).to be_valid
    end


    specify "half match with nil" do
      model.origin = 54321
      model.destination = nil
      expect(model).to be_invalid
    end


    specify "half match with other value" do
      model.origin = 'asdfg'
      model.destination = '12345'
      expect(model).to be_invalid
    end

  end

  describe do
    let(:klass) do
      Class.new do
        include ActiveModel::Validations
        attr_accessor :origin, :destination
        validates :origin, is_not_equal: { to: true }
        validates :destination, is_not_equal: { to: false }
      end
    end

    subject(:model){ klass.new }

    it { should ensure_is_not_equal(:origin).to(true) }
    it { should_not ensure_is_not_equal(:origin).to(false) }
    it { should_not ensure_is_not_equal(:origin).to(nil) }
    it { should_not ensure_is_not_equal(:origin).to([]) }
    it { should_not ensure_is_not_equal(:origin).to('54321') }

    it { should ensure_is_not_equal(:destination).to(false) }
    it { should_not ensure_is_not_equal(:destination).to(true) }
    it { should_not ensure_is_not_equal(:destination).to(nil) }
    it { should_not ensure_is_not_equal(:destination).to([]) }
    it { should_not ensure_is_not_equal(:destination).to(12345) }

    specify "invalid value" do
      model.origin = true
      model.destination = false
      expect(model).to be_invalid
    end

    specify "fields are nil" do
      model.origin = nil
      model.destination = nil
      expect(model).to be_valid
    end

    specify "incorrect values" do
      model.origin = 12345
      model.destination = 12345
      expect(model).to be_valid
    end


    specify "half match with nil" do
      model.origin = true
      model.destination = nil
      expect(model).to be_invalid
    end


    specify "half match with other value" do
      model.origin = 'asdfg'
      model.destination = false
      expect(model).to be_invalid
    end

  end
end
