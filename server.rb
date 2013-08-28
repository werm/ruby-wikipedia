#!ruby -I ../../lib -I lib
require 'nyny'
require 'sinatra'
require 'ostruct'
require 'wikipedia'
require 'wikitext'

module Views
  CACHE = Tilt::Cache.new
  include ::Sinatra::Templates

  def settings
    @settings ||= OpenStruct.new :templates => {}
  end

  def template_cache
    CACHE
  end
end


class App < NYNY::App
  helpers Views

  get '/' do
    @page = Wikipedia.find( 'Reddit' )
    @content = Wikitext::Parser.new.parse(@page.content)
    haml :index
  end
end

App.run!