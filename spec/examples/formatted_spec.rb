RSpec.describe 'Formatted' do
  describe 'label' do
    let(:content) { 'Hello!' }
    let(:labelled) { Haste.progress(limit: 100).label(content) }

    it 'prints the content' do
      expect(labelled.to_s).to eq content
    end
  end

  describe 'percent' do
    let(:percent) { Haste.progress(limit: 100).percent }

    it 'prints the progress as a percentage' do
      expect(percent.increase(50).to_s).to eq '50%'
    end

    it 'does not print decimals by default' do
      expect(percent.increase(99.99).to_s).to eq '99%'
    end
  end

  describe 'bar' do
    let(:bar) { Haste.progress(limit: 100).bar }

    it 'prints an empty bar when there is no progress' do
      expect(bar.to_s).to eq '|                                                  |'
    end

    it 'prints a full bar when there is progress' do
      expect(bar.increase(100).to_s).not_to include ' '
    end
  end

  describe 'composing multiple views' do
    let(:progress) { Haste.progress(limit: 100) }

    it 'prints each view together' do
      expect(progress.label('Downloading:').percent.to_s).to eq 'Downloading: 0%'
    end

    it 'prints them in call order' do
      expect(progress.percent.label('-> Downloading...').to_s).to eq '0% -> Downloading...'
    end

    it 'can print the same view more than once' do
      expect(progress.label('A').label('B').label('C').to_s).to eq 'A B C'
    end
  end
end
