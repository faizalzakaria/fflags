module FFlags
  # Configuration Class
  class Configuration
    attr_accessor :key, :redis_url, :debug, :flags

    def initialize
      set_default_values
    end

    private

    def set_default_values
      @key       = 'code3.io'
      @redis_url = 'redis://127.0.0.1:6379'
      @debug     = false
      @flags     = {}
    end
  end
end
