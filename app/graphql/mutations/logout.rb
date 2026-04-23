# app/graphql/mutations/logout.rb
module Mutations
  class Logout < BaseMutation
    argument :refresh_token, String, required: true

    field :message, String, null: true
    field :errors, [String], null: false

    def resolve(refresh_token:)
      token_record = ::RefreshToken.find_by(token: refresh_token)

      if token_record.nil?
        return {
          message: nil,
          errors: ["Invalid refresh token"]
        }
      end

      user = context[:current_user]
      return error("Unauthorized") unless user && token_record.user == user

      token_record.destroy

      {
        message: "Logged out successfully",
        errors: []
      }
    end
  end
end