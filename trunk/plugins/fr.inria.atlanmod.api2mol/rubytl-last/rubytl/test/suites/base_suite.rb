$LOAD_PATH << File.join(File.dirname(__FILE__), '..')

require 'base/exception_handling_test'
require 'base/string_test'
require 'base/config_test'
require 'base/task_test'
require 'base/library_test'
# require 'base/enumerable_test'
# TODO: Create all_slow_suite...

require 'suites/repository_suite'


