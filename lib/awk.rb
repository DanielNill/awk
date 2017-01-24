require "awk/version"

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
      if @pairs.last[:pattern].present? && @pairs.last[:action].blank?
        @pairs.last[:action] = yield @data
      else
        @pairs << { pattern: true, action: yield(@data) }
      end

      self
    end

    def perform
      @pairs.each do |pair|
        puts pair
        # implement later
      end
    end
  end

  class Data
    def initialize(source)
      @source = source
    end
  end
end
