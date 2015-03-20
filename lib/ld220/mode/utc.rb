# encoding: utf-8

class LD220
  class Mode
    module UTC
      ENHANCED_PREAMBLE = "\x1b\x75"

      def clear
        write "\x1f"
      end

      def reset
        standard_mode
        move_cursor_to 0
        clear
      end

      def cursor(enabled)
        write enabled ? "\x13" : "\x14"
      end

      def move_cursor_to(pos)
        raise ArgumentError, "Position must be between 0 and 39" unless (0..39).include? pos
        write "\x10#{pos.chr}"
      end

      def scroll_msg(msg)
        msg = msg.to_s
        # Messages longer than 45 chars are accepted, but truncated
        raise ArgumentError, "Message must be 45 or fewer characters" if msg.length > 45
        enhanced_cmd { write "#{ENHANCED_PREAMBLE}\x44#{msg}\x0d" }
      end

      def scroll_once(msg)
        enhanced_cmd { write "#{ENHANCED_PREAMBLE}\x46#{msg}\x0d" }
      end

      def stop_scroll
        # There is no documented way to stop an infinite scroll.
        # However, using "scroll once" with an empty value gets us close
        scroll_once ''
        reset
      end

      def show_time(time = Time.now)
        enhanced_cmd { write "#{ENHANCED_PREAMBLE}\x45#{time.strftime "%H:%M"}\x0d" }
      end

      def display_line(line, msg)
        line_code =case line
        when :top then "\x41"
        when :bottom then "\x42"
        when :both then "\x49"
        end

        if [:top, :bottom].include? line
          raise ArgumentError, "Message too long! Max 20 chars" if msg.length > 20
        end

        if line == :both
          raise ArgumentError, "Message too long! Max 40 chars" if msg.length > 40
        end

        enhanced_cmd { write "#{ENHANCED_PREAMBLE}#{line_code}#{msg}\x0d" }
      end

      def enhanced_cmd
        enhanced_mode
        yield
        standard_mode
      end

      def enhanced_mode
        write "\x1b\x64"
      end

      def standard_mode
        write "\x1b\x0f\x0d"
      end
    end
  end
end
