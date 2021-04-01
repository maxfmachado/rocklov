Dado("Login com {string} e {string}") do |email, password|
  @email = email

  @login_page.open
  @login_page.with(email, password)

  #checkpoint para garantir que estamos no Dashboard
  expect(@dash_page.on_dash?).to be true
end

Dado("que acesso o formulário de cadastro de anúncios") do
  @dash_page.go_to_equipo_form
end

Dado("que tenho o seguinte equipamento:") do |table|
  @anuncio = table.rows_hash

  MongoDB.new.remove_equipo(@anuncio[:nome], @email)
end

Quando("submeto o cadastro desse item") do
  @equipos_page.create(@anuncio)

  sleep 10
end

Entao("devo ver esse item no meu Dashboard") do
  expect(@dash_page.equipo_list).to have_content @anuncio[:nome]
  expect(@dash_page.equipo_list).to have_content "R$#{@anuncio[:preco]}/dia"
end

# Remover anúncios

Dado("que tenho um anúncio indesejado:") do |table|
  user_id = page.execute_script("return localStorage.getItem('user')")

  thumbnail = File.open(File.join(Dir.pwd, "features/support/fixtures/images", table.rows_hash[:thumb]), "rb")

  @equipo = {
    thumbnail: thumbnail,
    name: table.rows_hash[:nome],
    category: table.rows_hash[:categoria],
    price: table.rows_hash[:preco],

  }

  EquiposService.new.create(@equipo, user_id)

  visit current_path
end

Quando("solicito a exclusão desse item") do
  @dash_page.request_removal(@equipo[:name])

  sleep 1
end

Quando("confirmo a exclusão") do
  @dash_page.confirm_removal("Sim")
end

Quando("não confirmo a exclusão") do
  @dash_page.confirm_removal("Não")
end

Então("não devo ver esse item no meu Dashboard") do
  expect(@dash_page.has_no_equipo?(@equipo[:name])).to be true
end

Então("esse item deve continuar no meu Dashboard") do
  expect(@dash_page.has_no_equipo?(@equipo[:name])).to be false
end
