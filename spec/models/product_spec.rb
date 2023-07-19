require 'rails_helper'


=begin
def name_with_status
  case self.status
  when "to_be_discontinued"
    "#{self.name} (売り切り廃盤予定)"
  when 'discontinued'
    "#{self.name} (廃盤予定)"
  else
    self.name
  end
end
=end

RSpec.describe Product, type: :model do
  describe '#name_with_status' do
    let!(:product) { FactoryBot.create(:product) }

    context 'statusがto_be_discontinued(status: 1)の場合' do
      let!(:product) { FactoryBot.create(:product, status: 1) }

      it '(売り切り廃盤予定)という文字が含まれる' do
        expect(product.name_with_status).to include("(売り切り廃盤予定)")
      end
    end

    context 'statusがdiscontinuedの場合' do
      let!(:product) { FactoryBot.create(:product, status: 2) }

      it '(廃盤予定)が含まれる' do
        expect(product.name_with_status).to include("(廃盤予定)")
        expect(product.name_with_status).to eq("#{product.name} (廃盤予定)")
      end
    end

    context 'それ以外の場合' do
      it '(売り切り廃盤予定)という文字が含まれない' do
        expect(product.name_with_status).to eq(product.name)
        expect(product.name_with_status).not_to include("(売り切り廃盤予定)")
      end

      it '(廃盤予定)が含まれない' do
        expect(product.name_with_status).not_to include("(廃盤予定)")
      end
    end
  end
end
