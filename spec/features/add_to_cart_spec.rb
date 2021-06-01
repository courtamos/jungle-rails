require 'rails_helper'

RSpec.feature "Visitor adds and item to the cart", type: :feature, js: true do
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name: Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario "The cart updates items from 0 to 1" do
    visit root_path
    expect(page).to have_css 'article.product', count: 10
    expect(page).to have_content 'My Cart (0)'

    click_on('Add', match: :first)
    expect(page).to have_content 'My Cart (1)'

    save_screenshot 'cart_updates.png'
  end
end
