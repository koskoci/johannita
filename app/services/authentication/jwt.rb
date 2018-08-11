module Authentication
  class Jwt
    def self.encode(payload)
      JWT.encode(payload, Rails.application.secrets.secret_key_base, 'HS256')
    end

    def self.decode(token)
      begin
        body, = JWT.decode(
          token, Rails.application.secrets.secret_key_base, true, algorithm: 'HS256'
        )
        HashWithIndifferentAccess.new(body)
      rescue => e
        { error: e.message }
      end
    end
  end
end