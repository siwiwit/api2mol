BNF_MODELS = File.join(RUBYTL_ROOT, 'bnf', 'models')
RUBYTL_REPOSITORY.merge RMOF::CacheRepository.new(File.join(BNF_MODELS, 'cache'))
RUBYTL_REPOSITORY.load_metamodel('http://gts.inf.um.es/rubytl/bnf')
RUBYTL_REPOSITORY.load_metamodel('http://gts.inf.um.es/rubytl/cst')

require 'bnf/bnf_dsl'
require 'bnf/lexer'
require 'bnf/parser_functions'
require 'bnf/grammar_ext'
require 'bnf/grammar_visitor'
require 'bnf/parser_generator'
require 'bnf/tasks/parse_task'
require 'bnf/tasks/launcher'