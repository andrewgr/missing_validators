class EinValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors.add(attribute, :invalid) unless valid_ein?(value)
  end

  private

  def valid_ein?(value)
    (value =~ /(\A\d{2}-\d{7}\Z)/).present?
  end
end
