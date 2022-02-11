Capybara.register_driver :selenium_chrome_headless do |app|
  options = ::Selenium::WebDriver::Chrome::Options.new
  options.add_argument('--headless') 
  options.add_argument('--no-sandbox') #chroot isolated environment(Sandbox)Disables operation in
  options.add_argument('--disable-dev-shm-usage') #The location of the shared memory file/dev/from shm/Move to tmp
  options.add_argument('--disable-gpu')
  options.add_argument('--window-size=2500,2500')
  Capybara::Selenium::Driver.new(app, browser: :chrome, options: options)
end

Capybara.javascript_driver = :selenium_chrome_headless
