require "FFlags/version"
require "FFlags/configuration"
require "FFlags/api"

module FFlags
  extend self

  def config
    yield configuration
  end

  def flags
    api.flags
  end

  def enabled?(flag_name)
    api.enabled?(flag_name)
  end

  def set_flag(flag_name, bool)
    api.set_flag(flag_name, bool)
  end

  def get_flag(flag_name)
    api.get_flag(flag_name)
  end

  def toggle_flag(flag_name)
    api.toggle_flag(flag_name)
  end

  def reset
    api.reset
  end

  def api
    @api ||= Api.new
  end

  def configuration
    @configuration ||= Configuration.new
  end
end
