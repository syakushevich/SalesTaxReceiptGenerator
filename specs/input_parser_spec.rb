# frozen_string_literal: true

require_relative '../input_parser'

RSpec.describe InputParser do
  describe ".parse_line" do
    context "with a valid non-imported product" do
      it "parses correctly" do
        line = "2 book at 12.49"
        result = InputParser.parse_line(line)
        expect(result[:quantity]).to eq(2)
        expect(result[:is_imported]).to eq(false)
        expect(result[:product_name]).to eq("book")
        expect(result[:price]).to eq(12.49)
        expect(result[:tax_type]).to eq("exempt")
      end
    end

    context "with a valid imported product" do
      it "parses correctly" do
        line = "1 imported bottle of perfume at 47.50"
        result = InputParser.parse_line(line)
        expect(result[:quantity]).to eq(1)
        expect(result[:is_imported]).to eq(true)
        expect(result[:product_name]).to eq("imported bottle of perfume")
        expect(result[:price]).to eq(47.50)
        expect(result[:tax_type]).to eq("basic")
      end
    end

    context "with an invalid input format" do
      it "raises an error" do
        expect { InputParser.parse_line("invalid input") }
          .to raise_error("Invalid input format: invalid input")
      end
    end
  end

  describe ".parse_file" do
    before do
      @filename = "test_input.txt"
      @content = <<~EOF
        2 book at 12.49
        1 music CD at 14.99
        1 imported bottle of perfume at 47.50
      EOF
      File.write(@filename, @content)
    end

    after do
      File.delete(@filename) if File.exist?(@filename)
    end

    it "parses multiple lines from a file" do
      results = InputParser.parse_file("test_input")
      expect(results.size).to eq(3)
      expect(results[0][:product_name]).to eq("book")
      expect(results[1][:product_name]).to eq("music CD")
      expect(results[2][:product_name]).to eq("imported bottle of perfume")
    end
  end
end
