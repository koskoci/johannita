module Authentication
  class AuthenticateCommand < BaseCommand
    private

    attr_reader :email, :password

    def initialize(email, password)
      @email = email
      @password = password
    end

    def user
      @user ||= User.find_by(email: email)
    end

    def password_valid?
      user&.authenticate(password)
    end

    def payload
      if password_valid?
        @result = Jwt.encode(contents)
      else
        errors.add(:base, I18n.t('authenticate_user_command.invalid_credentials'))
      end
    end

    def contents
      {
        user_id: user.id,
        is_admin: user.admin,
        exp: 24.years.from_now.to_i
      }
    end
  end
end
