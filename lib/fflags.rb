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

  def method_missing(method_name, *args)
    flag_name = method_name[0..-2]

    if !method_name.to_s.end_with?('?') ||
       !flags.include?(flag_name)
      return super
    end

    api.get_flag(flag_name)
  end

  def respond_to_missing?(method_name, include_private = false)
    flag_name = method_name[0..-2]
    method_name.to_s.end_with?('?') && flags.include?(flag_name) || super
  end

  def api
    @api ||= Api.new
  end

  def configuration
    @configuration ||= Configuration.new
  end
end
