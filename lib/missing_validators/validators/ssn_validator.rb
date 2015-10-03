class SsnValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors.add(attribute, :invalid) if valid_ssn?(value)
  end

  private

  def valid_ssn?(value)
    (value =~ /(\A\d{3}-\d{2}-\d{4}\Z)/).nil?
  end
end
