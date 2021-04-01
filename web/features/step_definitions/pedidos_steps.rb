Dado("que meu perfil de anunciante é {string} e {string}") do |email, password|
  @email_anunciante = email
  @password_anunciante = password
end

Dado("que tenho o seguinte equipamento cadastrado:") do |table|
  user_id = SessionsService.new.get_user_id(@email_anunciante, @password_anunciante)

  thumbnail = File.open(File.join(Dir.pwd, "features/support/fixtures/images", table.rows_hash[:thumb]), "rb")

  @equipo = {
    thumbnail: thumbnail,
    name: table.rows_hash[:nome],
    category: table.rows_hash[:categoria],
    price: table.rows_hash[:preco],
  }

  MongoDB.new.remove_equipo(@equipo[:name], @email_anunciante)

  result = EquiposService.new.create(@equipo, user_id)
  @equipo_id = result.parsed_response["_id"]
end

Dado("acesso o meu Dashboard") do
  @login_page.open
  @login_page.with(@email_anunciante, @password_anunciante)

  #checkpoint para garantir que estamos no Dashboard
  expect(@dash_page.on_dash?).to be true
end

Quando("{string} e {string} solicita a locação de equipo") do |email_locatario, password_locatario|
  user_id = SessionsService.new.get_user_id(email_locatario, password_locatario)
  EquiposService.new.booking(@equipo_id, user_id)
end

Entao("devo ver a seguinte mensagem:") do |doc_string|
  expect_message = doc_string.gsub("DATA_ATUAL", Time.now.strftime("%d/%m/%Y"))
  expect(@dash_page.order).to have_text expect_message
end

Entao("devo ver os links: {string} e {string} no pedido") do |button_accept, button_reject|
  expect(@dash_page.order_actions(button_accept)).to be true
  expect(@dash_page.order_actions(button_reject)).to be true
end
