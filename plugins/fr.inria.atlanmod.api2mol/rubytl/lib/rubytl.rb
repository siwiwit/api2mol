RUBYTL_VERSION = '0.3.2'
$LOAD_PATH << File.dirname(__FILE__)
require 'base/platform'
require 'mri_platform' 
Platform.impl = MRIPlatform.new
Platform.require_rake

require 'base/base'
Platform.require_model_libraries
Platform.require_components

if $0 == __FILE__ 
  rakefile = ARGV[0] || 'Rakefile'
  raketask = ARGV[1] || 'default'
  basedir  = ARGV[2] || Dir.pwd
  # This is a horrible hack, I'm not proud of it :-(
  if raketask == "ant_task"
    basedir = basedir.sub(/cmd$/, "")
  end 
  config = RubyTL::Base::Configuration.basic(basedir) 
  result = RubyTL::Base::RakeBuildSystem.new(config).launch(rakefile, raketask)
  exit(-1) if not result
end

