require 'test/unit'
require_relative './base64'

class Base64Test < Test::Unit::TestCase
  def test_encode
    data = load_test_data
    data.each do |elem|
      string, value = elem
      assert_equal value, Base64.encode(string)
    end
  end

  def test_decode
    data = load_test_data
    data.each do |elem|
      value, string = elem
      assert_equal value, Base64.decode(string)
    end
  end

  private

  def load_test_data
    File.open('test_data.txt').readlines.map{ _1.split(/\t/).map(&:strip) }
  end
end