# frozen_string_literal: true

require 'redcarpet'
require 'rouge'
require 'rouge/plugins/redcarpet'

# Create helpers for rendering markdown using rouge gem.
module RougeHelper
  class HTML < Redcarpet::Render::HTML
    include Rouge::Plugins::Redcarpet
  end
end
