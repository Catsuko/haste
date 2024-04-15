RSpec.describe 'Formatted' do
  describe 'label' do
    let(:content) { 'Hello!' }
    let(:labelled) { Haste.label(content).progress(to: 100) }

    it 'prints the content' do
      expect(labelled.to_s).to eq content
    end
  end

  describe 'percent' do
    let(:percent) { Haste.percent.progress(to: 100) }

    it 'prints the progress as a percentage' do
      expect(percent.increase(50).to_s).to eq '50%'
    end

    it 'does not print decimals by default' do
      expect(percent.increase(99.99).to_s).to eq '99%'
    end
  end

  describe 'bar' do
    let(:bar) { Haste.bar.progress(to: 100) }

    it 'prints an empty bar when there is no progress' do
      expect(bar.to_s).to eq '|                                                  |'
    end

    it 'prints a full bar when there is progress' do
      expect(bar.increase(100).to_s).not_to include ' '
    end
  end

  describe 'composing multiple views' do
    it 'prints each view together' do
      label_with_percent = Haste.label('Downloading:').percent
      expect(label_with_percent.progress(to: 100).to_s).to eq 'Downloading: 0%'
    end

    it 'prints them in call order' do
      percent_to_label = Haste.percent.label('-> Downloading...')
      expect(percent_to_label.progress(to: 100).to_s).to eq '0% -> Downloading...'
    end

    it 'can print the same view more than once' do
      multiple_labels = Haste.label('A').label('B').label('C')
      expect(multiple_labels.progress(to: 100).to_s).to eq 'A B C'
    end
  end
end
