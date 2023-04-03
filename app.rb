# frozen_string_literal: true

require 'sinatra'

class Application < Sinatra::Base
  get '/' do
    'Hello World!'
  end
end
