module Request
  module HeaderHelpers
    def get_headers(user)
      payload = { user_id: user.id, exp: 24.years.from_now.to_i }
      token = Authentication::Jwt.encode(payload)

      {
        'Authentication': "Bearer #{token}",
        'Accept': 'application/json'
      }
    end

    def post_headers(user)
      payload = { user_id: user.id, exp: 24.years.from_now.to_i }
      token = Authentication::Jwt.encode(payload)

      {
        'Authentication': "Bearer #{token}",
        'Accept': 'application/json',
        'Content-Type': 'application/vnd.api+json'
      }
    end
  end
end
