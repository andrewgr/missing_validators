# Base class for most validators in the gem.
#
class BaseValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    allow_blank = options.fetch(:allow_blank, false)

    return if allow_blank && value.blank?

    unless self.class.valid?(value, options)
      record.errors[attribute] << options.fetch(:message) do
        I18n.t(error_message_key)
      end
    end
  end

  private

  def self.valid?(color, options)
    raise NotImplementedError
  end

  def error_message_key
    key = self.class.name.underscore.split('_').reverse.drop(1).reverse.join('_')
    "errors.messages.#{key}"
  end
end
