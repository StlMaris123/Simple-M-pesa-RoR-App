# frozen_string_literal: true

class ApplicationService
  attr_reader :result

  def self.call(...)
    new(...).call
  end

  def call
    @result = nil
    payload
    self
  end

  def success?
    errors.empty?
  end

  def errors
    @errors ||= ActiveModel::Errors.new(self)
  end

  private

  # :nocov:
  def initialize(*_)
    raise NotImplementedError,
          'Implement `initialize` for classes inheriting from BaseCommand'
  end

  def payload
    raise NotImplementedError,
          'Implement `payload` for classes inheriting from BaseCommand'
  end
  # :nocov:
end
