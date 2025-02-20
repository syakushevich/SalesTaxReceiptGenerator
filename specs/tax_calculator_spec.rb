# frozen_string_literal: true

require_relative '../tax_calculator'

RSpec.describe TaxCalculator do
  before do
    @calculator = TaxCalculator.new
  end

  describe "#round_tax" do
    it "rounds amounts up to the nearest 0.05" do
      expect(@calculator.round_tax(1.49)).to eq(1.50)
      expect(@calculator.round_tax(1.51)).to eq(1.55)
    end
  end

  describe "#calculate_total_sales_tax" do
    it "calculates total sales tax correctly" do
      items = [
        { quantity: 2, price: 12.49, tax_type: "exempt", is_imported: false },
        { quantity: 1, price: 14.99, tax_type: "basic",  is_imported: false },
        { quantity: 1, price: 0.85,  tax_type: "exempt", is_imported: false }
      ]
      expect(@calculator.calculate_total_sales_tax(items)).to eq(1.50)
    end
  end

  describe "#calculate_final_item_price" do
    it "calculates final price for an item correctly" do
      item = { quantity: 1, price: 14.99, tax_type: "basic", is_imported: false }
      expect(@calculator.calculate_final_item_price(item)).to eq(16.49)
    end
  end
end
