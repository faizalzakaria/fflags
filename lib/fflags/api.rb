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

    def flag_exist?(flag_name)
      !get_flag(flag_name).nil?
    end

    def load_flags
      default_flags.each do |flag, bool|
        next if flag_exist?(flag)
        set_flag(flag, bool)
      end
    end

    private

    def question_mark_method?(method_name)
      method_name[-1] == '?'
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
