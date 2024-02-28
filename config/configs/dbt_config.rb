# frozen_string_literal: true

class DbtConfig < ApplicationConfig
  attr_config :host, :database_name, :username, :password
end
