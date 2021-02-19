class EquiposPage
  include Capybara::DSL

  def create(equipo)
    page.has_css?("equipoForm") # checkpoint com timeout explicito

    upload(equipo[:thumb]) if equipo[:thumb].length > 0

    # find("#thumbnail input[type=file]", visible: false).set thumb

    find("input[placeholder$=equipamento]").set equipo[:nome]
    select_category(equipo[:categoria]) if equipo[:categoria].length > 0
    find("input[placeholder*='cobrado']").set equipo[:preco]

    click_button "Cadastrar"
  end

  def select_category(category)
    find("#category").find("option", text: category).select_option
  end

  def upload(file_name)
    thumb = Dir.pwd + "/features/support/fixtures/images/" + file_name

    find("#thumbnail input[type=file]", visible: false).set thumb
  end
end
