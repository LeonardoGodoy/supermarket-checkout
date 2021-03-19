class Rule
  attr_reader :item, :pricing_strategy

  def initialize(item, pricing_strategy)
    @item = item
    @pricing_strategy = pricing_strategy
  end

  def price(quantity)
    pricing_strategy.calculate(quantity, self)
  end
end
