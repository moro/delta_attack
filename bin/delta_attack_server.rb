#!/usr/bin/env jruby
# vim:set fileencoding=utf-8 filetype=ruby
$KCODE = 'u'

$:.unshift File.expand_path("../lib", File.dirname(__FILE__))
require 'webrick/httpserver'
require 'delta_attack/extractor'
require 'delta_attack/extractor/servlet'

s = WEBrick::HTTPServer.new(:Port=>3333)
s.mount("/extract", DeltaAttack::Extractor::Servlet)
trap("INT"){ s.shutdown }
s.start

