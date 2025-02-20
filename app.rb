require_relative 'input_parser'
require_relative 'tax_calculator'
require_relative 'output_generator'

if ARGV.empty?
  puts "Usage: ruby receipt_app.rb <input_id>"
  exit 1
end

input_id = ARGV[0]
begin
  items = InputParser.parse_file(input_id)
  tax_calculator = TaxCalculator.new
  output_generator = OutputGenerator.new(tax_calculator)
  receipt = output_generator.generate_receipt(items)
  output_generator.print_receipt(receipt)
rescue => e
  puts "Error: #{e.message}"
  exit 1
end
