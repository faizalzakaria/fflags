module FFlags
  class Core
    class << self
      def set_flag(flag_name, bool); end

      def toggle_flag(flag_name)
        set_flag(flag_Name, !get_flag(flag_name))
      end

      def reset; end
    end
  end
end
