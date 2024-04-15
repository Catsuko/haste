RSpec.describe 'Progress' do
  let(:progress) { Haste.progress(to: 10) }

  it 'cannot have a to of zero' do
    expect { Haste.progress(to: 0) }.to raise_error(ArgumentError)
  end

  it 'can have positive tos' do
    [0.2, 1, 50, 99.9999].each do |to|
      expect { Haste.progress(to: to) }.not_to raise_error
    end
  end

  it 'can have negative tos' do
    [-0.2, -1, -50, -99.9999].each do |to|
      expect { Haste.progress(to: to) }.not_to raise_error
    end
  end

  describe '#to_s' do
    it 'prints the progress float' do
      expect(Haste.progress(5, to: 10).to_s).to eq '0.5'
    end
  end

  describe '#inspect' do
    it 'prints the value and to' do
      expect(Haste.progress(5, to: 10).inspect).to eq '<Progress 5/10>'
    end
  end

  describe '#to_f' do
    it 'starts at zero' do
      expect(Haste.progress(to: 100).to_f).to be_zero
    end

    it 'does not go below zero' do
      expect(Haste.progress(-1, to: 10).to_f).to be_zero
    end

    it 'does not go above one' do
      expect(Haste.progress(100, to: 1).to_f).to eq 1.0
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
