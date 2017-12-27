RSpec.describe FFlags do
  before do
    FFlags.config { |config| config.flags = {} }
    FFlags.reset
  end

  describe '#version' do
    it 'has a version number' do
      expect(FFlags::VERSION).not_to be nil
    end
  end

  describe '#config' do
    it 'sets config values' do
      FFlags.config { |config| config.flags = { test: true } }
      expect(FFlags.flags).to eq('test' => 'true')

      FFlags.set(:test, false)
      expect(FFlags.flags).to eq('test' => 'false')
      FFlags.config { |config| config.flags = { test: true } }

      expect(FFlags.flags).to eq('test' => 'false')
    end
  end

  describe '#flags' do
    it 'sets config values' do
      FFlags.config do |config|
        config.flags = { test: true }
      end

      expect(FFlags.flags).to eq('test' => 'true')
    end
  end

  describe '#enabled?' do
    it 'returns correct boolean' do
      FFlags.set(:test, true)
      expect(FFlags.enabled?('test')).to be true

      FFlags.set(:test, false)
      expect(FFlags.enabled?('test')).to be false
    end
  end

  describe '#set' do
    it 'sets the flag' do
      FFlags.configuration.flags = { test: true }
      expect(FFlags.set('test', false)).to be true
      expect(FFlags.enabled?('test')).to be false
    end
  end

  describe '#get' do
    before { FFlags.config { |config| config.flags = { test: true } } }

    it 'gets the flag' do
      expect(FFlags.get('test')).to eq 'true'
    end
  end

  describe '#toggle_flag' do
    before { FFlags.config { |config| config.flags = { test: true } } }

    it 'toggles the flag' do
      expect(FFlags.toggle('test')).to be true
      expect(FFlags.enabled?('test')).to be false
    end
  end

  describe '#method_missing' do
    before { FFlags.config { |config| config.flags = { test: true } } }

    it { expect { FFlags.toto? }.to raise_exception(NoMethodError) }
    it { expect { FFlags.test }.to raise_exception(NoMethodError) }
    it { expect(FFlags.test?).to be true }
  end

  describe '#respond_to?' do
    before { FFlags.config { |config| config.flags = { test: true } } }
    it { expect(FFlags.respond_to?(:toto)).to be false }
    it { expect(FFlags.respond_to?(:test)).to be false }
    it { expect(FFlags.respond_to?(:test?)).to be true }
  end

  describe '#reset' do
    before { FFlags.config { |config| config.flags = { test: true } } }

    it 'resets the flags to default values' do
      expect(FFlags.flags).to eq('test' => 'true')
      FFlags.toggle(:test)
      expect(FFlags.flags).to eq('test' => 'false')
      FFlags.reset
      expect(FFlags.flags).to eq('test' => 'true')
    end
  end
end
