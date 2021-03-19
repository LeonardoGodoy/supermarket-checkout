module RuleStrategies
  class TierStrategy
    attr_reader :config

    def initialize(config)
      @config = config
    end

    def calculate(quantity, _source=nil)
      amount = 0
      remaining = quantity

      config.keys.sort.reverse_each do |tier|
        cost = config[tier]
        next if remaining.zero?

        groups = remaining / tier
        next if groups.zero?

        remaining = remaining % tier
        amount += groups * cost
      end

      amount
    end
  end
end
