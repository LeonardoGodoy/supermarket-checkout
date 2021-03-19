require_relative '../../src/main'

RSpec.describe RuleStrategies::TierStrategy do
  describe '#calculate' do
    it 'gives preference to higher tiers' do
      config = { 1 => 10, 5 => 40, 10 => 70 }
      strategy = described_class.new(config)

      expect(strategy.calculate(1)).to be_eql(10)
      expect(strategy.calculate(5)).to be_eql(40)
      expect(strategy.calculate(6)).to be_eql(50)
      expect(strategy.calculate(10)).to be_eql(70)
      expect(strategy.calculate(16)).to be_eql(120)
    end
  end
end
