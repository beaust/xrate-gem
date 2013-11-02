#!/usr/bin/env rake

require "rubygems"
require "bundler/setup"
require 'rspec/core/rake_task'

task default: [:spec]

task :spec do
  desc "Run all specs with rcov"
  RSpec::Core::RakeTask.new(:spec) do |t|
    t.pattern = "spec/**/*_spec.rb"
  end
end

task :console do
  puts "Loading development console..."
  system("irb -r ./lib/form_shui")
end
