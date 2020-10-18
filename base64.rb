class Base64
  BASE64_TABLE = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/".split('')
  CHUNK_LENGTH = 6

  class << self
    def encode(string)
      byte_string = string.bytes.map { "%08d" % _1.to_s(2) }.join
      three_byte_chunks = byte_string.scan(/.{1,24}/)
      three_byte_chunks.map do |chunk|
        base64_value = chunk.scan(/.{1,6}/).map do |elem|
          length = elem.size
          if length == CHUNK_LENGTH
            BASE64_TABLE[elem.to_i(2)]
          else
            difference = (CHUNK_LENGTH - length)
            padded_elem = elem << ('0' * difference)
            BASE64_TABLE[padded_elem.to_i(2)] << ('=' * (difference / 2))
          end
        end.join
      end.join
    end

    def decode(string)
      byte_string = string.split('').map do |character|
        if character != '='
          "%06d" % BASE64_TABLE.index(character).to_s(2)
        else
          '00'
        end
      end.join
      three_byte_chunks = byte_string.scan(/.{1,8}/)
      three_byte_chunks.map { _1.to_i(2) }.pack('C*').strip
    end
  end
end