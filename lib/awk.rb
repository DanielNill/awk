require "awk/version"

module Awk
  class Awk
    def initialize
      @pairs = []
    end

    def pattern(&block)
      pair = { pattern: nil, action: nil }
      pair[:pattern] = if block_given?
                         yield
                       else
                         true
                       end
      @pairs << pair

      self
    end

    def action(&block)
      if @pairs.last[:pattern].present? && @pairs.last[:action].blank?
        @pairs.last[:action] = yield
      else
        @pairs << { pattern: true, action: yield }
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
end
