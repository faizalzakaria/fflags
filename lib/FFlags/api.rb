require './lib/fflags/redis_client'

module FFlags
  class Api
    def flags
      FFlags.configuration.flags
    end

    def enabled?(flag_name)
      get_flag(flag_name) == true
    end

    def set_flag(flag_name, bool)
      client.set(key, flag_name, bool)
    end

    def get_flag(flag_name)
      value = client.get(key, flag_name)
      value = flags.dig(flag_name.to_sym) if value.nil?
      truthy?(value)
    end

    def toggle_flag(flag_name)
      set_flag(flag_name, !get_flag(flag_name))
    end

    def reset
      client.reset(FFlags.configuration.key)
    end

    private

    def truthy?(value)
      value == true || value == 'true'
    end

    def key
      FFlags.configuration.key
    end

    def client
      RedisClient
    end
  end
end
