# app/graphql/mutations/login.rb
module Mutations
  class Login < BaseMutation
    argument :email, String, required: true
    argument :password, String, required: true

    field :access_token, String, null: true
    field :refresh_token, String, null: true
    field :errors, [String], null: false

    def resolve(email:, password:)
      user = User.find_by(email: email)

      if user&.valid_password?(password)
        access_token = JwtService.encode(user_id: user.id)

        refresh_token = user.refresh_tokens.create!(
          token: SecureRandom.hex(32)
        )

        {
          access_token: access_token,
          refresh_token: refresh_token.token,
          errors: []
        }
      else
        {
          access_token: nil,
          refresh_token: nil,
          errors: ["Invalid credentials"]
        }
      end
    end
  end
end