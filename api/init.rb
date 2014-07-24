# encoding: utf-8

root_directory = File.expand_path(File.dirname(__FILE__)) # change this if you move this file
Dir.chdir root_directory

# ==========================================================
# Sets global ruby runtime settings, e.g. standard encoding
# ==========================================================

# Default to utf-8 for all I/O.
Encoding.default_external = "UTF-8"


# ===============================
# Global constants and variables
# ===============================

# =======================================================
# Requires (almost) everything (also configures Mongoid)
# =======================================================

require 'bundler/setup'
# require_relative 'helpers'
require 'mongoid'
require 'json'
require 'pp'
require_relative 'helpers'
require_from_directory 'models'

ENVIRONMENT = 'production'
Mongoid.load!('mongoid.yml', ENVIRONMENT)