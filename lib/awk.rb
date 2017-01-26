require "awk/version"
require "active_support/all"

module Awk
  class Awk
    def initialize(source)
      @pairs = []
      @data = Data.new(source)
    end

    def pattern(&block)
      pair = { pattern: nil, action: nil }
      pair[:pattern] = if block_given?
                         yield @data
                       else
                         true
                       end
      @pairs << pair

      self
    end

    def action(&block)
      if @pairs.last.present? && @pairs.last[:pattern].present? && @pairs.last[:action].blank?
        @pairs.last[:action] = yield @data
      else
        @pairs << { pattern: true, action: yield(@data) }
      end

      self
    end

    def perform
      @pairs.each do |pair|
        puts pair
      end
    end
  end

  class Data
    def initialize(source)
      raise "source must be a string" unless source.is_a?(String)
      @source = source
    end

    def parse
      @parsed_data ||= if Pathname.new(@source).exists?
                         parse_file
                       else
                         parse_string
                       end
    end

    private

    def parse_string
      @source.split(/\s/)
    end
  end
end
