require 'spec_helper'

describe ColorValidator do
  let(:klass) do
    Class.new do
      include ActiveModel::Validations
      attr_accessor :color
      validates :color, color: true
    end
  end

  subject { klass.new }

  it { is_expected.to allow_value('#000000').for(:color) }
  it { is_expected.to allow_value('#ab00FF').for(:color) }

  it { is_expected.not_to allow_value('color').for(:color) }
  it { is_expected.not_to allow_value(0).for(:color) }
end
