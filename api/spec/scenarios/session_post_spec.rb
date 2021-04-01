describe "POST /sessions" do
  context "login com sucesso" do
    before(:all) do
      payload = { email: "max@hotmail.com", password: "mudar123" }
      @result = Sessions.new.login(payload)
    end

    it "valida status code" do
      expect(@result.code).to eql 200
    end

    it "valida id do usuário" do
      expect(@result.parsed_response["_id"].length).to eql 24
    end
  end

  # examples = [
  #   {
  #     title: "senha incorreta",
  #     payload: { email: "max@gmail.com", password: "mudar12q3" },
  #     code: 401,
  #     error: "Unauthorized",
  #   },

  #   {
  #     title: "usuario nao existe",
  #     payload: { email: "404@gmail.com", password: "mudar123" },
  #     code: 401,
  #     error: "Unauthorized",
  #   },

  #   {
  #     title: "email em branco",
  #     payload: { email: "", password: "mudar123" },
  #     code: 412,
  #     error: "required email",
  #   },

  #   {
  #     title: "sem o campo email",
  #     payload: { password: "mudar123" },
  #     code: 412,
  #     error: "required email",
  #   },

  #   {
  #     title: "sem em branco",
  #     payload: { email: "max@gmail.com", password: "" },
  #     code: 412,
  #     error: "required password",
  #   },

  #   {
  #     title: "sem o campo senha",
  #     payload: { email: "max@gmail.com" },
  #     code: 412,
  #     error: "required password",
  #   },
  # ]

  examples = Helpers::get_fixture("login")

  examples.each do |e|
    context "#{e[:title]}" do
      before(:all) do
        @result = Sessions.new.login(e[:payload])
      end

      it "valida status code #{e[:code]}" do
        expect(@result.code).to eql e[:code]
      end

      it "valida id do usuário" do
        expect(@result.parsed_response["error"]).to eql e[:error]
      end
    end
  end
end
