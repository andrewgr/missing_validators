class ZipCodeValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors.add(attribute, :invalid) unless valid_zip_code?(value)
  end

  private

  def valid_zip_code?(zip_code)
    (zip_code =~ /(\A\d{5}\Z)|(\A\d{5}-\d{4}\Z)/).present?
  end
end
