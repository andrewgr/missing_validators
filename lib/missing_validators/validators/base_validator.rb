# Base class for most validators in the gem.
#
class BaseValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    allow_blank = options.fetch(:allow_blank, false)

    return if allow_blank && value.blank?
    return if valid?(value, options)

    record.errors[attribute] << options.fetch(:message) do
      I18n.t(error_message_key)
    end
  end

  private

  def valid?(_value, _options)
    fail NotImplementedError
  end

  def error_message_key
    key = self.class.name.underscore.gsub('_validator', '')
    "errors.messages.#{key}"
  end
end
