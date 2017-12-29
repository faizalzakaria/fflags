module FFlags
  # Api Class
  class Api
    def initialize
      load_flags
    end

    def flags
      client.all(key)
    end

    def enabled?(flag_name)
      truthy?(get_flag(flag_name))
    end

    def set_flag(flag_name, bool)
      supported_flag?(flag_name) &&
        client.set(key, flag_name, bool)
    end

    def get_flag(flag_name)
      client.get(key, flag_name)
    end

    def toggle_flag(flag_name)
      set_flag(flag_name, !get_flag(flag_name))
    end

    def reset
      client.reset(key)
      load_flags
    end

    def load_flags
      default_flags.each do |flag, bool|
        next if flag_is_not_nil?(flag)
        set_flag(flag, bool)
      end
    end

    private

    def supported_flag?(flag_name)
      default_flags.include?(flag_name.to_sym) ||
        default_flags.include?(flag_name.to_s)
    end

    def flag_is_not_nil?(flag_name)
      !get_flag(flag_name).nil?
    end

    def truthy?(value)
      value == true || value == 'true'
    end

    def key
      FFlags.configuration.key
    end

    def client
      RedisClient
    end

    def default_flags
      FFlags.configuration.flags
    end
  end
end
