# Base class for most validators in the gem.
#
class BaseValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    allow_blank = options[:allow_blank] || false
    return if allow_blank && value.blank?

    unless self.class.valid?(value, options)
      key = self.class.name.underscore.split('_').reverse.drop(1).reverse.join('_')
      record.errors[attribute] << (options[:message] || I18n.t("errors.messages.#{key}"))
    end
  end

  private

  def self.valid?(color, options)
    raise NotImplementedError
  end
end
