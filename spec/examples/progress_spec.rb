RSpec.describe 'Progress' do
  let(:progress) { Haste.build(goal: 10) }

  it 'cannot have a to of zero' do
    expect { Haste.build(goal: 0) }.to raise_error(ArgumentError)
  end

  it 'can have positive tos' do
    [0.2, 1, 50, 99.9999].each do |to|
      expect { Haste.build(goal: to) }.not_to raise_error
    end
  end

  it 'can have negative tos' do
    [-0.2, -1, -50, -99.9999].each do |to|
      expect { Haste.build(goal: to) }.not_to raise_error
    end
  end

  describe '#to_s' do
    it 'prints the progress float' do
      expect(Haste.build(goal: 10).increase(5).to_s).to eq '0.5'
    end
  end

  describe '#inspect' do
    it 'prints the value and to' do
      expect(Haste.build(goal: 10).increase(5).inspect).to eq '<Progress 5/10>'
    end
  end

  describe '#to_f' do
    it 'starts at zero' do
      expect(Haste.build(goal: 100).to_f).to be_zero
    end

    it 'does not go below zero' do
      expect(Haste.build(goal: 10).update(-1).to_f).to be_zero
    end

    it 'does not go above one' do
      expect(Haste.build(goal: 1).update(100).to_f).to eq 1.0
    end
  end

  describe '#update' do
    it 'sets the progress to the given value' do
      expect(progress.update(5).update(5).to_f).to eq 0.5
    end

    it 'allows methods to be chained' do
      expect(progress.update(5).inspect).to eq '<Progress 5/10>'
    end
  end

  describe '#increase' do
    it 'increases the progress by the provided amount' do
      expect(progress.increase(1).increase(1).to_f).to eq 0.2
    end
  end
end
