# frozen_string_literal: true

# Static Pages - usually for blogs.
class PagesController < ApplicationController
  include HighVoltage::StaticPage
end
