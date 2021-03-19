module RuleStrategies
  class TierStrategy
    attr_reader :price_tiers

    def initialize(price_tiers)
      @price_tiers = price_tiers
    end

    def calculate(quantity, _source=nil)
      amount = 0
      remaining = quantity

      price_tiers.keys.sort.reverse_each do |tier|
        cost = price_tiers[tier]
        next if remaining.zero?

        tier_repetitions = remaining / tier
        next if tier_repetitions.zero?

        remaining = remaining % tier
        amount += tier_repetitions * cost
      end

      amount
    end
  end
end
