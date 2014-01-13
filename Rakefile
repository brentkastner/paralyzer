require 'rake'
require 'rspec/core/rake_task'
require 'rake/clean'

DIR_TMP = "#{Rake.application.original_dir}/tmp"
CLEAN.include(Rake::FileList[DIR_TMP])

RSpec::Core::RakeTask.new(:spec) do
  #paralyzer stalker app :) comment or uncomment the line below to open the
  #Finger Eleven Paralyzer video whilst running specs and examining code coverage
  #`open "http://a255.co/sb"`
  #`open #{DIR_TMP}/coverage/index.html`
end

task :default => [:clean, :spec]

