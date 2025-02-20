# frozen_string_literal: true

require_relative '../output_generator'
require_relative '../tax_calculator'

RSpec.describe OutputGenerator do
  before do
    @tax_calculator = TaxCalculator.new
    @output_generator = OutputGenerator.new(@tax_calculator)
  end

  describe "#generate_receipt" do
    it "generates receipt text correctly" do
      items = [
        { quantity: 2, price: 12.49, tax_type: "exempt", is_imported: false, product_name: "book" },
        { quantity: 1, price: 14.99, tax_type: "basic",  is_imported: false, product_name: "music CD" },
        { quantity: 1, price: 0.85,  tax_type: "exempt", is_imported: false, product_name: "chocolate bar" }
      ]
      expected_output = <<~RECEIPT.chomp
        2 book: 24.98
        1 music CD: 16.49
        1 chocolate bar: 0.85
        Sales Taxes: 1.50
        Total: 42.32
      RECEIPT

      receipt = @output_generator.generate_receipt(items)
      expect(receipt).to eq(expected_output)
    end
  end

  describe "#print_receipt" do
    it "prints the receipt to stdout" do
      receipt_text = "Sample Receipt"
      expect { @output_generator.print_receipt(receipt_text) }
        .to output("Sample Receipt\n").to_stdout
    end
  end
end
