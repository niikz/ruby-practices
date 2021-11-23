#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'
require_relative './lib/command_line_option'

options = ARGV.getopts('alr')
command = CommandLineOption.new(options)
puts command.run_ls
