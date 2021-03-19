require_relative '../src/main'

RSpec.describe CheckOut do
  RULES = [
    Rule.new('A', RuleStrategies::TierStrategy.new(1 => 50, 3 => 130)),
    Rule.new('B', RuleStrategies::TierStrategy.new(1 => 30, 2 => 45)),
    Rule.new('C', RuleStrategies::SimpleStrategy.new(20)),
    Rule.new('D', RuleStrategies::SimpleStrategy.new(15))
  ]

  def price(goods)
    checkout = CheckOut.new(RULES)
    goods.split(//).each { |item| checkout.scan(item) }
    checkout.total
  end

  def expects_total_items_sum(items, total)
    expect(price(items)).to be_eql(total)
  end

  def expects_total_adding_item(checkout, item, total)
    checkout.scan(item)
    expect(checkout.total).to be_eql(total)
  end

  describe '#total' do
    context 'with all items in a row' do
      it { expects_total_items_sum('A', 50) }
      it { expects_total_items_sum('AB', 80) }
      it { expects_total_items_sum('CDBA', 115) }

      it { expects_total_items_sum('AA', 100) }
      it { expects_total_items_sum('AAA', 130) }
      it { expects_total_items_sum('AAAA', 180) }
      it { expects_total_items_sum('AAAAA', 230) }
      it { expects_total_items_sum('AAAAAA', 260) }

      it { expects_total_items_sum('AAAB', 160) }
      it { expects_total_items_sum('AAABB', 175) }
      it { expects_total_items_sum('AAABBD', 190) }
      it { expects_total_items_sum('DABABA', 190) }
    end

    context 'when scanning items one by one' do
      it 'considers each value added' do
        checkout = CheckOut.new(RULES)

        expect(checkout.total).to be_eql(0)
        expects_total_adding_item(checkout, 'A', 50)
        expects_total_adding_item(checkout, 'B', 80)
        expects_total_adding_item(checkout, 'A', 130)
        expects_total_adding_item(checkout, 'A', 160)
        expects_total_adding_item(checkout, 'B', 175)
      end
    end
  end
end
