#/*******************************************************************************
#* Copyright (c) 2008, 2012
#* All rights reserved. This program and the accompanying materials
#* are made available under the terms of the Eclipse Public License v1.0
#* which accompanies this distribution, and is available at
#* http://www.eclipse.org/legal/epl-v10.html
#*
#* Contributors:
#*    Javier Canovas (javier.canovas@inria.fr) 
#*******************************************************************************/



model_to_model :rubyTLDiscoverer do |t|
  t.rmof_parse_model_with_sax
  t.sources :package   => 'Reflect',
            :metamodel => './bootstrap/reflect.ecore',
            #:model     => './bootstrap/resultReflect.ecore.xmi'  
            :model     => './bootstrap/resultReflect-Swing.ecore.xmi'  
            #:model     => './bootstrap/rubytl/littleModel.ecore.xmi'  
            
  t.sources :package   => 'Configuration',
            :metamodel => './bootstrap/discovererConfiguration.ecore',
            :model     => './bootstrap/discovererConfiguration-Swing.ecore.xmi'  
            #:model     => './bootstrap/discovererConfiguration-JDT.ecore.xmi'  

  t.targets :package   => 'Ecore',
            :metamodel => 'http://www.eclipse.org/emf/2002/Ecore',
            :model     => './bootstrap/rubytl/resultEcore-RubyTL.ecore'  
  
  t.targets :package   => 'Api2mol',
            :metamodel => '../api2mol.abstractSyntax/model/api2mol.ecore',
            :model     => './bootstrap/rubytl/resultApi2mol-RubyTL.ecore'  

  t.transformation './bootstrap/rubytl/rubyTLDiscoverer.rb'
  #t.benchmark :model_loading, :execution, :serialization
end         