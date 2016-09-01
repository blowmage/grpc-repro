require "bundler/setup"

desc "Run the GRPC process reproduction."
task :run, :project do |t, args|
  project = args[:project]
  ENV["GRPC_REPRO_PROJECT"] = project unless project.nil?

  $LOAD_PATH.unshift "lib"

  require "grpc-repro"
end

desc "Start an interactive shell."
task :console do
  require "irb"
  require "irb/completion"

  $LOAD_PATH.unshift "lib"

  require "grpc-repro"

  ARGV.clear
  IRB.start
end
