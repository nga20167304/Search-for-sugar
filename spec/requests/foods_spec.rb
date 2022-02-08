require 'rails_helper'
include Capybara::RSpecMatchers

RSpec.describe "Foods", type: :request do
  it "show search in homepage" do
    get root_path
    expect(response).to have_http_status(200)
    expect(response.body).to have_selector('input#q_name_cont')
  end
end
