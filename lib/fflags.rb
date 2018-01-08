require 'redis'
require 'fflags/version'
require 'fflags/configuration'
require 'fflags/redis_client'
require 'fflags/api'

# FFlags module
module FFlags
  module_function

  # Sets FFlags configuration using a block that
  # will be invoked on initialization.
  #
  # Ex.
  #   FFlags.config do |config|
  #     config.flags = { flag_1: true, flag_2: false }
  #   end
  def config
    yield configuration
    api.load_flags
  end

  # Reset the whole config to the default values
  #
  # Ex.
  #   FFlags.reset_config
  def reset_config
    @configuration = nil
    reset
  end

  # Returns all supported flags.
  #
  # Ex.
  #    FFlags.all
  def all
    api.flags
  end

  # Returns all templates.
  #
  # Ex.
  #    FFlags.templates
  def templates
    configuration.templates
  end

  # Sets as given template.
  # It will returns false if the template doesn't exists
  #
  # Ex.
  #    FFlags.set_as_template(:template_name)
  def set_as_template(template)
    template = templates[template.to_sym] || templates[template.to_s]

    return false unless template

    status = true
    template.each_pair do |key, value|
      status &&= set(key, value)
    end

    status
  end

  # Check if the flag is enabled,
  # it returns true | false.
  #
  # Ex.
  #    FFlags.enabled?(:new_flag)
  def enabled?(flag_name)
    api.enabled?(flag_name)
  end

  # Sets flag.
  #
  # Ex.
  #   FFlags.set(:new_flag, true)
  #
  #   (Not thread safe)
  #   FFlags.set(:new_flag, true) do
  #     puts 'hello'
  #   end
  def set(flag_name, bool)
    if block_given?
      prev_flag = get(flag_name)
      api.set_flag(flag_name, bool)
      yield
      api.set_flag(flag_name, prev_flag)
    else
      api.set_flag(flag_name, bool)
    end
  end

  # Gets value (as String) of a given flag.
  #
  # Ex.
  #   FFlags.get(:new_flag)
  def get(flag_name)
    api.get_flag(flag_name)
  end

  # Toggle the given flag.
  # If its true, then the flag would be set to false.
  # If its false, then the flag would be set to true.
  #
  # Ex.
  #   FFlags.toggle(:new_flag)
  def toggle(flag_name)
    api.toggle_flag(flag_name)
  end

  # Reset all the flags to the default value.
  # The default values are as defined in the config under flags attribute.
  #
  # Ex.
  #   FFlags.reset
  def reset
    api.reset
  end

  def method_missing(method_name, *args)
    flag_name = method_name[0..-2]

    if !method_name.to_s.end_with?('?') ||
       !all.include?(flag_name)
      return super
    end

    api.enabled?(flag_name)
  end

  def respond_to_missing?(method_name, include_private = false)
    flag_name = method_name[0..-2]
    method_name.to_s.end_with?('?') && all.include?(flag_name) || super
  end

  def api
    @api ||= Api.new
  end

  def configuration
    @configuration ||= Configuration.new
  end
end
