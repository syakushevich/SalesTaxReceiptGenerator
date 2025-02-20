# frozen_string_literal: true

PRODUCTS = {
  "book"                     => "exempt",
  "music CD"                 => "basic",
  "chocolate bar"            => "exempt",
  "box of chocolates"        => "exempt",
  "bottle of perfume"        => "basic",
  "packet of headache pills" => "exempt"
}.freeze

class InputParser
  def self.parse_line(line)
    line = line.strip
    regex = /^(\d+)\s+(.+?)\s+at\s+(\d+(?:\.\d{1,2})?)$/
    match = line.match(regex)
    raise "Invalid input format: #{line}" unless match

    quantity = match[1].to_i
    product_name = match[2].strip
    price = match[3].to_f

    is_imported = product_name.downcase.include?("imported")
    normalized_product_name = product_name.gsub(/imported\s*/i, "").strip
    tax_type = PRODUCTS.find { |name, _| name.downcase == normalized_product_name.downcase }
    tax_type = tax_type ? tax_type[1] : "unknown"

    {
      quantity: quantity,
      is_imported: is_imported,
      product_name: product_name,
      price: price,
      tax_type: tax_type
    }
  end

  def self.parse_file(filename)
    raise "File not found: #{filename}" unless File.exist?(filename)

    parsed_items = []
    File.readlines(filename).each do |line|
      next if line.strip.empty?
      parsed_items << parse_line(line)
    end
    parsed_items
  end
end
