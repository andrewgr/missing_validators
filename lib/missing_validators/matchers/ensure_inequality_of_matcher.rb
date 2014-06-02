RSpec::Matchers.define :ensure_inequality_of do |attribute|
  chain :to do |to|
    @to = to
  end

  match do |model|
    raise Exception if @to.nil?

    value = model.send(attribute)
    model.send("#{@to}=", value)
    model.valid?

    if model.errors.has_key?(attribute)
      model.errors[attribute].include?(I18n.t('errors.messages.inequality', attr: @to))
    end
  end

  failure_message do |model|
    I18n.t 'missing_validators.matchers.ensure_inequality_of.failure_message_for_should',
      model: model.class, attr: attribute.inspect
  end

  failure_message_when_negated do |model|
    I18n.t 'missing_validators.matchers.ensure_inequality_of.failure_message_for_should_not',
      model: model.class, attr: attribute.inspect
  end
end
