require 'spec_helper'

describe ColorValidator do
  context "Color has a valid value" do
    let(:klass) do
      Class.new do
        include ActiveModel::Validations
        attr_accessor :color
        validates :color, color: true
      end
    end

    subject { klass.new }

    it { should allow_value("#000000").for(:color) }
    it { should allow_value("#ab00FF").for(:color) }

    it { should_not allow_value("kk").for(:color) }
    it { should_not allow_value(0).for(:color) }
  end
end
