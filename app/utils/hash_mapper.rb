# frozen_string_literal: true

# Digs deep into the response and fetches the results. Use case can be understood
# in weather report job for example.
class HashMapper
  def initialize(input_hash, mapper)
    @input_hash = input_hash.with_indifferent_access
    @mapper = mapper.with_indifferent_access
  end

  def parse
    @mapper.transform_values! do |key_map|
      if key_map.is_a?(Array)
        @input_hash.dig(*key_map)
      else
        @input_hash[key_map]
      end
    end

    @mapper
  end
end
