module Authentication
  class Base
    class NotImplementedError < StandardError; end

    attr_reader :result

    def self.call(*args)
      new(*args).call
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

    def initialize(*_)
      raise NotImplementedError
    end

    def payload
      raise NotImplementedError
    end
  end
end