#!/usr/bin/env ruby
# vim:set fileencoding=utf-8 filetype=ruby
# $KCODE = 'u'

require 'rubygems'
$:.unshift(File.expand_path("../lib", File.dirname(__FILE__)))

module SpecHelper
  def sample_data(name)
    File.expand_path("../samples/data/" + name, File.dirname(__FILE__))
  end
end

