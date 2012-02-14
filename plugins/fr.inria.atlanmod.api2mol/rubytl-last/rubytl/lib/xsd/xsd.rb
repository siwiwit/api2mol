XSD_MODELS = File.join(RUBYTL_ROOT, 'xsd', 'models')
RUBYTL_REPOSITORY.merge RMOF::CacheRepository.new(File.join(XSD_MODELS, 'cache'))
RUBYTL_REPOSITORY.load_metamodel('http://gts.inf.um.es/rubytl/xsd')

require 'xsd/xsd_impl'
require 'xsd/xml_parser_wrapper'
require 'xsd/xsd_parser'
require 'xsd/xml_parser'
require 'xsd/rumi_xsd'
require 'xsd/handler_xsd'
require 'xsd/purev/features'
require 'xsd/purev/handler_purev'

RubyTL::Base::Configuration.handler_klasses << RubyTL::XSD::HandlerXSD
RubyTL::Base::Configuration.handler_klasses << RubyTL::PureVariants::HandlerPureVariants
