RSpec::Matchers.define :ensure_valid_url_format_of do |attribute|
  match do |model|
    model.send("#{attribute}=", ".")
    model.valid?

    if model.errors.has_key?(attribute)
      model.errors[attribute].include?(I18n.t('errors.messages.url'))
    end
  end

  failure_message do |model|
    I18n.t 'missing_validators.matchers.ensure_valid_url_format_of.failure_message_for_should',
      model: model.class
  end

  failure_message_when_negated do |model|
    I18n.t 'missing_validators.matchers.ensure_valid_url_format_of.failure_message_for_should_not',
      model: model.class
  end
end
