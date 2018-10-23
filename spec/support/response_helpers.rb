module Response
  module JsonHelpers
    def json_response
      @json_response ||= JSON.parse(response.body, symbolize_names: false)
    end
  end
end
