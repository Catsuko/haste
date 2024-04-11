require_relative 'haste/progress'
require_relative 'haste/formatted'

module Haste
  def self.progress(value=0, limit:)
    Formatted.new(Progress.new(value, limit: limit))
  end
end
