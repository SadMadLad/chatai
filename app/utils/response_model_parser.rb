# frozen_string_literal: true

class ResponseModelParser
  def initialize(input_hash, mapper)
    @input_hash = input_hash.with_indifferent_access
    @mapper = mapper.with_indifferent_access
  end

  def parse
    @mapper.transform_values do |fetcher|
      fetcher.is_a?(Array) ? @input_hash.dig(*fetcher) : @input_hash[fetcher]
    end
  end
end
