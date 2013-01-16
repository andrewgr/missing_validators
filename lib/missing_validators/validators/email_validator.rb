class EmailValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
      message = options[:message] || I18n.t('errors.messages.email')
      record.errors[attribute] << message
    end
  end
end