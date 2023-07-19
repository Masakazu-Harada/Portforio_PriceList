FactoryBot.define do
  factory :product do
    name { "ぷろだくと" } # t.string "", null: false
    code { "abc123" } # t.string "", null: false
    catalog_page_number { 12 } # t.integer "", null: false
    spec { "てすと" } # t.string "", null: false
    is_original { false } # t.boolean "", default: false, null: false
    carton { 23 } # t.integer ""
    is_separate { false } # t.boolean "", default: false
    due_date { "9時半" } # t.string ""
    same_day_shipping { false } # t.boolean "", default: false
    shipping_rate { "1200円" } # t.string ""
    hokkaido_shipping_rate { "3000円" } # t.string ""
    notes {} # t.string ""
    prepayment { 123 } # t.integer ""
  end
end
