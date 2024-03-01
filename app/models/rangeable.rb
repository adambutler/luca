class Rangeable
  NUMERIC_REGEX = /^(?:\s)*(\d+(?:\.\d+)?)(?:\s)*$/
  RANGE_REGEX = /^(?:\s)*(\d+)(?:\s)*(-|to|\.{2,3})(?:\s)*(\d+)(?:\s)*$/
  LIMIT_REGEX = /^(?:\s)*\@(?:\s)*(\d+)(?:\s)*$/

  def initialize(value)
    @raw_value = value
  end

  def value
    case @raw_value
    when "", nil then nil
    when Range, Integer, Float then @raw_value
    when String then parse_value_as_string
    else
      raise ArgumentError, "Invalid value: #{@raw_value.inspect}"
    end
  end

  def database_value
    case type
    when nil then nil
    when "range" then value
    when "target" then value..value
    when "limit"
      int = value.delete("@").to_i
      int..int
    else
      raise ArgumentError, "Invalid type: #{type}"
    end
  end

  def type
    case @raw_value
    when "", nil then nil
    when Range then "range"
    when Integer, Float then "target"
    when String then parse_type_as_string
    else
      raise ArgumentError, "Invalid value: #{@raw_value.inspect}"
    end
  end

  def parse_value_as_string
    case @raw_value
    when NUMERIC_REGEX
      $LAST_MATCH_INFO[1].to_f.prettify
    when RANGE_REGEX
      from = $LAST_MATCH_INFO[1].to_i
      range_operator = $LAST_MATCH_INFO[2]
      to = range_operator === "..." ? $LAST_MATCH_INFO[3].to_i - 1 : $LAST_MATCH_INFO[3].to_i
      from..to
    when LIMIT_REGEX
      int = $LAST_MATCH_INFO[1]
      "@#{int}"
    else
      raise ArgumentError, "Invalid value: #{@raw_value.inspect}"
    end
  end

  def parse_type_as_string
    case @raw_value
    when NUMERIC_REGEX then "target"
    when RANGE_REGEX then "range"
    when LIMIT_REGEX  then "limit"
    else
      raise ArgumentError, "Invalid value: #{@raw_value.inspect}"
    end
  end
end
