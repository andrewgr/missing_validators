# Base class for most validators in the gem.
#
class BaseValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    allow_blank = options.fetch(:allow_blank, false)

    return if allow_blank && value.blank?

    unless valid?(value, options)
      record.errors[attribute] << options.fetch(:message) do
        I18n.t(error_message_key)
      end
    end
  end

  private

  def valid?(color, options)
    raise NotImplementedError
  end

  def error_message_key
    key = self.class.name.underscore.gsub('_validator', '')
    "errors.messages.#{key}"
  end
end
