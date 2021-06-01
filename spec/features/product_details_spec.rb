require 'rails_helper'

RSpec.feature "Visitor navigates to the product detail page", type: :feature, js: true do
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

  scenario "They see the individual product details" do
    visit root_path
    expect(page).to have_css 'article.product', count: 10
    
    click_link('Details', match: :first)
    expect(page).to have_css 'article.product-detail', count: 1

    save_screenshot 'product_details.png'
  end
end
