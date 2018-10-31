module Request
  module HeaderHelpers
    def get_headers(user)
      payload = { user_id: user.id, exp: 24.years.from_now.to_i }
      token = Authentication::Jwt.encode(payload)

      {
        'Authorization': "Bearer #{token}",
        'Accept': 'application/vnd.api+json'
      }
    end

    def get_headers_without_token
      {
        'Accept': 'application/vnd.api+json'
      }
    end

    def post_headers(user)
      payload = { user_id: user.id, exp: 24.years.from_now.to_i }
      token = Authentication::Jwt.encode(payload)

      {
        'Authorization': "Bearer #{token}",
        'Accept': 'application/vnd.api+json',
        'Content-Type': 'application/vnd.api+json'
      }
    end

    def post_headers_without_token
      {
        'Accept': 'application/vnd.api+json',
        'Content-Type': 'application/vnd.api+json'
      }
    end
  end
end
