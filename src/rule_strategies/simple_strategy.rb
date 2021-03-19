module RuleStrategies
  class SimpleStrategy
    attr_reader :price

    def initialize(price)
      @price = price
    end

    def calculate(quantity, _source=nil)
      quantity * price
    end
  end
end
