# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    # TODO: remove me
    field :test_field, String, null: false,
      description: "An example field added by the generator"
    def test_field
      "Hello World"
    end

    # developer mutations starts here
    field :login, mutation: Mutations::Login
    field :refresh_token, mutation: Mutations::RefreshToken
  end
end
