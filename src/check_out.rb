class CheckOut
  attr_reader :rules, :items_set

  def initialize(rules)
    @rules = rules
    @items_set = {}
  end

  def scan(item)
    previous_counter = items_set[item] || 0
    items_set[item] = previous_counter + 1
  end

  def total
    calculate_total
  end

  private

  def calculate_total
    rules.sum do |rule|
      quantity = items_set[rule.item] || 0
      rule.price(quantity)
    end
  end
end
