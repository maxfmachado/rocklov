require "capybara"
require "capybara/cucumber"
require "faker"
require "allure-cucumber"

CONFIG = YAML.load_file(File.join(Dir.pwd, "features/support/config/#{ENV["CONFIG"]}"))

case ENV["BROWSER"]
when "firefox"
  @driver = :selenium
when "fire_headless"
  @driver = :selenium_headless
when "chrome"
  Capybara.register_driver :chrome do |app|
    options = Selenium::WebDriver::Chrome::Options.new
    options.add_argument("headless")
    options.add_argument("--no-sandbox")
    options.add_argument("--disable-dev-shm-usage")
    Capybara::Selenium::Driver.new(app, browser: :chrome, options: options)
  end

  @driver = :selenium_chrome
when "chrome_headless"
  Capybara.register_driver :selenium_chrome_headless do |app|
    version = Capybara::Selenium::Driver.load_selenium
    options_key = Capybara::Selenium::Driver::CAPS_VERSION.satisfied_by?(version) ? :capabilities : :options
    browser_options = ::Selenium::WebDriver::Chrome::Options.new.tap do |opts|
      opts.add_argument("--headless")
      opts.add_argument("--disable-gpu")
      opts.add_argument("--disable-site-isolation-trials")
      opts.add_argument("--no-sandbox")
      opts.add_argument("--disable-dev-shm-usage")
    end
    Capybara::Selenium::Driver.new(app, **{ :browser => :chrome, options_key => browser_options })
  end

  @driver = :selenium_chrome_headless
else
  raise "Navegador incorreto"
end

Capybara.configure do |config|
  config.default_driver = @driver
  config.app_host = CONFIG["url"]
  config.default_max_wait_time = 10 #sec
end

AllureCucumber.configure do |config|
  config.results_directory = "/logs"
  config.clean_results_directory = true
end
