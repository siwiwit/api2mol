require 'erb'

module ECore

  class APIConfiguration
    attr_writer :generator
  
    attr_accessor :top_module
    attr_accessor :filename
    
    def ruby_module_name(package)
      package.name.to_metamodel_name
    end
    
    def package_to_filename(package)     
      # TODO: Rails convention + checking
      return @filename || (package.name.downcase + '.rb')
    end    
  end

  # This class is in charge of generate code for metamodels based on ECore.
  # It is 
  #
  # The generator can be configured by setting values of an APIConfiguration
  # object. This values can change the way names are generates, or generation
  # strategies.
  #
  class APIGenerator
    attr_reader :configuration
    
    PACKAGE_DEFINITION_TEMPLATE        = 'package_definition.rtemplate'
    CLASS_META_DEFINITION_TEMPLATE     = 'class_metadefinition.rtemplate'
    CLASS_DEFINITION_TEMPLATE          = 'class_definition.rtemplate'
    DATA_TYPE_META_DEFINITION_TEMPLATE = 'datatype_metadefinition.rtemplate'
    ENUMERATION_META_DEFINITION_TEMPLATE = 'enumeration_metadefinition.rtemplate'
    
    # Creates a new 
    #
    def initialize(output_dir, configuration = APIConfiguration.new)
      @template_dir  = File.join(File.dirname(__FILE__), 'templates')
      @output_dir    = output_dir
      @configuration = configuration 
    end

    def generate_metamodel(root_package)      
      helper = PackageHelper.new(self, root_package)
      package_text = apply_template(PACKAGE_DEFINITION_TEMPLATE, helper)

      if @configuration.top_module
        package_text = "module #{@configuration.top_module} " + $/ + package_text + $/ + "end"
      end

      filename = File.join(@output_dir, @configuration.package_to_filename(root_package))
      File.open(filename, "w") do |file|
        file.puts(package_text)
      end
    end
    
    # Generates the Ruby definition of an EClass, META
    #
    def generate_meta_for_class(eclass)
      helper = ClassHelper.new(self, eclass)
      apply_template(CLASS_META_DEFINITION_TEMPLATE, helper)      
    end

    # Generates the Ruby definition of an EClass
    #
    def generate_for_class(eclass)
      helper = ClassHelper.new(self, eclass)
      apply_template(CLASS_DEFINITION_TEMPLATE, helper)      
    end

    # Generates the Ruby definition of an EDataType
    #
    def generate_for_datatype(edatatype)
      helper = DataTypeHelper.new(self, edatatype)
      apply_template(DATA_TYPE_META_DEFINITION_TEMPLATE, helper)      
    end

    # Generates the Ruby definition of an EEnumeration
    #
    def generate_for_enumeration(edatatype)
      helper = EnumHelper.new(self, edatatype)
      apply_template(ENUMERATION_META_DEFINITION_TEMPLATE, helper)      
    end
    
  private  
    
    def apply_template(template_name, helper_object)
      # read template
      text = nil
      File.open(File.join(@template_dir, template_name)) do |f|
        erb = ERB.new(f.read, nil, '-')
        text = erb.result(helper_object.send(:binding))  
      end
      return text
    end
    
    # This class provide access and helper methods to access 
    # package information in the generation.
    class PackageHelper
      attr_reader :package
      
      def initialize(generator, package)
        @package = package
        @generator = generator
      end 

      def package_name(pkg = @package)
        # TODO: Rails convention
        @generator.configuration.ruby_module_name(pkg)
      end
      
      def traverse_classes(&block)
        if @package.respond_to? :eClasses
          @package.eClasses
        else
          @package.eClassifiers.select { |classifier| classifier.kind_of?(ECore::EClass) }
        end.each(&block)
      end

      def traverse_datatypes(&block)
        if @package.respond_to? :eDataTypes
          @package.eDataTypes
        else
          @package.eClassifiers.select { |classifier| classifier.class == ECore::EDataType }
        end.each(&block)
      end

      def traverse_enumerations(&block)
        if @package.respond_to? :eEnumerations
          @package.eEnumerations
        else
          @package.eClassifiers.select { |classifier| classifier.class == ECore::EEnum }
        end.each(&block)
      end
      
      def generate_metadefinition_for_class(eclass)
        @generator.generate_meta_for_class(eclass)
      end

      def generate_definition_for_class(eclass)
        @generator.generate_for_class(eclass)
      end

      def generate_metadefinition_for_datatype(edatatype)
        @generator.generate_for_datatype(edatatype)
      end

      def generate_metadefinition_for_enumeration(eenum)
        @generator.generate_for_enumeration(eenum)
      end

    end
    
    class ClassHelper
      attr_reader :eclass
    
      def initialize(generator, eclass)
        @generator = generator
        @eclass = eclass
      end
      
      # Returns the name of the module that contains the implements
      # the metadefinition of this EClass
      def eclass_metamodule_name
        "Meta" + @eclass.name
      end

      # Returns the name of the Ruby class that represent this metaclass.
      def eclass_name
        @eclass.name.to_class_name
      end

      def eclass_struct_name(an_eclass = self.eclass)
        an_eclass.name + 'Struct'
      end

      # Traverse all atributes belonging to this eclass (i.e. not
      # inherited attributes)
      def traverse_attributes(&block)
        @eclass.eAttributes.each(&block)        
      end

      # Traverse all references belonging to this eclass (i.e. not
      # inherited references)
      def traverse_references(&block)
        @eclass.eReferences.each(&block)        
      end
      
      # Returns the type of an attribute, usually the data type name
      def attr_type(attribute)
        attribute.eType.name
      end
      
      def attribute_definition(attr)
        string = "define_attribute '#{attr.name}', #{attr_type(attr)}"
        optional = structural_feature_options(attr)
        return string + optional
      end
      
      def reference_definition(reference)
        string = "define_reference '#{reference.name}', #{reference.eType.name}"
        optional = structural_feature_options(reference)
        optional += ', :containment => true' if reference.containment
        return string + optional
      end

      def write_reference_opposites
        result = ''
        traverse_references do |reference|
          if reference.eOpposite != nil
            result += ' ' * 6 + reference_opposite(reference) + $/
          end
        end
        result
      end

      def reference_opposite(reference)
        raise "No opposite for #{reference.name}" if reference.eOpposite.nil?
        return "reference_opposite '#{reference.name}', '#{reference.eOpposite.name}'"
      end
      
    private
      def structural_feature_options(feature)
        optional = ""
        optional += ', :derived => true' if feature.derived     
        optional += ', :upperBound => ' + feature.upperBound.to_s if feature.upperBound
        optional
      end
    end

    class DataTypeHelper
      attr_reader :edatatype
    
      def initialize(generator, edatatype)
        @generator = generator
        @edatatype = edatatype
      end
      
      # Returns the name of the module that contains the implements
      # the metadefinition of this EClass
      def datatype_name
        @edatatype.name
      end
      
      def datatype_instanceClassName
        @edatatype.instanceClassName
      end
    end

    class EnumHelper < DataTypeHelper
      def each_literal(&block)
        @edatatype.eLiterals.each(&block)
      end
    end
  end

end