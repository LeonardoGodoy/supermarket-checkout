require_relative '../../src/main'

RSpec.describe RuleStrategies::SimpleStrategy do
  describe '#calculate' do
    it 'multiplies the unit price by quantity' do
      unit_price = 100
      strategy = described_class.new(unit_price)

      expect(strategy.calculate(10)).to be_eql(1000)
      expect(strategy.calculate(1)).to be_eql(100)
    end
  end
end
