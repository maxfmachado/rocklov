class DashPage
  include Capybara::DSL

  def go_to_equipo_form
    click_button "Criar anúncio"
  end

  def equipo_list
    return find(".equipo-list")
  end

  def on_dash?
    page.has_css?(".dashboard")
  end
end
