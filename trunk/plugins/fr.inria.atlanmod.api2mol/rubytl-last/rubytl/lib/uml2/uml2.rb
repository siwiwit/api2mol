UML2_MODELS   = File.join(RUBYTL_ROOT, 'uml2', 'models')
UML2_PROFILES = File.join(UML2_MODELS, 'profiles')
RUBYTL_REPOSITORY.merge RMOF::CacheRepository.new(File.join(UML2_MODELS, 'cache'))
 
require 'uml2/format_guesser'
require 'uml2/uml_model'
require 'uml2/parsers/parser_helper'
require 'uml2/parsers/parser_euml_2_1_0'
require 'uml2/parsers/parser_md_12_5'


require 'uml2/impl/base_impl'
#require 'uml2/impl/md_12_5'