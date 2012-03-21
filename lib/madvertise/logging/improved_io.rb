module Madvertise
  module Logging

    ##
    # ImprovedIO is a subclass of IO with a bunch of methods reimplemented so
    # that subclasses don't have to reimplement every IO method. Unfortunately
    # this is necessary because Ruby does not provide a sane interface to IO
    # like Enumerable for Arrays and Hashes.
    #
    class ImprovedIO < IO

      def flush
        self
      end

      def external_encoding
        nil
      end

      def internal_encoding
        nil
      end

      def set_encoding
        self
      end

      def readbyte
        getbyte.tap do |b|
          raise EOFError unless b
        end
      end

      def readchar
        getc.tap do |c|
          raise EOFError unless c
        end
      end

      def readline
        gets.tap do |s|
          raise EOFError unless s
        end
      end

      def tty?
        false
      end

      def printf(format_string, *arguments)
        write(sprintf(format_string, *arguments))
        return nil
      end

      def print(*arguments)
        arguments = [$_] if arguments.empty?
        write(arguments.join($,))
        return nil
      end

      def putc
      end

      def puts(*arguments)
        return nil if arguments.empty?

        arguments.each_with_index do |a, i|
          if a.is_a?(Array)
            puts(*a)
          elsif a.is_a?(String)
            write(a)
          else
            write(a.to_s)
          end
        end

        return nil
      end

      # provide sane aliases for IO compat
      begin
        alias_method :each_byte, :bytes
        alias_method :each_char, :chars
        alias_method :each_codepoint, :codepoints
        alias_method :each_line, :lines
        alias_method :each, :lines
        alias_method :eof, :eof?
        alias_method :isatty, :tty?
        alias_method :sysread, :read
        alias_method :syswrite, :write
      rescue NameError
        # do nothing, method may not exist in ruby 1.8
      end

      # skip these IO methods
      [
        :advise,
        :autoclose=,
        :autoclose?,
        :binmode,
        :binmode?,
        :close_on_exec=,
        :close_on_exec?,
        :fcntl,
        :fdatasync,
        :fileno,
        :fsync,
        :ioctl,
        :lineno,
        :lineno=,
        :pid,
        :read_nonblock,
        :stat,
        :sysseek,
        :tell,
        :to_i,
        :to_io,
        :write_nonblock,
      ].each do |m|
        begin
          undef_method m
        rescue NameError
          # do nothing, method may not exist in ruby 1.8
        end
      end

      class << self
        # skip these IO methods
        [
          :binread,
          :binwrite,
          :copy_stream,
          :for_fd,
          :foreach,
          :open,
          :pipe,
          :popen,
          :read,
          :readlines,
          :select,
          :sysopen,
          :try_convert,
          :write,
        ].each do |m|
          begin
            undef_method m
          rescue NameError
            # do nothing, method may not exist in ruby 1.8
          end
        end
      end
    end
  end
end
