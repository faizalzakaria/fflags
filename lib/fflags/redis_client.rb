module FFlags
  # Redis Client
  class RedisClient
    # hset doesn't return explicitly true or false
    def set(key, field, value)
      return false if value.nil?

      client.hset(key, field, value.to_s)
    end

    def all(key)
      client.hgetall(key)
    end

    def get(key, field)
      client.hget(key, field)
    end

    def reset(key)
      client.del(key)
    end

    private

    def client
      if FFlags.configuration.redis_url
        # Legacy support
        @client ||= Redis.new(url: FFlags.configuration.redis_url)
      else
        @client ||= Redis.new(FFlags.configuration.redis_options)
      end
    end
  end
end
