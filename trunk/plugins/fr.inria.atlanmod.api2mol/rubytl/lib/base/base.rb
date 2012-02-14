# Extensions 
require 'base/ext/class.rb'
require 'base/ext/array.rb'
require 'base/ext/string.rb'
require 'base/ext/tuple.rb'
require 'base/ext/lazy_block.rb'
require 'base/ext/enumerable.rb'
require 'base/ext/boolean.rb'
require 'base/ext/uri.rb'

# Exceptions
require 'base/exception_handling'

# Helper mixin-modules
require 'base/helper_loading'
require 'base/ruby_model_loading'

# Tasks and launching
require 'base/tasks/base_task'
require 'base/tasks/build_system'
require 'base/tasks/base_launcher'

# Base repository
require 'base/resources/resource'
require 'base/repository/repository'
require 'base/repository/handlers/model_handler'
require 'base/repository/handlers/object_print'
require 'base/repository/handlers/rumi_rmof2'
require 'base/repository/handlers/handler_rmof2'
require 'base/repository/handlers/rmof_strategies'
require 'base/repository/handlers/rmof_proxy'
require 'base/repository/handlers/rmof_handler'
require 'base/resources/config'

# Visitor
require 'base/visitor/visitor_mixin'
require 'base/visitor/visitor_class'

# Install the ASCII encoder, if not available
require 'rexml/document'
require 'base/ext/ascii_encoding' 
