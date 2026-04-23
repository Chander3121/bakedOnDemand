# query{
#   me{
#     id
#     email
#   }
# }

# mutation{
#   login(input: {email: "test@example.com", password: "password123"}){
#     accessToken
#     refreshToken
#   }
# }

# mutation {
#   logout(input: {refreshToken: "0f77979e77bc99fdaf7f54f04508539270768263a07f067583cf82954e1f331d"}) {
#     message
#     errors
#   }
# }