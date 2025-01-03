module FFlags
  # Configuration Class
  class Configuration
    attr_accessor :key, :debug, :flags, :templates, :redis_options
    attr_accessor :redis_url # Legacy support

    def initialize
      set_default_values
    end

    private

    def set_default_values
      @key       = 'code3.io'
      @redis_options = {url: 'redis://127.0.0.1:6379'}
      @debug     = false
      @flags     = {}
      @templates = {}
    end
  end
end
