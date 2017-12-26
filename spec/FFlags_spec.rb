RSpec.describe FFlags do
  before { FFlags.reset }

  describe '#version' do
    it "has a version number" do
      expect(FFlags::VERSION).not_to be nil
    end
  end

  describe '#config' do
    it 'sets config values' do
      FFlags.config do |config|
        config.flags = { test: true }
      end

      expect(FFlags.configuration.flags).to eq({ test: true })
    end
  end

  describe '#flags' do
    it 'sets config values' do
      FFlags.config do |config|
        config.flags = { test: true }
      end

      expect(FFlags.flags).to eq({ test: true })
    end
  end

  describe '#enabled?' do
    it 'returns correct boolean' do
      FFlags.configuration.flags = { test: true }
      expect(FFlags.enabled?('test')).to be true

      FFlags.configuration.flags = { test: false }
      expect(FFlags.enabled?('test')).to be false
    end
  end

  describe '#set_flag' do
    it 'sets the flag' do
      FFlags.configuration.flags = { test: true }
      expect(FFlags.set_flag('test', false)).to be true
      expect(FFlags.get_flag('test')).to be false
    end
  end

  describe '#get_flag' do
    it 'gets the flag' do
      FFlags.configuration.flags = { test: true }
      expect(FFlags.get_flag('test')).to be true
    end
  end

  describe '#toggle_flag' do
    it 'toggles the flag' do
      FFlags.configuration.flags = { test: true }
      expect(FFlags.toggle_flag('test')).to be true
      expect(FFlags.get_flag('test')).to be false
    end
  end
end
