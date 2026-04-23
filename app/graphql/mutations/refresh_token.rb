# app/graphql/mutations/refresh_token.rb
module Mutations
  class RefreshToken < BaseMutation
    argument :refresh_token, String, required: true

    field :access_token, String, null: true
    field :refresh_token, String, null: true
    field :errors, [String], null: false

    def resolve(refresh_token:)
      token_record = ::RefreshToken.find_by(token: refresh_token)

      if token_record.nil?
        return error_response("Invalid refresh token")
      end

      if token_record.expired?
        token_record.destroy
        return error_response("Refresh token expired")
      end

      user = token_record.user
      token_record.destroy

      new_refresh = user.refresh_tokens.create!(
        token: SecureRandom.hex(32)
      )

      access_token = JwtService.encode(user_id: user.id)

      {
        access_token: access_token,
        refresh_token: new_refresh.token,
        errors: []
      }
    end

    private

    def error_response(message)
      {
        access_token: nil,
        errors: [message]
      }
    end
  end
end