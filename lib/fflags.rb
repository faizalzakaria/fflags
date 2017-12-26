require 'redis'
require 'fflags/version'
require 'fflags/configuration'
require 'fflags/redis_client'
require 'fflags/api'

# FFlags module
module FFlags
  module_function

  def config
    yield configuration
    api.reset
  end

  def flags
    api.flags
  end

  def enabled?(flag_name)
    api.enabled?(flag_name)
  end

  def set(flag_name, bool)
    api.set_flag(flag_name, bool)
  end

  def get(flag_name)
    api.get_flag(flag_name)
  end

  def toggle(flag_name)
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
