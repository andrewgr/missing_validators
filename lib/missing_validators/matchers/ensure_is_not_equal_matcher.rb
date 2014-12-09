RSpec::Matchers.define :ensure_is_not_equal do |attribute|
  chain :to do |to|
    @to = to
  end

  match do |model|
    model.send("#{attribute}=", !@to)
    model.valid?

    # Should not have an error here
    return false if model.errors.has_key?(attribute) && model.errors[attribute].include?(I18n.t('errors.messages.is_not_equal', value: !@to))

    model.send("#{attribute}=", @to)
    model.valid?

    # Should have an error here
    return true if model.errors.has_key?(attribute) && model.errors[attribute].include?(I18n.t('errors.messages.is_not_equal', value: @to))
  end

  failure_message do |model|
    I18n.t 'missing_validators.matchers.ensure_is_not_equal.failure_message_for_should',
      model: model.class, attr: attribute.inspect, value: @to
  end

  failure_message_when_negated do |model|
    I18n.t 'missing_validators.matchers.ensure_is_not_equal.failure_message_for_should_not',
      model: model.class, attr: attribute.inspect, value: @to
  end
end
