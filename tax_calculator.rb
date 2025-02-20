# frozen_string_literal: true

require_relative 'input_parser'

class TaxCalculator
  attr_reader :tax_rates

  def initialize(tax_rates = { basic: 0.10, imported: 0.05 })
    @tax_rates = tax_rates
  end

  def round_tax(amount)
    ((amount * 20).ceil / 20.0)
  end

  def calculate_total_sales_tax(items)
    total_sales_tax = 0.0
    items.each do |item|
      tax_rate = 0
      tax_rate += tax_rates[:basic] if item[:tax_type] == "basic"
      tax_rate += tax_rates[:imported] if item[:is_imported]
      raw_tax = item[:price] * tax_rate
      rounded_tax = round_tax(raw_tax)
      total_sales_tax += rounded_tax * item[:quantity]
    end
    total_sales_tax.round(2)
  end

  def calculate_final_item_price(item)
    tax_rate = 0
    tax_rate += tax_rates[:basic] if item[:tax_type] == "basic"
    tax_rate += tax_rates[:imported] if item[:is_imported]
    unit_tax = round_tax(item[:price] * tax_rate)
    final_price = (item[:price] + unit_tax) * item[:quantity]
    final_price.round(2)
  end
end
