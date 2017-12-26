module FFlags
  # Redis Client
  class RedisClient
    class << self
      def set(key, field, value)
        client.hmset(key, field, value) == 'OK'
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
        @client ||= Redis.new(url: FFlags.configuration.redis_url)
      end
    end
  end
end
