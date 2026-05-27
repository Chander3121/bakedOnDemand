# OPENAI_CLIENT = OpenAI::Client.new(
#   access_token: ENV["OPENAI_API_KEY"]
# )

OPENAI_CLIENT = OpenAI::Client.new(
  access_token: ENV["OPENROUTER_API_KEY"],
  uri_base: "https://openrouter.ai/api/v1",
  extra_headers: {
    "HTTP-Referer" => "http://localhost:3000",
    "X-Title" => "BakesOnDemand"
  }
)
