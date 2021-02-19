require "httparty"

describe "POST /sessions" do
  it "login com sucesso" do
    payload = { email: "max@gmail.com", password: "mudar123" }

    result = HTTParty.post(
      "http://rocklov-api:3333/sessions",
      body: payload.to_json,
      headers: {
        "Content-Type": "application/json",
      },
    )

    expect(result.code).to eql 200
    expect(result.parsed_response["_id"].length).to eql 24
  end
end
