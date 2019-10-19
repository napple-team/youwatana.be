redis_config = YAML.safe_load(ERB.new(IO.read(Rails.root.join('config', 'redis.yml'))).result, [], [], true)

Redis::Objects.redis = ConnectionPool.new(size: 5, timeout: 5) {
  Redis.new(url: redis_config.fetch("#{Rails.env}")['url'], driver: :hiredis)
}
