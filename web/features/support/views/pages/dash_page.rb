class DashPage
  include Capybara::DSL

  def go_to_equipo_form
    click_button "Criar anúncio"
  end

  def equipo_list
    return find(".equipo-list")
  end

  def order
    return find(".notifications p")
  end

  def order_actions(name)
    return page.has_css?(".notifications button", text: name)
  end

  def has_no_equipo?(equipo_name)
    return page.has_no_css?(".equipo-list li", text: equipo_name)
  end

  def on_dash?
    page.has_css?(".dashboard")
  end

  def request_removal(equipo_name)
    equipo = find(".equipo-list li", text: equipo_name)
    equipo.find(".delete-icon").click
  end

  def confirm_removal(option)
    click_on option #"Sim" ou "Não"
  end
end
