#!/usr/bin/env rake
require 'bundler/gem_tasks'
require 'cane/rake_task'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new('spec')

task :default => :spec

desc "Run cane to check quality metrics"
Cane::RakeTask.new(:quality) do |cane|
  cane.abc_max = 15
  cane.no_style = true
end
