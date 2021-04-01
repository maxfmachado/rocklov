describe "POST /signup" do
  context "novo usuario" do
    before(:all) do
      payload = { name: "Pitty", email: "pitty@bol.com", password: "mudar123" }
      MongoDB.new.remove_user(payload[:email])

      @result = Signup.new.create(payload)
    end

    it "valida status code" do
      expect(@result.code).to eql 200
    end

    it "valida id do usuário" do
      expect(@result.parsed_response["_id"].length).to eql 24
    end
  end

  context "usuario ja existe" do
    before(:all) do
      # dado que eu tenho um novo usuário
      payload = { name: "Joao da Silva", email: "joao@bol.com", password: "mudar123" }
      MongoDB.new.remove_user(payload[:email])

      # e o email desse usuário já foi cadastrado no sistema
      Signup.new.create(payload)

      # quando faço uma requisição para rota /signup
      @result = Signup.new.create(payload)
    end

    it "deve retornar 409" do
      # entao deve retornar 409
      expect(@result.code).to eql 409
    end

    it "deve retornar mensagem" do
      expect(@result.parsed_response["error"]).to eql "Email already exists :("
    end
  end

  # name é obrigatório
  # email é obrigatório
  # password é obrigatório

  examples = Helpers::get_fixture("signup")

  examples.each do |e|
    context "#{e[:title]}" do
      before(:all) do
        MongoDB.new.remove_user(e[:email])
        @result = Signup.new.create(e[:payload])
      end

      it "valida status code #{e[:code]}" do
        expect(@result.code).to eql e[:code]
      end

      it "deve retornar mensagem de erro" do
        expect(@result.parsed_response["error"]).to eql e[:error]
      end
    end
  end
end
