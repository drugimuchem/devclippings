require './devclippings'
require 'test/unit'
#require 'rack/test' used by capybara
require 'capybara'
require 'capybara/dsl'

ENV['RACK_ENV'] = 'test'
ENV['DM_SETUP'] = 'test'

class DevclippingsTest < Test::Unit::TestCase
  include Capybara::DSL

  def setup
    Capybara.app = Sinatra::Application.new
    DataMapper.setup(:default,'mysql://devclippings@localhost/devclippings_test')
    Clipping.auto_migrate!
  end

  def test_index_shows_the_heading
    visit '/'
    assert page.has_content?('devclippings')
  end

  def test_creating_clipping
    visit '/'
    assert find('div.wrapper').has_selector?('ul')
    assert find('div.wrapper').has_no_selector?('li')
    find_link('new').click

    fill_in 'sheet[title]'  , :with => 'Clippings Rocks'
    fill_in 'sheet[content]', :with => "{#}First heading \n content"
    find(:xpath, '//input[@type="submit"]').click

    assert find('h1.title').has_content?('Clippings Rocks')
    assert find('h2').has_content?('First heading')
    assert find('div.text').has_content?('content')

    visit '/'
    assert find('div.wrapper').has_selector?('ul')
    assert find('div.wrapper').has_selector?('li')
    click_link('Clippings Rocks')
    click_link('edit')

    fill_in 'sheet[title]'  , :with => 'Awesome Clippings'
    fill_in 'sheet[content]', :with => "{#}First heading \n content\n {##}Subheading"
    find(:xpath, '//input[@type="submit"]').click

    assert find('h1.title').has_content?('Awesome Clippings')
    assert find('h2').has_content?('First heading')
    assert find('div.text').has_content?('content')
    assert find('h3').has_content?('Subheading')

  end

end
