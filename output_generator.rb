# frozen_string_literal: true

class OutputGenerator
  def initialize(tax_calculator)
    @tax_calculator = tax_calculator
  end

  def generate_receipt(items)
    total_sales_tax = @tax_calculator.calculate_total_sales_tax(items)
    total_price = items.sum do |item|
      tax_rate = 0
      tax_rate += @tax_calculator.tax_rates[:basic] if item[:tax_type] == "basic"
      tax_rate += @tax_calculator.tax_rates[:imported] if item[:is_imported]
      unit_tax = @tax_calculator.round_tax(item[:price] * tax_rate)
      unit_price_with_tax = item[:price] + unit_tax
      unit_price_with_tax * item[:quantity]
    end

    receipt_lines = items.map do |item|
      tax_rate = 0
      tax_rate += @tax_calculator.tax_rates[:basic] if item[:tax_type] == "basic"
      tax_rate += @tax_calculator.tax_rates[:imported] if item[:is_imported]
      unit_tax = @tax_calculator.round_tax(item[:price] * tax_rate)
      unit_price_with_tax = item[:price] + unit_tax
      line_total = unit_price_with_tax * item[:quantity]
      "#{item[:quantity]} #{item[:product_name]}: #{'%.2f' % line_total}"
    end

    receipt_lines << "Sales Taxes: #{'%.2f' % total_sales_tax}"
    receipt_lines << "Total: #{'%.2f' % total_price}"
    receipt_lines.join("\n")
  end

  def print_receipt(receipt_text)
    puts receipt_text
  end
end
