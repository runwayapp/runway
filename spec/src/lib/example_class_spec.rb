# frozen_string_literal: true

require "spec_helper"
require_relative "../../../src/lib/example"

describe ExampleClass do
  context "example" do
    rbt = described_class.new

    it "tests the example class with addition" do
      expect(rbt.simple_addition(1, 2)).to eq(3)
    end

    it "tests the example class with subtraction" do
      expect(rbt.simple_subtraction(3, 1)).to eq(2)
    end

    it "tests a failure if you can't add" do
      expect do
        rbt.simple_addition(1, "two")
      end.to raise_error(TypeError)
    end

    it "tests a failure if you can't subtract" do
      expect do
        rbt.simple_subtraction(1, "two")
      end.to raise_error(TypeError)
    end
  end
end
