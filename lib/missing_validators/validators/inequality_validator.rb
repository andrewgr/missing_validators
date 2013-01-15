class InequalityValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unequal_to_attr = options[:to]

    if unequal_to_attr.present? && value == record.send(unequal_to_attr.to_sym)
      message = options[:message] || I18n.t('errors.messages.inequality', attr: unequal_to_attr)
      record.errors[attribute] << message
    end
  end
end
