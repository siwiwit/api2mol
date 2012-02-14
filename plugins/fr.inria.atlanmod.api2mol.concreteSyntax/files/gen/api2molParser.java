// $ANTLR 3.2 Sep 23, 2009 12:02:23 api2mol.g 2010-06-24 14:24:27

	import gts.modernization.model.CST.impl.*;
	import gts.modernization.model.CST.*;
	import java.util.Iterator;


import org.antlr.runtime.*;
import java.util.Stack;
import java.util.List;
import java.util.ArrayList;
import java.util.Map;
import java.util.HashMap;
import org.antlr.stringtemplate.*;
import org.antlr.stringtemplate.language.*;
import java.util.HashMap;
public class api2molParser extends Parser {
    public static final String[] tokenNames = new String[] {
        "<invalid>", "<EOR>", "<DOWN>", "<UP>", "AT", "CONTEXT", "COMMA", "SEMI", "DEFAULT_METACLASS", "ID", "LPAREN", "RPAREN", "ENUM", "COLON", "LCURLY", "RCURLY", "DOT", "NEW", "MULTIPLE", "SLASH", "COMMENT", "LINE_COMMENT", "WS"
    };
    public static final int LINE_COMMENT=21;
    public static final int NEW=17;
    public static final int DEFAULT_METACLASS=8;
    public static final int LCURLY=14;
    public static final int ID=9;
    public static final int EOF=-1;
    public static final int SEMI=7;
    public static final int CONTEXT=5;
    public static final int LPAREN=10;
    public static final int MULTIPLE=18;
    public static final int AT=4;
    public static final int COLON=13;
    public static final int RPAREN=11;
    public static final int WS=22;
    public static final int SLASH=19;
    public static final int ENUM=12;
    public static final int COMMA=6;
    public static final int RCURLY=15;
    public static final int COMMENT=20;
    public static final int DOT=16;

    // delegates
    // delegators


        public api2molParser(TokenStream input) {
            this(input, new RecognizerSharedState());
        }
        public api2molParser(TokenStream input, RecognizerSharedState state) {
            super(input, state);
             
        }
        
    protected StringTemplateGroup templateLib =
      new StringTemplateGroup("api2molParserTemplates", AngleBracketTemplateLexer.class);

    public void setTemplateLib(StringTemplateGroup templateLib) {
      this.templateLib = templateLib;
    }
    public StringTemplateGroup getTemplateLib() {
      return templateLib;
    }
    /** allows convenient multi-value initialization:
     *  "new STAttrMap().put(...).put(...)"
     */
    public static class STAttrMap extends HashMap {
      public STAttrMap put(String attrName, Object value) {
        super.put(attrName, value);
        return this;
      }
      public STAttrMap put(String attrName, int value) {
        super.put(attrName, new Integer(value));
        return this;
      }
    }

    public String[] getTokenNames() { return api2molParser.tokenNames; }
    public String getGrammarFileName() { return "api2mol.g"; }


    public static class mainRule_return extends ParserRuleReturnScope {
        public Node returnNode;
        public StringTemplate st;
        public Object getTemplate() { return st; }
        public String toString() { return st==null?null:st.toString(); }
    };

    // $ANTLR start "mainRule"
    // api2mol.g:19:1: mainRule returns [Node returnNode] : (contextSectionGen+= contextSection )? (defaultMetaclassSectionGen+= defaultMetaclassSection )? (mappingGen+= mapping )* ;
    public final api2molParser.mainRule_return mainRule() throws RecognitionException {
        api2molParser.mainRule_return retval = new api2molParser.mainRule_return();
        retval.start = input.LT(1);

        List list_contextSectionGen=null;
        List list_defaultMetaclassSectionGen=null;
        List list_mappingGen=null;
        RuleReturnScope contextSectionGen = null;
        RuleReturnScope defaultMetaclassSectionGen = null;
        RuleReturnScope mappingGen = null;
        try {
            // api2mol.g:20:1: ( (contextSectionGen+= contextSection )? (defaultMetaclassSectionGen+= defaultMetaclassSection )? (mappingGen+= mapping )* )
            // api2mol.g:20:4: (contextSectionGen+= contextSection )? (defaultMetaclassSectionGen+= defaultMetaclassSection )? (mappingGen+= mapping )*
            {
            // api2mol.g:20:21: (contextSectionGen+= contextSection )?
            int alt1=2;
            int LA1_0 = input.LA(1);

            if ( (LA1_0==AT) ) {
                int LA1_1 = input.LA(2);

                if ( (LA1_1==CONTEXT) ) {
                    alt1=1;
                }
            }
            switch (alt1) {
                case 1 :
                    // api2mol.g:0:0: contextSectionGen+= contextSection
                    {
                    pushFollow(FOLLOW_contextSection_in_mainRule51);
                    contextSectionGen=contextSection();

                    state._fsp--;
                    if (state.failed) return retval;
                    if (list_contextSectionGen==null) list_contextSectionGen=new ArrayList();
                    list_contextSectionGen.add(contextSectionGen);


                    }
                    break;

            }

            // api2mol.g:20:66: (defaultMetaclassSectionGen+= defaultMetaclassSection )?
            int alt2=2;
            int LA2_0 = input.LA(1);

            if ( (LA2_0==AT) ) {
                alt2=1;
            }
            switch (alt2) {
                case 1 :
                    // api2mol.g:0:0: defaultMetaclassSectionGen+= defaultMetaclassSection
                    {
                    pushFollow(FOLLOW_defaultMetaclassSection_in_mainRule57);
                    defaultMetaclassSectionGen=defaultMetaclassSection();

                    state._fsp--;
                    if (state.failed) return retval;
                    if (list_defaultMetaclassSectionGen==null) list_defaultMetaclassSectionGen=new ArrayList();
                    list_defaultMetaclassSectionGen.add(defaultMetaclassSectionGen);


                    }
                    break;

            }

            // api2mol.g:20:104: (mappingGen+= mapping )*
            loop3:
            do {
                int alt3=2;
                int LA3_0 = input.LA(1);

                if ( (LA3_0==ID||LA3_0==ENUM) ) {
                    alt3=1;
                }


                switch (alt3) {
            	case 1 :
            	    // api2mol.g:0:0: mappingGen+= mapping
            	    {
            	    pushFollow(FOLLOW_mapping_in_mainRule63);
            	    mappingGen=mapping();

            	    state._fsp--;
            	    if (state.failed) return retval;
            	    if (list_mappingGen==null) list_mappingGen=new ArrayList();
            	    list_mappingGen.add(mappingGen);


            	    }
            	    break;

            	default :
            	    break loop3;
                }
            } while (true);

            if ( state.backtracking==0 ) {

              		// Create return CST Node
              		Node mainRuleReturnNode = CSTFactoryImpl.eINSTANCE.createNode();
              		mainRuleReturnNode.setKind("mainRule");
              	    // Create a CST Node
              		if(list_contextSectionGen != null) {
              	        for(Iterator it = list_contextSectionGen.iterator(); it.hasNext(); )  { 
              	            api2molParser.contextSection_return r = (api2molParser.contextSection_return) it.next(); 
              	            if(r != null && r.returnNode != null) {
              	            	r.returnNode.setKind("contextSection");
              	            	mainRuleReturnNode.getChildren().add(r.returnNode);
              	            } 
              	        }
              	    }
              	    // Create a CST Node
              		if(list_defaultMetaclassSectionGen != null) {
              	        for(Iterator it = list_defaultMetaclassSectionGen.iterator(); it.hasNext(); )  { 
              	            api2molParser.defaultMetaclassSection_return r = (api2molParser.defaultMetaclassSection_return) it.next(); 
              	            if(r != null && r.returnNode != null) {
              	            	r.returnNode.setKind("defaultMetaclassSection");
              	            	mainRuleReturnNode.getChildren().add(r.returnNode);
              	            } 
              	        }
              	    }
              	    // Create a CST Node
              		if(list_mappingGen != null) {
              	        for(Iterator it = list_mappingGen.iterator(); it.hasNext(); )  { 
              	            api2molParser.mapping_return r = (api2molParser.mapping_return) it.next(); 
              	            if(r != null && r.returnNode != null) {
              	            	r.returnNode.setKind("mapping");
              	            	mainRuleReturnNode.getChildren().add(r.returnNode);
              	            } 
              	        }
              	    }
              		// Returns the Node with CST Leaves/Nodes
              		retval.returnNode = mainRuleReturnNode;
              	
            }

            }

            retval.stop = input.LT(-1);

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {
        }
        return retval;
    }
    // $ANTLR end "mainRule"

    public static class contextSection_return extends ParserRuleReturnScope {
        public Node returnNode;
        public StringTemplate st;
        public Object getTemplate() { return st; }
        public String toString() { return st==null?null:st.toString(); }
    };

    // $ANTLR start "contextSection"
    // api2mol.g:60:1: contextSection returns [Node returnNode] : ATGen= AT CONTEXTGen= CONTEXT instanceNameGen+= instanceName (COMMAGen_List+= COMMA instanceNameGen_1+= instanceName )* SEMIGen= SEMI ;
    public final api2molParser.contextSection_return contextSection() throws RecognitionException {
        api2molParser.contextSection_return retval = new api2molParser.contextSection_return();
        retval.start = input.LT(1);

        Token ATGen=null;
        Token CONTEXTGen=null;
        Token SEMIGen=null;
        Token COMMAGen_List=null;
        List list_COMMAGen_List=null;
        List list_instanceNameGen=null;
        List list_instanceNameGen_1=null;
        RuleReturnScope instanceNameGen = null;
        RuleReturnScope instanceNameGen_1 = null;
        try {
            // api2mol.g:61:1: (ATGen= AT CONTEXTGen= CONTEXT instanceNameGen+= instanceName (COMMAGen_List+= COMMA instanceNameGen_1+= instanceName )* SEMIGen= SEMI )
            // api2mol.g:61:4: ATGen= AT CONTEXTGen= CONTEXT instanceNameGen+= instanceName (COMMAGen_List+= COMMA instanceNameGen_1+= instanceName )* SEMIGen= SEMI
            {
            ATGen=(Token)match(input,AT,FOLLOW_AT_in_contextSection87); if (state.failed) return retval;
            CONTEXTGen=(Token)match(input,CONTEXT,FOLLOW_CONTEXT_in_contextSection92); if (state.failed) return retval;
            pushFollow(FOLLOW_instanceName_in_contextSection97);
            instanceNameGen=instanceName();

            state._fsp--;
            if (state.failed) return retval;
            if (list_instanceNameGen==null) list_instanceNameGen=new ArrayList();
            list_instanceNameGen.add(instanceNameGen);

            // api2mol.g:61:64: (COMMAGen_List+= COMMA instanceNameGen_1+= instanceName )*
            loop4:
            do {
                int alt4=2;
                int LA4_0 = input.LA(1);

                if ( (LA4_0==COMMA) ) {
                    alt4=1;
                }


                switch (alt4) {
            	case 1 :
            	    // api2mol.g:61:66: COMMAGen_List+= COMMA instanceNameGen_1+= instanceName
            	    {
            	    COMMAGen_List=(Token)match(input,COMMA,FOLLOW_COMMA_in_contextSection103); if (state.failed) return retval;
            	    if (list_COMMAGen_List==null) list_COMMAGen_List=new ArrayList();
            	    list_COMMAGen_List.add(COMMAGen_List);

            	    pushFollow(FOLLOW_instanceName_in_contextSection108);
            	    instanceNameGen_1=instanceName();

            	    state._fsp--;
            	    if (state.failed) return retval;
            	    if (list_instanceNameGen_1==null) list_instanceNameGen_1=new ArrayList();
            	    list_instanceNameGen_1.add(instanceNameGen_1);


            	    }
            	    break;

            	default :
            	    break loop4;
                }
            } while (true);

            SEMIGen=(Token)match(input,SEMI,FOLLOW_SEMI_in_contextSection115); if (state.failed) return retval;
            if ( state.backtracking==0 ) {

              		// Create return CST Node
              		Node contextSectionReturnNode = CSTFactoryImpl.eINSTANCE.createNode();
              		contextSectionReturnNode.setKind("contextSection");
              	    // Create a CST Leaf
              		if(ATGen != null) {
              			Leaf ATGenLeaf = CSTFactoryImpl.eINSTANCE.createLeaf("AT", (ATGen!=null?ATGen.getText():null), ATGen.getCharPositionInLine(), ATGen.getLine());
              			contextSectionReturnNode.getChildren().add(ATGenLeaf);
              		}
              	    // Create a CST Leaf
              		if(CONTEXTGen != null) {
              			Leaf CONTEXTGenLeaf = CSTFactoryImpl.eINSTANCE.createLeaf("CONTEXT", (CONTEXTGen!=null?CONTEXTGen.getText():null), CONTEXTGen.getCharPositionInLine(), CONTEXTGen.getLine());
              			contextSectionReturnNode.getChildren().add(CONTEXTGenLeaf);
              		}
              	    // Create a CST Node
              		if(list_instanceNameGen != null) {
              	        for(Iterator it = list_instanceNameGen.iterator(); it.hasNext(); )  { 
              	            api2molParser.instanceName_return r = (api2molParser.instanceName_return) it.next(); 
              	            if(r != null && r.returnNode != null) {
              	            	r.returnNode.setKind("instanceName");
              	            	contextSectionReturnNode.getChildren().add(r.returnNode);
              	            } 
              	        }
              	    }

              		// Create a special CST Node for terminal COMMAGen_List aggregation
              		if(list_COMMAGen_List != null) {
              	    for(int pos = 0; pos < list_COMMAGen_List.size(); pos++ )  { 
              		// Terminal extractor
              	    if(list_COMMAGen_List != null) {
              		    Token t = (Token) list_COMMAGen_List.get(pos); 
              		    Leaf COMMAGen_ListLeaf = CSTFactoryImpl.eINSTANCE.createLeaf("COMMA", t.getText(), t.getCharPositionInLine(), t.getLine());
              			contextSectionReturnNode.getChildren().add(COMMAGen_ListLeaf);
              		}
              		// No Terminal extractor
              	    if(list_instanceNameGen_1 != null) {		
              	    	api2molParser.instanceName_return r = (api2molParser.instanceName_return) list_instanceNameGen_1.get(pos); 
              	    	if(r != null && r.returnNode != null) {
              	        	r.returnNode.setKind("instanceName");
              	    		contextSectionReturnNode.getChildren().add(r.returnNode);
              	    	} 
              		}
              		}
              		}

              	    // Create a CST Leaf
              		if(SEMIGen != null) {
              			Leaf SEMIGenLeaf = CSTFactoryImpl.eINSTANCE.createLeaf("SEMI", (SEMIGen!=null?SEMIGen.getText():null), SEMIGen.getCharPositionInLine(), SEMIGen.getLine());
              			contextSectionReturnNode.getChildren().add(SEMIGenLeaf);
              		}
              		// Returns the Node with CST Leaves/Nodes
              		retval.returnNode = contextSectionReturnNode;
              	
            }

            }

            retval.stop = input.LT(-1);

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {
        }
        return retval;
    }
    // $ANTLR end "contextSection"

    public static class defaultMetaclassSection_return extends ParserRuleReturnScope {
        public Node returnNode;
        public StringTemplate st;
        public Object getTemplate() { return st; }
        public String toString() { return st==null?null:st.toString(); }
    };

    // $ANTLR start "defaultMetaclassSection"
    // api2mol.g:117:1: defaultMetaclassSection returns [Node returnNode] : ATGen= AT DEFAULT_METACLASSGen= DEFAULT_METACLASS IDGen= ID LPARENGen= LPAREN IDGen_1= ID RPARENGen= RPAREN SEMIGen= SEMI ;
    public final api2molParser.defaultMetaclassSection_return defaultMetaclassSection() throws RecognitionException {
        api2molParser.defaultMetaclassSection_return retval = new api2molParser.defaultMetaclassSection_return();
        retval.start = input.LT(1);

        Token ATGen=null;
        Token DEFAULT_METACLASSGen=null;
        Token IDGen=null;
        Token LPARENGen=null;
        Token IDGen_1=null;
        Token RPARENGen=null;
        Token SEMIGen=null;

        try {
            // api2mol.g:118:1: (ATGen= AT DEFAULT_METACLASSGen= DEFAULT_METACLASS IDGen= ID LPARENGen= LPAREN IDGen_1= ID RPARENGen= RPAREN SEMIGen= SEMI )
            // api2mol.g:118:4: ATGen= AT DEFAULT_METACLASSGen= DEFAULT_METACLASS IDGen= ID LPARENGen= LPAREN IDGen_1= ID RPARENGen= RPAREN SEMIGen= SEMI
            {
            ATGen=(Token)match(input,AT,FOLLOW_AT_in_defaultMetaclassSection138); if (state.failed) return retval;
            DEFAULT_METACLASSGen=(Token)match(input,DEFAULT_METACLASS,FOLLOW_DEFAULT_METACLASS_in_defaultMetaclassSection143); if (state.failed) return retval;
            IDGen=(Token)match(input,ID,FOLLOW_ID_in_defaultMetaclassSection148); if (state.failed) return retval;
            LPARENGen=(Token)match(input,LPAREN,FOLLOW_LPAREN_in_defaultMetaclassSection153); if (state.failed) return retval;
            IDGen_1=(Token)match(input,ID,FOLLOW_ID_in_defaultMetaclassSection158); if (state.failed) return retval;
            RPARENGen=(Token)match(input,RPAREN,FOLLOW_RPAREN_in_defaultMetaclassSection163); if (state.failed) return retval;
            SEMIGen=(Token)match(input,SEMI,FOLLOW_SEMI_in_defaultMetaclassSection168); if (state.failed) return retval;
            if ( state.backtracking==0 ) {

              		// Create return CST Node
              		Node defaultMetaclassSectionReturnNode = CSTFactoryImpl.eINSTANCE.createNode();
              		defaultMetaclassSectionReturnNode.setKind("defaultMetaclassSection");
              	    // Create a CST Leaf
              		if(ATGen != null) {
              			Leaf ATGenLeaf = CSTFactoryImpl.eINSTANCE.createLeaf("AT", (ATGen!=null?ATGen.getText():null), ATGen.getCharPositionInLine(), ATGen.getLine());
              			defaultMetaclassSectionReturnNode.getChildren().add(ATGenLeaf);
              		}
              	    // Create a CST Leaf
              		if(DEFAULT_METACLASSGen != null) {
              			Leaf DEFAULT_METACLASSGenLeaf = CSTFactoryImpl.eINSTANCE.createLeaf("DEFAULT_METACLASS", (DEFAULT_METACLASSGen!=null?DEFAULT_METACLASSGen.getText():null), DEFAULT_METACLASSGen.getCharPositionInLine(), DEFAULT_METACLASSGen.getLine());
              			defaultMetaclassSectionReturnNode.getChildren().add(DEFAULT_METACLASSGenLeaf);
              		}
              	    // Create a CST Leaf
              		if(IDGen != null) {
              			Leaf IDGenLeaf = CSTFactoryImpl.eINSTANCE.createLeaf("ID", (IDGen!=null?IDGen.getText():null), IDGen.getCharPositionInLine(), IDGen.getLine());
              			defaultMetaclassSectionReturnNode.getChildren().add(IDGenLeaf);
              		}
              	    // Create a CST Leaf
              		if(LPARENGen != null) {
              			Leaf LPARENGenLeaf = CSTFactoryImpl.eINSTANCE.createLeaf("LPAREN", (LPARENGen!=null?LPARENGen.getText():null), LPARENGen.getCharPositionInLine(), LPARENGen.getLine());
              			defaultMetaclassSectionReturnNode.getChildren().add(LPARENGenLeaf);
              		}
              	    // Create a CST Leaf
              		if(IDGen_1 != null) {
              			Leaf IDGen_1Leaf = CSTFactoryImpl.eINSTANCE.createLeaf("ID", (IDGen_1!=null?IDGen_1.getText():null), IDGen_1.getCharPositionInLine(), IDGen_1.getLine());
              			defaultMetaclassSectionReturnNode.getChildren().add(IDGen_1Leaf);
              		}
              	    // Create a CST Leaf
              		if(RPARENGen != null) {
              			Leaf RPARENGenLeaf = CSTFactoryImpl.eINSTANCE.createLeaf("RPAREN", (RPARENGen!=null?RPARENGen.getText():null), RPARENGen.getCharPositionInLine(), RPARENGen.getLine());
              			defaultMetaclassSectionReturnNode.getChildren().add(RPARENGenLeaf);
              		}
              	    // Create a CST Leaf
              		if(SEMIGen != null) {
              			Leaf SEMIGenLeaf = CSTFactoryImpl.eINSTANCE.createLeaf("SEMI", (SEMIGen!=null?SEMIGen.getText():null), SEMIGen.getCharPositionInLine(), SEMIGen.getLine());
              			defaultMetaclassSectionReturnNode.getChildren().add(SEMIGenLeaf);
              		}
              		// Returns the Node with CST Leaves/Nodes
              		retval.returnNode = defaultMetaclassSectionReturnNode;
              	
            }

            }

            retval.stop = input.LT(-1);

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {
        }
        return retval;
    }
    // $ANTLR end "defaultMetaclassSection"

    public static class mapping_return extends ParserRuleReturnScope {
        public Node returnNode;
        public StringTemplate st;
        public Object getTemplate() { return st; }
        public String toString() { return st==null?null:st.toString(); }
    };

    // $ANTLR start "mapping"
    // api2mol.g:163:1: mapping returns [Node returnNode] : (ENUMGen= ENUM )? metaclassNameGen+= metaclassName COLONGen= COLON instanceNameGen+= instanceName LCURLYGen= LCURLY (sectionGen+= section )* RCURLYGen= RCURLY ;
    public final api2molParser.mapping_return mapping() throws RecognitionException {
        api2molParser.mapping_return retval = new api2molParser.mapping_return();
        retval.start = input.LT(1);

        Token ENUMGen=null;
        Token COLONGen=null;
        Token LCURLYGen=null;
        Token RCURLYGen=null;
        List list_metaclassNameGen=null;
        List list_instanceNameGen=null;
        List list_sectionGen=null;
        RuleReturnScope metaclassNameGen = null;
        RuleReturnScope instanceNameGen = null;
        RuleReturnScope sectionGen = null;
        try {
            // api2mol.g:164:1: ( (ENUMGen= ENUM )? metaclassNameGen+= metaclassName COLONGen= COLON instanceNameGen+= instanceName LCURLYGen= LCURLY (sectionGen+= section )* RCURLYGen= RCURLY )
            // api2mol.g:164:3: (ENUMGen= ENUM )? metaclassNameGen+= metaclassName COLONGen= COLON instanceNameGen+= instanceName LCURLYGen= LCURLY (sectionGen+= section )* RCURLYGen= RCURLY
            {
            // api2mol.g:164:3: (ENUMGen= ENUM )?
            int alt5=2;
            int LA5_0 = input.LA(1);

            if ( (LA5_0==ENUM) ) {
                alt5=1;
            }
            switch (alt5) {
                case 1 :
                    // api2mol.g:164:5: ENUMGen= ENUM
                    {
                    ENUMGen=(Token)match(input,ENUM,FOLLOW_ENUM_in_mapping191); if (state.failed) return retval;

                    }
                    break;

            }

            pushFollow(FOLLOW_metaclassName_in_mapping198);
            metaclassNameGen=metaclassName();

            state._fsp--;
            if (state.failed) return retval;
            if (list_metaclassNameGen==null) list_metaclassNameGen=new ArrayList();
            list_metaclassNameGen.add(metaclassNameGen);

            COLONGen=(Token)match(input,COLON,FOLLOW_COLON_in_mapping203); if (state.failed) return retval;
            pushFollow(FOLLOW_instanceName_in_mapping208);
            instanceNameGen=instanceName();

            state._fsp--;
            if (state.failed) return retval;
            if (list_instanceNameGen==null) list_instanceNameGen=new ArrayList();
            list_instanceNameGen.add(instanceNameGen);

            LCURLYGen=(Token)match(input,LCURLY,FOLLOW_LCURLY_in_mapping213); if (state.failed) return retval;
            // api2mol.g:164:129: (sectionGen+= section )*
            loop6:
            do {
                int alt6=2;
                int LA6_0 = input.LA(1);

                if ( (LA6_0==AT||LA6_0==ID) ) {
                    alt6=1;
                }


                switch (alt6) {
            	case 1 :
            	    // api2mol.g:0:0: sectionGen+= section
            	    {
            	    pushFollow(FOLLOW_section_in_mapping218);
            	    sectionGen=section();

            	    state._fsp--;
            	    if (state.failed) return retval;
            	    if (list_sectionGen==null) list_sectionGen=new ArrayList();
            	    list_sectionGen.add(sectionGen);


            	    }
            	    break;

            	default :
            	    break loop6;
                }
            } while (true);

            RCURLYGen=(Token)match(input,RCURLY,FOLLOW_RCURLY_in_mapping224); if (state.failed) return retval;
            if ( state.backtracking==0 ) {

              		// Create return CST Node
              		Node mappingReturnNode = CSTFactoryImpl.eINSTANCE.createNode();
              		mappingReturnNode.setKind("mapping");
              	    // Create a CST Leaf
              		if(ENUMGen != null) {
              			Leaf ENUMGenLeaf = CSTFactoryImpl.eINSTANCE.createLeaf("ENUM", (ENUMGen!=null?ENUMGen.getText():null), ENUMGen.getCharPositionInLine(), ENUMGen.getLine());
              			mappingReturnNode.getChildren().add(ENUMGenLeaf);
              		}
              	    // Create a CST Node
              		if(list_metaclassNameGen != null) {
              	        for(Iterator it = list_metaclassNameGen.iterator(); it.hasNext(); )  { 
              	            api2molParser.metaclassName_return r = (api2molParser.metaclassName_return) it.next(); 
              	            if(r != null && r.returnNode != null) {
              	            	r.returnNode.setKind("metaclassName");
              	            	mappingReturnNode.getChildren().add(r.returnNode);
              	            } 
              	        }
              	    }
              	    // Create a CST Leaf
              		if(COLONGen != null) {
              			Leaf COLONGenLeaf = CSTFactoryImpl.eINSTANCE.createLeaf("COLON", (COLONGen!=null?COLONGen.getText():null), COLONGen.getCharPositionInLine(), COLONGen.getLine());
              			mappingReturnNode.getChildren().add(COLONGenLeaf);
              		}
              	    // Create a CST Node
              		if(list_instanceNameGen != null) {
              	        for(Iterator it = list_instanceNameGen.iterator(); it.hasNext(); )  { 
              	            api2molParser.instanceName_return r = (api2molParser.instanceName_return) it.next(); 
              	            if(r != null && r.returnNode != null) {
              	            	r.returnNode.setKind("instanceName");
              	            	mappingReturnNode.getChildren().add(r.returnNode);
              	            } 
              	        }
              	    }
              	    // Create a CST Leaf
              		if(LCURLYGen != null) {
              			Leaf LCURLYGenLeaf = CSTFactoryImpl.eINSTANCE.createLeaf("LCURLY", (LCURLYGen!=null?LCURLYGen.getText():null), LCURLYGen.getCharPositionInLine(), LCURLYGen.getLine());
              			mappingReturnNode.getChildren().add(LCURLYGenLeaf);
              		}
              	    // Create a CST Node
              		if(list_sectionGen != null) {
              	        for(Iterator it = list_sectionGen.iterator(); it.hasNext(); )  { 
              	            api2molParser.section_return r = (api2molParser.section_return) it.next(); 
              	            if(r != null && r.returnNode != null) {
              	            	r.returnNode.setKind("section");
              	            	mappingReturnNode.getChildren().add(r.returnNode);
              	            } 
              	        }
              	    }
              	    // Create a CST Leaf
              		if(RCURLYGen != null) {
              			Leaf RCURLYGenLeaf = CSTFactoryImpl.eINSTANCE.createLeaf("RCURLY", (RCURLYGen!=null?RCURLYGen.getText():null), RCURLYGen.getCharPositionInLine(), RCURLYGen.getLine());
              			mappingReturnNode.getChildren().add(RCURLYGenLeaf);
              		}
              		// Returns the Node with CST Leaves/Nodes
              		retval.returnNode = mappingReturnNode;
              	
            }

            }

            retval.stop = input.LT(-1);

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {
        }
        return retval;
    }
    // $ANTLR end "mapping"

    public static class metaclassName_return extends ParserRuleReturnScope {
        public Node returnNode;
        public StringTemplate st;
        public Object getTemplate() { return st; }
        public String toString() { return st==null?null:st.toString(); }
    };

    // $ANTLR start "metaclassName"
    // api2mol.g:224:1: metaclassName returns [Node returnNode] : IDGen= ID ;
    public final api2molParser.metaclassName_return metaclassName() throws RecognitionException {
        api2molParser.metaclassName_return retval = new api2molParser.metaclassName_return();
        retval.start = input.LT(1);

        Token IDGen=null;

        try {
            // api2mol.g:225:1: (IDGen= ID )
            // api2mol.g:225:4: IDGen= ID
            {
            IDGen=(Token)match(input,ID,FOLLOW_ID_in_metaclassName247); if (state.failed) return retval;
            if ( state.backtracking==0 ) {

              		// Create return CST Node
              		Node metaclassNameReturnNode = CSTFactoryImpl.eINSTANCE.createNode();
              		metaclassNameReturnNode.setKind("metaclassName");
              	    // Create a CST Leaf
              		if(IDGen != null) {
              			Leaf IDGenLeaf = CSTFactoryImpl.eINSTANCE.createLeaf("ID", (IDGen!=null?IDGen.getText():null), IDGen.getCharPositionInLine(), IDGen.getLine());
              			metaclassNameReturnNode.getChildren().add(IDGenLeaf);
              		}
              		// Returns the Node with CST Leaves/Nodes
              		retval.returnNode = metaclassNameReturnNode;
              	
            }

            }

            retval.stop = input.LT(-1);

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {
        }
        return retval;
    }
    // $ANTLR end "metaclassName"

    public static class instanceName_return extends ParserRuleReturnScope {
        public Node returnNode;
        public StringTemplate st;
        public Object getTemplate() { return st; }
        public String toString() { return st==null?null:st.toString(); }
    };

    // $ANTLR start "instanceName"
    // api2mol.g:240:1: instanceName returns [Node returnNode] : IDGen= ID (DOTGen_List+= DOT IDGen_1_List+= ID )* ;
    public final api2molParser.instanceName_return instanceName() throws RecognitionException {
        api2molParser.instanceName_return retval = new api2molParser.instanceName_return();
        retval.start = input.LT(1);

        Token IDGen=null;
        Token DOTGen_List=null;
        Token IDGen_1_List=null;
        List list_DOTGen_List=null;
        List list_IDGen_1_List=null;

        try {
            // api2mol.g:241:1: (IDGen= ID (DOTGen_List+= DOT IDGen_1_List+= ID )* )
            // api2mol.g:241:4: IDGen= ID (DOTGen_List+= DOT IDGen_1_List+= ID )*
            {
            IDGen=(Token)match(input,ID,FOLLOW_ID_in_instanceName270); if (state.failed) return retval;
            // api2mol.g:241:13: (DOTGen_List+= DOT IDGen_1_List+= ID )*
            loop7:
            do {
                int alt7=2;
                int LA7_0 = input.LA(1);

                if ( (LA7_0==DOT) ) {
                    alt7=1;
                }


                switch (alt7) {
            	case 1 :
            	    // api2mol.g:241:15: DOTGen_List+= DOT IDGen_1_List+= ID
            	    {
            	    DOTGen_List=(Token)match(input,DOT,FOLLOW_DOT_in_instanceName276); if (state.failed) return retval;
            	    if (list_DOTGen_List==null) list_DOTGen_List=new ArrayList();
            	    list_DOTGen_List.add(DOTGen_List);

            	    IDGen_1_List=(Token)match(input,ID,FOLLOW_ID_in_instanceName281); if (state.failed) return retval;
            	    if (list_IDGen_1_List==null) list_IDGen_1_List=new ArrayList();
            	    list_IDGen_1_List.add(IDGen_1_List);


            	    }
            	    break;

            	default :
            	    break loop7;
                }
            } while (true);

            if ( state.backtracking==0 ) {

              		// Create return CST Node
              		Node instanceNameReturnNode = CSTFactoryImpl.eINSTANCE.createNode();
              		instanceNameReturnNode.setKind("instanceName");
              	    // Create a CST Leaf
              		if(IDGen != null) {
              			Leaf IDGenLeaf = CSTFactoryImpl.eINSTANCE.createLeaf("ID", (IDGen!=null?IDGen.getText():null), IDGen.getCharPositionInLine(), IDGen.getLine());
              			instanceNameReturnNode.getChildren().add(IDGenLeaf);
              		}

              		// Create a special CST Node for terminal DOTGen_List aggregation
              		if(list_DOTGen_List != null) {
              	    for(int pos = 0; pos < list_DOTGen_List.size(); pos++ )  { 
              		// Terminal extractor
              	    if(list_DOTGen_List != null) {
              		    Token t = (Token) list_DOTGen_List.get(pos); 
              		    Leaf DOTGen_ListLeaf = CSTFactoryImpl.eINSTANCE.createLeaf("DOT", t.getText(), t.getCharPositionInLine(), t.getLine());
              			instanceNameReturnNode.getChildren().add(DOTGen_ListLeaf);
              		}
              		// Terminal extractor
              	    if(list_IDGen_1_List != null) {
              		    Token t = (Token) list_IDGen_1_List.get(pos); 
              		    Leaf IDGen_1_ListLeaf = CSTFactoryImpl.eINSTANCE.createLeaf("ID", t.getText(), t.getCharPositionInLine(), t.getLine());
              			instanceNameReturnNode.getChildren().add(IDGen_1_ListLeaf);
              		}
              		}
              		}

              		// Returns the Node with CST Leaves/Nodes
              		retval.returnNode = instanceNameReturnNode;
              	
            }

            }

            retval.stop = input.LT(-1);

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {
        }
        return retval;
    }
    // $ANTLR end "instanceName"

    public static class section_return extends ParserRuleReturnScope {
        public Node returnNode;
        public StringTemplate st;
        public Object getTemplate() { return st; }
        public String toString() { return st==null?null:st.toString(); }
    };

    // $ANTLR start "section"
    // api2mol.g:275:1: section returns [Node returnNode] : (newSectionGen+= newSection | multipleSectionGen+= multipleSection | propertySectionGen+= propertySection | valueSectionGen+= valueSection );
    public final api2molParser.section_return section() throws RecognitionException {
        api2molParser.section_return retval = new api2molParser.section_return();
        retval.start = input.LT(1);

        List list_newSectionGen=null;
        List list_multipleSectionGen=null;
        List list_propertySectionGen=null;
        List list_valueSectionGen=null;
        RuleReturnScope newSectionGen = null;
        RuleReturnScope multipleSectionGen = null;
        RuleReturnScope propertySectionGen = null;
        RuleReturnScope valueSectionGen = null;
        try {
            // api2mol.g:276:1: (newSectionGen+= newSection | multipleSectionGen+= multipleSection | propertySectionGen+= propertySection | valueSectionGen+= valueSection )
            int alt8=4;
            alt8 = dfa8.predict(input);
            switch (alt8) {
                case 1 :
                    // api2mol.g:276:4: newSectionGen+= newSection
                    {
                    pushFollow(FOLLOW_newSection_in_section305);
                    newSectionGen=newSection();

                    state._fsp--;
                    if (state.failed) return retval;
                    if (list_newSectionGen==null) list_newSectionGen=new ArrayList();
                    list_newSectionGen.add(newSectionGen);

                    if ( state.backtracking==0 ) {

                      		// Create return CST Node
                      		Node sectionReturnNode = CSTFactoryImpl.eINSTANCE.createNode();
                      		sectionReturnNode.setKind("section");
                      	    // Create a CST Node
                      		if(list_newSectionGen != null) {
                      	        for(Iterator it = list_newSectionGen.iterator(); it.hasNext(); )  { 
                      	            api2molParser.newSection_return r = (api2molParser.newSection_return) it.next(); 
                      	            if(r != null && r.returnNode != null) {
                      	            	r.returnNode.setKind("newSection");
                      	            	sectionReturnNode.getChildren().add(r.returnNode);
                      	            } 
                      	        }
                      	    }
                      		// Returns the Node with CST Leaves/Nodes
                      		retval.returnNode = sectionReturnNode;
                      	
                    }

                    }
                    break;
                case 2 :
                    // api2mol.g:294:5: multipleSectionGen+= multipleSection
                    {
                    pushFollow(FOLLOW_multipleSection_in_section317);
                    multipleSectionGen=multipleSection();

                    state._fsp--;
                    if (state.failed) return retval;
                    if (list_multipleSectionGen==null) list_multipleSectionGen=new ArrayList();
                    list_multipleSectionGen.add(multipleSectionGen);

                    if ( state.backtracking==0 ) {

                      		// Create return CST Node
                      		Node sectionReturnNode = CSTFactoryImpl.eINSTANCE.createNode();
                      		sectionReturnNode.setKind("section");
                      	    // Create a CST Node
                      		if(list_multipleSectionGen != null) {
                      	        for(Iterator it = list_multipleSectionGen.iterator(); it.hasNext(); )  { 
                      	            api2molParser.multipleSection_return r = (api2molParser.multipleSection_return) it.next(); 
                      	            if(r != null && r.returnNode != null) {
                      	            	r.returnNode.setKind("multipleSection");
                      	            	sectionReturnNode.getChildren().add(r.returnNode);
                      	            } 
                      	        }
                      	    }
                      		// Returns the Node with CST Leaves/Nodes
                      		retval.returnNode = sectionReturnNode;
                      	
                    }

                    }
                    break;
                case 3 :
                    // api2mol.g:312:5: propertySectionGen+= propertySection
                    {
                    pushFollow(FOLLOW_propertySection_in_section329);
                    propertySectionGen=propertySection();

                    state._fsp--;
                    if (state.failed) return retval;
                    if (list_propertySectionGen==null) list_propertySectionGen=new ArrayList();
                    list_propertySectionGen.add(propertySectionGen);

                    if ( state.backtracking==0 ) {

                      		// Create return CST Node
                      		Node sectionReturnNode = CSTFactoryImpl.eINSTANCE.createNode();
                      		sectionReturnNode.setKind("section");
                      	    // Create a CST Node
                      		if(list_propertySectionGen != null) {
                      	        for(Iterator it = list_propertySectionGen.iterator(); it.hasNext(); )  { 
                      	            api2molParser.propertySection_return r = (api2molParser.propertySection_return) it.next(); 
                      	            if(r != null && r.returnNode != null) {
                      	            	r.returnNode.setKind("propertySection");
                      	            	sectionReturnNode.getChildren().add(r.returnNode);
                      	            } 
                      	        }
                      	    }
                      		// Returns the Node with CST Leaves/Nodes
                      		retval.returnNode = sectionReturnNode;
                      	
                    }

                    }
                    break;
                case 4 :
                    // api2mol.g:330:5: valueSectionGen+= valueSection
                    {
                    pushFollow(FOLLOW_valueSection_in_section341);
                    valueSectionGen=valueSection();

                    state._fsp--;
                    if (state.failed) return retval;
                    if (list_valueSectionGen==null) list_valueSectionGen=new ArrayList();
                    list_valueSectionGen.add(valueSectionGen);

                    if ( state.backtracking==0 ) {

                      		// Create return CST Node
                      		Node sectionReturnNode = CSTFactoryImpl.eINSTANCE.createNode();
                      		sectionReturnNode.setKind("section");
                      	    // Create a CST Node
                      		if(list_valueSectionGen != null) {
                      	        for(Iterator it = list_valueSectionGen.iterator(); it.hasNext(); )  { 
                      	            api2molParser.valueSection_return r = (api2molParser.valueSection_return) it.next(); 
                      	            if(r != null && r.returnNode != null) {
                      	            	r.returnNode.setKind("valueSection");
                      	            	sectionReturnNode.getChildren().add(r.returnNode);
                      	            } 
                      	        }
                      	    }
                      		// Returns the Node with CST Leaves/Nodes
                      		retval.returnNode = sectionReturnNode;
                      	
                    }

                    }
                    break;

            }
            retval.stop = input.LT(-1);

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {
        }
        return retval;
    }
    // $ANTLR end "section"

    public static class newSection_return extends ParserRuleReturnScope {
        public Node returnNode;
        public StringTemplate st;
        public Object getTemplate() { return st; }
        public String toString() { return st==null?null:st.toString(); }
    };

    // $ANTLR start "newSection"
    // api2mol.g:350:1: newSection returns [Node returnNode] : ATGen= AT NEWGen= NEW (constructorCallGen+= constructorCall )* ;
    public final api2molParser.newSection_return newSection() throws RecognitionException {
        api2molParser.newSection_return retval = new api2molParser.newSection_return();
        retval.start = input.LT(1);

        Token ATGen=null;
        Token NEWGen=null;
        List list_constructorCallGen=null;
        RuleReturnScope constructorCallGen = null;
        try {
            // api2mol.g:351:1: (ATGen= AT NEWGen= NEW (constructorCallGen+= constructorCall )* )
            // api2mol.g:351:4: ATGen= AT NEWGen= NEW (constructorCallGen+= constructorCall )*
            {
            ATGen=(Token)match(input,AT,FOLLOW_AT_in_newSection363); if (state.failed) return retval;
            NEWGen=(Token)match(input,NEW,FOLLOW_NEW_in_newSection368); if (state.failed) return retval;
            // api2mol.g:351:44: (constructorCallGen+= constructorCall )*
            loop9:
            do {
                int alt9=2;
                int LA9_0 = input.LA(1);

                if ( (LA9_0==ID) ) {
                    int LA9_3 = input.LA(2);

                    if ( (LA9_3==LPAREN) ) {
                        alt9=1;
                    }


                }


                switch (alt9) {
            	case 1 :
            	    // api2mol.g:0:0: constructorCallGen+= constructorCall
            	    {
            	    pushFollow(FOLLOW_constructorCall_in_newSection373);
            	    constructorCallGen=constructorCall();

            	    state._fsp--;
            	    if (state.failed) return retval;
            	    if (list_constructorCallGen==null) list_constructorCallGen=new ArrayList();
            	    list_constructorCallGen.add(constructorCallGen);


            	    }
            	    break;

            	default :
            	    break loop9;
                }
            } while (true);

            if ( state.backtracking==0 ) {

              		// Create return CST Node
              		Node newSectionReturnNode = CSTFactoryImpl.eINSTANCE.createNode();
              		newSectionReturnNode.setKind("newSection");
              	    // Create a CST Leaf
              		if(ATGen != null) {
              			Leaf ATGenLeaf = CSTFactoryImpl.eINSTANCE.createLeaf("AT", (ATGen!=null?ATGen.getText():null), ATGen.getCharPositionInLine(), ATGen.getLine());
              			newSectionReturnNode.getChildren().add(ATGenLeaf);
              		}
              	    // Create a CST Leaf
              		if(NEWGen != null) {
              			Leaf NEWGenLeaf = CSTFactoryImpl.eINSTANCE.createLeaf("NEW", (NEWGen!=null?NEWGen.getText():null), NEWGen.getCharPositionInLine(), NEWGen.getLine());
              			newSectionReturnNode.getChildren().add(NEWGenLeaf);
              		}
              	    // Create a CST Node
              		if(list_constructorCallGen != null) {
              	        for(Iterator it = list_constructorCallGen.iterator(); it.hasNext(); )  { 
              	            api2molParser.constructorCall_return r = (api2molParser.constructorCall_return) it.next(); 
              	            if(r != null && r.returnNode != null) {
              	            	r.returnNode.setKind("constructorCall");
              	            	newSectionReturnNode.getChildren().add(r.returnNode);
              	            } 
              	        }
              	    }
              		// Returns the Node with CST Leaves/Nodes
              		retval.returnNode = newSectionReturnNode;
              	
            }

            }

            retval.stop = input.LT(-1);

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {
        }
        return retval;
    }
    // $ANTLR end "newSection"

    public static class multipleSection_return extends ParserRuleReturnScope {
        public Node returnNode;
        public StringTemplate st;
        public Object getTemplate() { return st; }
        public String toString() { return st==null?null:st.toString(); }
    };

    // $ANTLR start "multipleSection"
    // api2mol.g:381:1: multipleSection returns [Node returnNode] : ATGen= AT MULTIPLEGen= MULTIPLE (statementGen+= statement )* ;
    public final api2molParser.multipleSection_return multipleSection() throws RecognitionException {
        api2molParser.multipleSection_return retval = new api2molParser.multipleSection_return();
        retval.start = input.LT(1);

        Token ATGen=null;
        Token MULTIPLEGen=null;
        List list_statementGen=null;
        RuleReturnScope statementGen = null;
        try {
            // api2mol.g:382:1: (ATGen= AT MULTIPLEGen= MULTIPLE (statementGen+= statement )* )
            // api2mol.g:382:4: ATGen= AT MULTIPLEGen= MULTIPLE (statementGen+= statement )*
            {
            ATGen=(Token)match(input,AT,FOLLOW_AT_in_multipleSection398); if (state.failed) return retval;
            MULTIPLEGen=(Token)match(input,MULTIPLE,FOLLOW_MULTIPLE_in_multipleSection403); if (state.failed) return retval;
            // api2mol.g:382:48: (statementGen+= statement )*
            loop10:
            do {
                int alt10=2;
                int LA10_0 = input.LA(1);

                if ( (LA10_0==ID) ) {
                    int LA10_3 = input.LA(2);

                    if ( (LA10_3==SEMI||(LA10_3>=ID && LA10_3<=LPAREN)) ) {
                        alt10=1;
                    }


                }


                switch (alt10) {
            	case 1 :
            	    // api2mol.g:0:0: statementGen+= statement
            	    {
            	    pushFollow(FOLLOW_statement_in_multipleSection408);
            	    statementGen=statement();

            	    state._fsp--;
            	    if (state.failed) return retval;
            	    if (list_statementGen==null) list_statementGen=new ArrayList();
            	    list_statementGen.add(statementGen);


            	    }
            	    break;

            	default :
            	    break loop10;
                }
            } while (true);

            if ( state.backtracking==0 ) {

              		// Create return CST Node
              		Node multipleSectionReturnNode = CSTFactoryImpl.eINSTANCE.createNode();
              		multipleSectionReturnNode.setKind("multipleSection");
              	    // Create a CST Leaf
              		if(ATGen != null) {
              			Leaf ATGenLeaf = CSTFactoryImpl.eINSTANCE.createLeaf("AT", (ATGen!=null?ATGen.getText():null), ATGen.getCharPositionInLine(), ATGen.getLine());
              			multipleSectionReturnNode.getChildren().add(ATGenLeaf);
              		}
              	    // Create a CST Leaf
              		if(MULTIPLEGen != null) {
              			Leaf MULTIPLEGenLeaf = CSTFactoryImpl.eINSTANCE.createLeaf("MULTIPLE", (MULTIPLEGen!=null?MULTIPLEGen.getText():null), MULTIPLEGen.getCharPositionInLine(), MULTIPLEGen.getLine());
              			multipleSectionReturnNode.getChildren().add(MULTIPLEGenLeaf);
              		}
              	    // Create a CST Node
              		if(list_statementGen != null) {
              	        for(Iterator it = list_statementGen.iterator(); it.hasNext(); )  { 
              	            api2molParser.statement_return r = (api2molParser.statement_return) it.next(); 
              	            if(r != null && r.returnNode != null) {
              	            	r.returnNode.setKind("statement");
              	            	multipleSectionReturnNode.getChildren().add(r.returnNode);
              	            } 
              	        }
              	    }
              		// Returns the Node with CST Leaves/Nodes
              		retval.returnNode = multipleSectionReturnNode;
              	
            }

            }

            retval.stop = input.LT(-1);

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {
        }
        return retval;
    }
    // $ANTLR end "multipleSection"

    public static class propertySection_return extends ParserRuleReturnScope {
        public Node returnNode;
        public StringTemplate st;
        public Object getTemplate() { return st; }
        public String toString() { return st==null?null:st.toString(); }
    };

    // $ANTLR start "propertySection"
    // api2mol.g:412:1: propertySection returns [Node returnNode] : IDGen= ID COLONGen= COLON (statementGen+= statement )* ;
    public final api2molParser.propertySection_return propertySection() throws RecognitionException {
        api2molParser.propertySection_return retval = new api2molParser.propertySection_return();
        retval.start = input.LT(1);

        Token IDGen=null;
        Token COLONGen=null;
        List list_statementGen=null;
        RuleReturnScope statementGen = null;
        try {
            // api2mol.g:413:1: (IDGen= ID COLONGen= COLON (statementGen+= statement )* )
            // api2mol.g:413:4: IDGen= ID COLONGen= COLON (statementGen+= statement )*
            {
            IDGen=(Token)match(input,ID,FOLLOW_ID_in_propertySection431); if (state.failed) return retval;
            COLONGen=(Token)match(input,COLON,FOLLOW_COLON_in_propertySection436); if (state.failed) return retval;
            // api2mol.g:413:42: (statementGen+= statement )*
            loop11:
            do {
                int alt11=2;
                int LA11_0 = input.LA(1);

                if ( (LA11_0==ID) ) {
                    int LA11_3 = input.LA(2);

                    if ( (LA11_3==SEMI||(LA11_3>=ID && LA11_3<=LPAREN)) ) {
                        alt11=1;
                    }


                }


                switch (alt11) {
            	case 1 :
            	    // api2mol.g:0:0: statementGen+= statement
            	    {
            	    pushFollow(FOLLOW_statement_in_propertySection441);
            	    statementGen=statement();

            	    state._fsp--;
            	    if (state.failed) return retval;
            	    if (list_statementGen==null) list_statementGen=new ArrayList();
            	    list_statementGen.add(statementGen);


            	    }
            	    break;

            	default :
            	    break loop11;
                }
            } while (true);

            if ( state.backtracking==0 ) {

              		// Create return CST Node
              		Node propertySectionReturnNode = CSTFactoryImpl.eINSTANCE.createNode();
              		propertySectionReturnNode.setKind("propertySection");
              	    // Create a CST Leaf
              		if(IDGen != null) {
              			Leaf IDGenLeaf = CSTFactoryImpl.eINSTANCE.createLeaf("ID", (IDGen!=null?IDGen.getText():null), IDGen.getCharPositionInLine(), IDGen.getLine());
              			propertySectionReturnNode.getChildren().add(IDGenLeaf);
              		}
              	    // Create a CST Leaf
              		if(COLONGen != null) {
              			Leaf COLONGenLeaf = CSTFactoryImpl.eINSTANCE.createLeaf("COLON", (COLONGen!=null?COLONGen.getText():null), COLONGen.getCharPositionInLine(), COLONGen.getLine());
              			propertySectionReturnNode.getChildren().add(COLONGenLeaf);
              		}
              	    // Create a CST Node
              		if(list_statementGen != null) {
              	        for(Iterator it = list_statementGen.iterator(); it.hasNext(); )  { 
              	            api2molParser.statement_return r = (api2molParser.statement_return) it.next(); 
              	            if(r != null && r.returnNode != null) {
              	            	r.returnNode.setKind("statement");
              	            	propertySectionReturnNode.getChildren().add(r.returnNode);
              	            } 
              	        }
              	    }
              		// Returns the Node with CST Leaves/Nodes
              		retval.returnNode = propertySectionReturnNode;
              	
            }

            }

            retval.stop = input.LT(-1);

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {
        }
        return retval;
    }
    // $ANTLR end "propertySection"

    public static class valueSection_return extends ParserRuleReturnScope {
        public Node returnNode;
        public StringTemplate st;
        public Object getTemplate() { return st; }
        public String toString() { return st==null?null:st.toString(); }
    };

    // $ANTLR start "valueSection"
    // api2mol.g:443:1: valueSection returns [Node returnNode] : IDGen= ID COLONGen= COLON instanceNameGen+= instanceName SEMIGen= SEMI ;
    public final api2molParser.valueSection_return valueSection() throws RecognitionException {
        api2molParser.valueSection_return retval = new api2molParser.valueSection_return();
        retval.start = input.LT(1);

        Token IDGen=null;
        Token COLONGen=null;
        Token SEMIGen=null;
        List list_instanceNameGen=null;
        RuleReturnScope instanceNameGen = null;
        try {
            // api2mol.g:444:1: (IDGen= ID COLONGen= COLON instanceNameGen+= instanceName SEMIGen= SEMI )
            // api2mol.g:444:4: IDGen= ID COLONGen= COLON instanceNameGen+= instanceName SEMIGen= SEMI
            {
            IDGen=(Token)match(input,ID,FOLLOW_ID_in_valueSection465); if (state.failed) return retval;
            COLONGen=(Token)match(input,COLON,FOLLOW_COLON_in_valueSection470); if (state.failed) return retval;
            pushFollow(FOLLOW_instanceName_in_valueSection475);
            instanceNameGen=instanceName();

            state._fsp--;
            if (state.failed) return retval;
            if (list_instanceNameGen==null) list_instanceNameGen=new ArrayList();
            list_instanceNameGen.add(instanceNameGen);

            SEMIGen=(Token)match(input,SEMI,FOLLOW_SEMI_in_valueSection480); if (state.failed) return retval;
            if ( state.backtracking==0 ) {

              		// Create return CST Node
              		Node valueSectionReturnNode = CSTFactoryImpl.eINSTANCE.createNode();
              		valueSectionReturnNode.setKind("valueSection");
              	    // Create a CST Leaf
              		if(IDGen != null) {
              			Leaf IDGenLeaf = CSTFactoryImpl.eINSTANCE.createLeaf("ID", (IDGen!=null?IDGen.getText():null), IDGen.getCharPositionInLine(), IDGen.getLine());
              			valueSectionReturnNode.getChildren().add(IDGenLeaf);
              		}
              	    // Create a CST Leaf
              		if(COLONGen != null) {
              			Leaf COLONGenLeaf = CSTFactoryImpl.eINSTANCE.createLeaf("COLON", (COLONGen!=null?COLONGen.getText():null), COLONGen.getCharPositionInLine(), COLONGen.getLine());
              			valueSectionReturnNode.getChildren().add(COLONGenLeaf);
              		}
              	    // Create a CST Node
              		if(list_instanceNameGen != null) {
              	        for(Iterator it = list_instanceNameGen.iterator(); it.hasNext(); )  { 
              	            api2molParser.instanceName_return r = (api2molParser.instanceName_return) it.next(); 
              	            if(r != null && r.returnNode != null) {
              	            	r.returnNode.setKind("instanceName");
              	            	valueSectionReturnNode.getChildren().add(r.returnNode);
              	            } 
              	        }
              	    }
              	    // Create a CST Leaf
              		if(SEMIGen != null) {
              			Leaf SEMIGenLeaf = CSTFactoryImpl.eINSTANCE.createLeaf("SEMI", (SEMIGen!=null?SEMIGen.getText():null), SEMIGen.getCharPositionInLine(), SEMIGen.getLine());
              			valueSectionReturnNode.getChildren().add(SEMIGenLeaf);
              		}
              		// Returns the Node with CST Leaves/Nodes
              		retval.returnNode = valueSectionReturnNode;
              	
            }

            }

            retval.stop = input.LT(-1);

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {
        }
        return retval;
    }
    // $ANTLR end "valueSection"

    public static class statement_return extends ParserRuleReturnScope {
        public Node returnNode;
        public StringTemplate st;
        public Object getTemplate() { return st; }
        public String toString() { return st==null?null:st.toString(); }
    };

    // $ANTLR start "statement"
    // api2mol.g:479:1: statement returns [Node returnNode] : IDGen= ID (LPARENGen= LPAREN variableGen+= variable (COMMAGen_List+= COMMA variableGen_1+= variable )* RPARENGen= RPAREN )? (methodCallGen+= methodCall )? SEMIGen= SEMI ;
    public final api2molParser.statement_return statement() throws RecognitionException {
        api2molParser.statement_return retval = new api2molParser.statement_return();
        retval.start = input.LT(1);

        Token IDGen=null;
        Token LPARENGen=null;
        Token RPARENGen=null;
        Token SEMIGen=null;
        Token COMMAGen_List=null;
        List list_COMMAGen_List=null;
        List list_variableGen=null;
        List list_variableGen_1=null;
        List list_methodCallGen=null;
        RuleReturnScope variableGen = null;
        RuleReturnScope variableGen_1 = null;
        RuleReturnScope methodCallGen = null;
        try {
            // api2mol.g:480:1: (IDGen= ID (LPARENGen= LPAREN variableGen+= variable (COMMAGen_List+= COMMA variableGen_1+= variable )* RPARENGen= RPAREN )? (methodCallGen+= methodCall )? SEMIGen= SEMI )
            // api2mol.g:480:4: IDGen= ID (LPARENGen= LPAREN variableGen+= variable (COMMAGen_List+= COMMA variableGen_1+= variable )* RPARENGen= RPAREN )? (methodCallGen+= methodCall )? SEMIGen= SEMI
            {
            IDGen=(Token)match(input,ID,FOLLOW_ID_in_statement502); if (state.failed) return retval;
            // api2mol.g:480:13: (LPARENGen= LPAREN variableGen+= variable (COMMAGen_List+= COMMA variableGen_1+= variable )* RPARENGen= RPAREN )?
            int alt13=2;
            int LA13_0 = input.LA(1);

            if ( (LA13_0==LPAREN) ) {
                alt13=1;
            }
            switch (alt13) {
                case 1 :
                    // api2mol.g:480:15: LPARENGen= LPAREN variableGen+= variable (COMMAGen_List+= COMMA variableGen_1+= variable )* RPARENGen= RPAREN
                    {
                    LPARENGen=(Token)match(input,LPAREN,FOLLOW_LPAREN_in_statement508); if (state.failed) return retval;
                    pushFollow(FOLLOW_variable_in_statement513);
                    variableGen=variable();

                    state._fsp--;
                    if (state.failed) return retval;
                    if (list_variableGen==null) list_variableGen=new ArrayList();
                    list_variableGen.add(variableGen);

                    // api2mol.g:480:55: (COMMAGen_List+= COMMA variableGen_1+= variable )*
                    loop12:
                    do {
                        int alt12=2;
                        int LA12_0 = input.LA(1);

                        if ( (LA12_0==COMMA) ) {
                            alt12=1;
                        }


                        switch (alt12) {
                    	case 1 :
                    	    // api2mol.g:480:57: COMMAGen_List+= COMMA variableGen_1+= variable
                    	    {
                    	    COMMAGen_List=(Token)match(input,COMMA,FOLLOW_COMMA_in_statement519); if (state.failed) return retval;
                    	    if (list_COMMAGen_List==null) list_COMMAGen_List=new ArrayList();
                    	    list_COMMAGen_List.add(COMMAGen_List);

                    	    pushFollow(FOLLOW_variable_in_statement524);
                    	    variableGen_1=variable();

                    	    state._fsp--;
                    	    if (state.failed) return retval;
                    	    if (list_variableGen_1==null) list_variableGen_1=new ArrayList();
                    	    list_variableGen_1.add(variableGen_1);


                    	    }
                    	    break;

                    	default :
                    	    break loop12;
                        }
                    } while (true);

                    RPARENGen=(Token)match(input,RPAREN,FOLLOW_RPAREN_in_statement531); if (state.failed) return retval;

                    }
                    break;

            }

            // api2mol.g:480:125: (methodCallGen+= methodCall )?
            int alt14=2;
            int LA14_0 = input.LA(1);

            if ( (LA14_0==ID) ) {
                alt14=1;
            }
            switch (alt14) {
                case 1 :
                    // api2mol.g:480:127: methodCallGen+= methodCall
                    {
                    pushFollow(FOLLOW_methodCall_in_statement539);
                    methodCallGen=methodCall();

                    state._fsp--;
                    if (state.failed) return retval;
                    if (list_methodCallGen==null) list_methodCallGen=new ArrayList();
                    list_methodCallGen.add(methodCallGen);


                    }
                    break;

            }

            SEMIGen=(Token)match(input,SEMI,FOLLOW_SEMI_in_statement546); if (state.failed) return retval;
            if ( state.backtracking==0 ) {

              		// Create return CST Node
              		Node statementReturnNode = CSTFactoryImpl.eINSTANCE.createNode();
              		statementReturnNode.setKind("statement");
              	    // Create a CST Leaf
              		if(IDGen != null) {
              			Leaf IDGenLeaf = CSTFactoryImpl.eINSTANCE.createLeaf("ID", (IDGen!=null?IDGen.getText():null), IDGen.getCharPositionInLine(), IDGen.getLine());
              			statementReturnNode.getChildren().add(IDGenLeaf);
              		}
              	    // Create a CST Leaf
              		if(LPARENGen != null) {
              			Leaf LPARENGenLeaf = CSTFactoryImpl.eINSTANCE.createLeaf("LPAREN", (LPARENGen!=null?LPARENGen.getText():null), LPARENGen.getCharPositionInLine(), LPARENGen.getLine());
              			statementReturnNode.getChildren().add(LPARENGenLeaf);
              		}
              	    // Create a CST Node
              		if(list_variableGen != null) {
              	        for(Iterator it = list_variableGen.iterator(); it.hasNext(); )  { 
              	            api2molParser.variable_return r = (api2molParser.variable_return) it.next(); 
              	            if(r != null && r.returnNode != null) {
              	            	r.returnNode.setKind("variable");
              	            	statementReturnNode.getChildren().add(r.returnNode);
              	            } 
              	        }
              	    }

              		// Create a special CST Node for terminal COMMAGen_List aggregation
              		if(list_COMMAGen_List != null) {
              	    for(int pos = 0; pos < list_COMMAGen_List.size(); pos++ )  { 
              		// Terminal extractor
              	    if(list_COMMAGen_List != null) {
              		    Token t = (Token) list_COMMAGen_List.get(pos); 
              		    Leaf COMMAGen_ListLeaf = CSTFactoryImpl.eINSTANCE.createLeaf("COMMA", t.getText(), t.getCharPositionInLine(), t.getLine());
              			statementReturnNode.getChildren().add(COMMAGen_ListLeaf);
              		}
              		// No Terminal extractor
              	    if(list_variableGen_1 != null) {		
              	    	api2molParser.variable_return r = (api2molParser.variable_return) list_variableGen_1.get(pos); 
              	    	if(r != null && r.returnNode != null) {
              	        	r.returnNode.setKind("variable");
              	    		statementReturnNode.getChildren().add(r.returnNode);
              	    	} 
              		}
              		}
              		}

              	    // Create a CST Leaf
              		if(RPARENGen != null) {
              			Leaf RPARENGenLeaf = CSTFactoryImpl.eINSTANCE.createLeaf("RPAREN", (RPARENGen!=null?RPARENGen.getText():null), RPARENGen.getCharPositionInLine(), RPARENGen.getLine());
              			statementReturnNode.getChildren().add(RPARENGenLeaf);
              		}
              	    // Create a CST Node
              		if(list_methodCallGen != null) {
              	        for(Iterator it = list_methodCallGen.iterator(); it.hasNext(); )  { 
              	            api2molParser.methodCall_return r = (api2molParser.methodCall_return) it.next(); 
              	            if(r != null && r.returnNode != null) {
              	            	r.returnNode.setKind("methodCall");
              	            	statementReturnNode.getChildren().add(r.returnNode);
              	            } 
              	        }
              	    }
              	    // Create a CST Leaf
              		if(SEMIGen != null) {
              			Leaf SEMIGenLeaf = CSTFactoryImpl.eINSTANCE.createLeaf("SEMI", (SEMIGen!=null?SEMIGen.getText():null), SEMIGen.getCharPositionInLine(), SEMIGen.getLine());
              			statementReturnNode.getChildren().add(SEMIGenLeaf);
              		}
              		// Returns the Node with CST Leaves/Nodes
              		retval.returnNode = statementReturnNode;
              	
            }

            }

            retval.stop = input.LT(-1);

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {
        }
        return retval;
    }
    // $ANTLR end "statement"

    public static class constructorCall_return extends ParserRuleReturnScope {
        public Node returnNode;
        public StringTemplate st;
        public Object getTemplate() { return st; }
        public String toString() { return st==null?null:st.toString(); }
    };

    // $ANTLR start "constructorCall"
    // api2mol.g:551:1: constructorCall returns [Node returnNode] : IDGen= ID LPARENGen= LPAREN (paramGen+= param (COMMAGen_List+= COMMA paramGen_1+= param )* )? RPARENGen= RPAREN SEMIGen= SEMI ;
    public final api2molParser.constructorCall_return constructorCall() throws RecognitionException {
        api2molParser.constructorCall_return retval = new api2molParser.constructorCall_return();
        retval.start = input.LT(1);

        Token IDGen=null;
        Token LPARENGen=null;
        Token RPARENGen=null;
        Token SEMIGen=null;
        Token COMMAGen_List=null;
        List list_COMMAGen_List=null;
        List list_paramGen=null;
        List list_paramGen_1=null;
        RuleReturnScope paramGen = null;
        RuleReturnScope paramGen_1 = null;
        try {
            // api2mol.g:552:1: (IDGen= ID LPARENGen= LPAREN (paramGen+= param (COMMAGen_List+= COMMA paramGen_1+= param )* )? RPARENGen= RPAREN SEMIGen= SEMI )
            // api2mol.g:552:4: IDGen= ID LPARENGen= LPAREN (paramGen+= param (COMMAGen_List+= COMMA paramGen_1+= param )* )? RPARENGen= RPAREN SEMIGen= SEMI
            {
            IDGen=(Token)match(input,ID,FOLLOW_ID_in_constructorCall568); if (state.failed) return retval;
            LPARENGen=(Token)match(input,LPAREN,FOLLOW_LPAREN_in_constructorCall573); if (state.failed) return retval;
            // api2mol.g:552:31: (paramGen+= param (COMMAGen_List+= COMMA paramGen_1+= param )* )?
            int alt16=2;
            int LA16_0 = input.LA(1);

            if ( (LA16_0==ID) ) {
                alt16=1;
            }
            switch (alt16) {
                case 1 :
                    // api2mol.g:552:33: paramGen+= param (COMMAGen_List+= COMMA paramGen_1+= param )*
                    {
                    pushFollow(FOLLOW_param_in_constructorCall579);
                    paramGen=param();

                    state._fsp--;
                    if (state.failed) return retval;
                    if (list_paramGen==null) list_paramGen=new ArrayList();
                    list_paramGen.add(paramGen);

                    // api2mol.g:552:49: (COMMAGen_List+= COMMA paramGen_1+= param )*
                    loop15:
                    do {
                        int alt15=2;
                        int LA15_0 = input.LA(1);

                        if ( (LA15_0==COMMA) ) {
                            alt15=1;
                        }


                        switch (alt15) {
                    	case 1 :
                    	    // api2mol.g:552:51: COMMAGen_List+= COMMA paramGen_1+= param
                    	    {
                    	    COMMAGen_List=(Token)match(input,COMMA,FOLLOW_COMMA_in_constructorCall585); if (state.failed) return retval;
                    	    if (list_COMMAGen_List==null) list_COMMAGen_List=new ArrayList();
                    	    list_COMMAGen_List.add(COMMAGen_List);

                    	    pushFollow(FOLLOW_param_in_constructorCall590);
                    	    paramGen_1=param();

                    	    state._fsp--;
                    	    if (state.failed) return retval;
                    	    if (list_paramGen_1==null) list_paramGen_1=new ArrayList();
                    	    list_paramGen_1.add(paramGen_1);


                    	    }
                    	    break;

                    	default :
                    	    break loop15;
                        }
                    } while (true);


                    }
                    break;

            }

            RPARENGen=(Token)match(input,RPAREN,FOLLOW_RPAREN_in_constructorCall599); if (state.failed) return retval;
            SEMIGen=(Token)match(input,SEMI,FOLLOW_SEMI_in_constructorCall604); if (state.failed) return retval;
            if ( state.backtracking==0 ) {

              		// Create return CST Node
              		Node constructorCallReturnNode = CSTFactoryImpl.eINSTANCE.createNode();
              		constructorCallReturnNode.setKind("constructorCall");
              	    // Create a CST Leaf
              		if(IDGen != null) {
              			Leaf IDGenLeaf = CSTFactoryImpl.eINSTANCE.createLeaf("ID", (IDGen!=null?IDGen.getText():null), IDGen.getCharPositionInLine(), IDGen.getLine());
              			constructorCallReturnNode.getChildren().add(IDGenLeaf);
              		}
              	    // Create a CST Leaf
              		if(LPARENGen != null) {
              			Leaf LPARENGenLeaf = CSTFactoryImpl.eINSTANCE.createLeaf("LPAREN", (LPARENGen!=null?LPARENGen.getText():null), LPARENGen.getCharPositionInLine(), LPARENGen.getLine());
              			constructorCallReturnNode.getChildren().add(LPARENGenLeaf);
              		}
              	    // Create a CST Node
              		if(list_paramGen != null) {
              	        for(Iterator it = list_paramGen.iterator(); it.hasNext(); )  { 
              	            api2molParser.param_return r = (api2molParser.param_return) it.next(); 
              	            if(r != null && r.returnNode != null) {
              	            	r.returnNode.setKind("param");
              	            	constructorCallReturnNode.getChildren().add(r.returnNode);
              	            } 
              	        }
              	    }

              		// Create a special CST Node for terminal COMMAGen_List aggregation
              		if(list_COMMAGen_List != null) {
              	    for(int pos = 0; pos < list_COMMAGen_List.size(); pos++ )  { 
              		// Terminal extractor
              	    if(list_COMMAGen_List != null) {
              		    Token t = (Token) list_COMMAGen_List.get(pos); 
              		    Leaf COMMAGen_ListLeaf = CSTFactoryImpl.eINSTANCE.createLeaf("COMMA", t.getText(), t.getCharPositionInLine(), t.getLine());
              			constructorCallReturnNode.getChildren().add(COMMAGen_ListLeaf);
              		}
              		// No Terminal extractor
              	    if(list_paramGen_1 != null) {		
              	    	api2molParser.param_return r = (api2molParser.param_return) list_paramGen_1.get(pos); 
              	    	if(r != null && r.returnNode != null) {
              	        	r.returnNode.setKind("param");
              	    		constructorCallReturnNode.getChildren().add(r.returnNode);
              	    	} 
              		}
              		}
              		}

              	    // Create a CST Leaf
              		if(RPARENGen != null) {
              			Leaf RPARENGenLeaf = CSTFactoryImpl.eINSTANCE.createLeaf("RPAREN", (RPARENGen!=null?RPARENGen.getText():null), RPARENGen.getCharPositionInLine(), RPARENGen.getLine());
              			constructorCallReturnNode.getChildren().add(RPARENGenLeaf);
              		}
              	    // Create a CST Leaf
              		if(SEMIGen != null) {
              			Leaf SEMIGenLeaf = CSTFactoryImpl.eINSTANCE.createLeaf("SEMI", (SEMIGen!=null?SEMIGen.getText():null), SEMIGen.getCharPositionInLine(), SEMIGen.getLine());
              			constructorCallReturnNode.getChildren().add(SEMIGenLeaf);
              		}
              		// Returns the Node with CST Leaves/Nodes
              		retval.returnNode = constructorCallReturnNode;
              	
            }

            }

            retval.stop = input.LT(-1);

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {
        }
        return retval;
    }
    // $ANTLR end "constructorCall"

    public static class methodCall_return extends ParserRuleReturnScope {
        public Node returnNode;
        public StringTemplate st;
        public Object getTemplate() { return st; }
        public String toString() { return st==null?null:st.toString(); }
    };

    // $ANTLR start "methodCall"
    // api2mol.g:613:1: methodCall returns [Node returnNode] : IDGen= ID (LPARENGen= LPAREN (paramGen+= param (COMMAGen_List+= COMMA paramGen_1+= param )* )? RPARENGen= RPAREN )? ;
    public final api2molParser.methodCall_return methodCall() throws RecognitionException {
        api2molParser.methodCall_return retval = new api2molParser.methodCall_return();
        retval.start = input.LT(1);

        Token IDGen=null;
        Token LPARENGen=null;
        Token RPARENGen=null;
        Token COMMAGen_List=null;
        List list_COMMAGen_List=null;
        List list_paramGen=null;
        List list_paramGen_1=null;
        RuleReturnScope paramGen = null;
        RuleReturnScope paramGen_1 = null;
        try {
            // api2mol.g:614:1: (IDGen= ID (LPARENGen= LPAREN (paramGen+= param (COMMAGen_List+= COMMA paramGen_1+= param )* )? RPARENGen= RPAREN )? )
            // api2mol.g:614:4: IDGen= ID (LPARENGen= LPAREN (paramGen+= param (COMMAGen_List+= COMMA paramGen_1+= param )* )? RPARENGen= RPAREN )?
            {
            IDGen=(Token)match(input,ID,FOLLOW_ID_in_methodCall626); if (state.failed) return retval;
            // api2mol.g:614:13: (LPARENGen= LPAREN (paramGen+= param (COMMAGen_List+= COMMA paramGen_1+= param )* )? RPARENGen= RPAREN )?
            int alt19=2;
            int LA19_0 = input.LA(1);

            if ( (LA19_0==LPAREN) ) {
                alt19=1;
            }
            switch (alt19) {
                case 1 :
                    // api2mol.g:614:15: LPARENGen= LPAREN (paramGen+= param (COMMAGen_List+= COMMA paramGen_1+= param )* )? RPARENGen= RPAREN
                    {
                    LPARENGen=(Token)match(input,LPAREN,FOLLOW_LPAREN_in_methodCall632); if (state.failed) return retval;
                    // api2mol.g:614:32: (paramGen+= param (COMMAGen_List+= COMMA paramGen_1+= param )* )?
                    int alt18=2;
                    int LA18_0 = input.LA(1);

                    if ( (LA18_0==ID) ) {
                        alt18=1;
                    }
                    switch (alt18) {
                        case 1 :
                            // api2mol.g:614:34: paramGen+= param (COMMAGen_List+= COMMA paramGen_1+= param )*
                            {
                            pushFollow(FOLLOW_param_in_methodCall638);
                            paramGen=param();

                            state._fsp--;
                            if (state.failed) return retval;
                            if (list_paramGen==null) list_paramGen=new ArrayList();
                            list_paramGen.add(paramGen);

                            // api2mol.g:614:50: (COMMAGen_List+= COMMA paramGen_1+= param )*
                            loop17:
                            do {
                                int alt17=2;
                                int LA17_0 = input.LA(1);

                                if ( (LA17_0==COMMA) ) {
                                    alt17=1;
                                }


                                switch (alt17) {
                            	case 1 :
                            	    // api2mol.g:614:52: COMMAGen_List+= COMMA paramGen_1+= param
                            	    {
                            	    COMMAGen_List=(Token)match(input,COMMA,FOLLOW_COMMA_in_methodCall644); if (state.failed) return retval;
                            	    if (list_COMMAGen_List==null) list_COMMAGen_List=new ArrayList();
                            	    list_COMMAGen_List.add(COMMAGen_List);

                            	    pushFollow(FOLLOW_param_in_methodCall649);
                            	    paramGen_1=param();

                            	    state._fsp--;
                            	    if (state.failed) return retval;
                            	    if (list_paramGen_1==null) list_paramGen_1=new ArrayList();
                            	    list_paramGen_1.add(paramGen_1);


                            	    }
                            	    break;

                            	default :
                            	    break loop17;
                                }
                            } while (true);


                            }
                            break;

                    }

                    RPARENGen=(Token)match(input,RPAREN,FOLLOW_RPAREN_in_methodCall658); if (state.failed) return retval;

                    }
                    break;

            }

            if ( state.backtracking==0 ) {

              		// Create return CST Node
              		Node methodCallReturnNode = CSTFactoryImpl.eINSTANCE.createNode();
              		methodCallReturnNode.setKind("methodCall");
              	    // Create a CST Leaf
              		if(IDGen != null) {
              			Leaf IDGenLeaf = CSTFactoryImpl.eINSTANCE.createLeaf("ID", (IDGen!=null?IDGen.getText():null), IDGen.getCharPositionInLine(), IDGen.getLine());
              			methodCallReturnNode.getChildren().add(IDGenLeaf);
              		}
              	    // Create a CST Leaf
              		if(LPARENGen != null) {
              			Leaf LPARENGenLeaf = CSTFactoryImpl.eINSTANCE.createLeaf("LPAREN", (LPARENGen!=null?LPARENGen.getText():null), LPARENGen.getCharPositionInLine(), LPARENGen.getLine());
              			methodCallReturnNode.getChildren().add(LPARENGenLeaf);
              		}
              	    // Create a CST Node
              		if(list_paramGen != null) {
              	        for(Iterator it = list_paramGen.iterator(); it.hasNext(); )  { 
              	            api2molParser.param_return r = (api2molParser.param_return) it.next(); 
              	            if(r != null && r.returnNode != null) {
              	            	r.returnNode.setKind("param");
              	            	methodCallReturnNode.getChildren().add(r.returnNode);
              	            } 
              	        }
              	    }

              		// Create a special CST Node for terminal COMMAGen_List aggregation
              		if(list_COMMAGen_List != null) {
              	    for(int pos = 0; pos < list_COMMAGen_List.size(); pos++ )  { 
              		// Terminal extractor
              	    if(list_COMMAGen_List != null) {
              		    Token t = (Token) list_COMMAGen_List.get(pos); 
              		    Leaf COMMAGen_ListLeaf = CSTFactoryImpl.eINSTANCE.createLeaf("COMMA", t.getText(), t.getCharPositionInLine(), t.getLine());
              			methodCallReturnNode.getChildren().add(COMMAGen_ListLeaf);
              		}
              		// No Terminal extractor
              	    if(list_paramGen_1 != null) {		
              	    	api2molParser.param_return r = (api2molParser.param_return) list_paramGen_1.get(pos); 
              	    	if(r != null && r.returnNode != null) {
              	        	r.returnNode.setKind("param");
              	    		methodCallReturnNode.getChildren().add(r.returnNode);
              	    	} 
              		}
              		}
              		}

              	    // Create a CST Leaf
              		if(RPARENGen != null) {
              			Leaf RPARENGenLeaf = CSTFactoryImpl.eINSTANCE.createLeaf("RPAREN", (RPARENGen!=null?RPARENGen.getText():null), RPARENGen.getCharPositionInLine(), RPARENGen.getLine());
              			methodCallReturnNode.getChildren().add(RPARENGenLeaf);
              		}
              		// Returns the Node with CST Leaves/Nodes
              		retval.returnNode = methodCallReturnNode;
              	
            }

            }

            retval.stop = input.LT(-1);

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {
        }
        return retval;
    }
    // $ANTLR end "methodCall"

    public static class variable_return extends ParserRuleReturnScope {
        public Node returnNode;
        public StringTemplate st;
        public Object getTemplate() { return st; }
        public String toString() { return st==null?null:st.toString(); }
    };

    // $ANTLR start "variable"
    // api2mol.g:670:1: variable returns [Node returnNode] : IDGen= ID ;
    public final api2molParser.variable_return variable() throws RecognitionException {
        api2molParser.variable_return retval = new api2molParser.variable_return();
        retval.start = input.LT(1);

        Token IDGen=null;

        try {
            // api2mol.g:671:1: (IDGen= ID )
            // api2mol.g:671:4: IDGen= ID
            {
            IDGen=(Token)match(input,ID,FOLLOW_ID_in_variable682); if (state.failed) return retval;
            if ( state.backtracking==0 ) {

              		// Create return CST Node
              		Node variableReturnNode = CSTFactoryImpl.eINSTANCE.createNode();
              		variableReturnNode.setKind("variable");
              	    // Create a CST Leaf
              		if(IDGen != null) {
              			Leaf IDGenLeaf = CSTFactoryImpl.eINSTANCE.createLeaf("ID", (IDGen!=null?IDGen.getText():null), IDGen.getCharPositionInLine(), IDGen.getLine());
              			variableReturnNode.getChildren().add(IDGenLeaf);
              		}
              		// Returns the Node with CST Leaves/Nodes
              		retval.returnNode = variableReturnNode;
              	
            }

            }

            retval.stop = input.LT(-1);

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {
        }
        return retval;
    }
    // $ANTLR end "variable"

    public static class param_return extends ParserRuleReturnScope {
        public Node returnNode;
        public StringTemplate st;
        public Object getTemplate() { return st; }
        public String toString() { return st==null?null:st.toString(); }
    };

    // $ANTLR start "param"
    // api2mol.g:687:1: param returns [Node returnNode] : IDGen= ID ;
    public final api2molParser.param_return param() throws RecognitionException {
        api2molParser.param_return retval = new api2molParser.param_return();
        retval.start = input.LT(1);

        Token IDGen=null;

        try {
            // api2mol.g:688:1: (IDGen= ID )
            // api2mol.g:688:4: IDGen= ID
            {
            IDGen=(Token)match(input,ID,FOLLOW_ID_in_param705); if (state.failed) return retval;
            if ( state.backtracking==0 ) {

              		// Create return CST Node
              		Node paramReturnNode = CSTFactoryImpl.eINSTANCE.createNode();
              		paramReturnNode.setKind("param");
              	    // Create a CST Leaf
              		if(IDGen != null) {
              			Leaf IDGenLeaf = CSTFactoryImpl.eINSTANCE.createLeaf("ID", (IDGen!=null?IDGen.getText():null), IDGen.getCharPositionInLine(), IDGen.getLine());
              			paramReturnNode.getChildren().add(IDGenLeaf);
              		}
              		// Returns the Node with CST Leaves/Nodes
              		retval.returnNode = paramReturnNode;
              	
            }

            }

            retval.stop = input.LT(-1);

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {
        }
        return retval;
    }
    // $ANTLR end "param"

    // $ANTLR start synpred10_api2mol
    public final void synpred10_api2mol_fragment() throws RecognitionException {   
        List list_propertySectionGen=null;
        RuleReturnScope propertySectionGen = null;
        // api2mol.g:312:5: (propertySectionGen+= propertySection )
        // api2mol.g:312:5: propertySectionGen+= propertySection
        {
        pushFollow(FOLLOW_propertySection_in_synpred10_api2mol329);
        propertySectionGen=propertySection();

        state._fsp--;
        if (state.failed) return ;
        if (list_propertySectionGen==null) list_propertySectionGen=new ArrayList();
        list_propertySectionGen.add(propertySectionGen);


        }
    }
    // $ANTLR end synpred10_api2mol

    // Delegated rules

    public final boolean synpred10_api2mol() {
        state.backtracking++;
        int start = input.mark();
        try {
            synpred10_api2mol_fragment(); // can never throw exception
        } catch (RecognitionException re) {
            System.err.println("impossible: "+re);
        }
        boolean success = !state.failed;
        input.rewind(start);
        state.backtracking--;
        state.failed=false;
        return success;
    }


    protected DFA8 dfa8 = new DFA8(this);
    static final String DFA8_eotS =
        "\17\uffff";
    static final String DFA8_eofS =
        "\5\uffff\1\7\11\uffff";
    static final String DFA8_minS =
        "\1\4\1\21\1\15\2\uffff\1\4\1\7\5\uffff\1\0\2\uffff";
    static final String DFA8_maxS =
        "\1\11\1\22\1\15\2\uffff\1\17\1\20\5\uffff\1\0\2\uffff";
    static final String DFA8_acceptS =
        "\3\uffff\1\1\1\2\2\uffff\1\3\3\uffff\1\4\3\uffff";
    static final String DFA8_specialS =
        "\14\uffff\1\0\2\uffff}>";
    static final String[] DFA8_transitionS = {
            "\1\1\4\uffff\1\2",
            "\1\3\1\4",
            "\1\5",
            "",
            "",
            "\1\7\4\uffff\1\6\5\uffff\1\7",
            "\1\14\1\uffff\2\7\2\uffff\1\7\2\uffff\1\13",
            "",
            "",
            "",
            "",
            "",
            "\1\uffff",
            "",
            ""
    };

    static final short[] DFA8_eot = DFA.unpackEncodedString(DFA8_eotS);
    static final short[] DFA8_eof = DFA.unpackEncodedString(DFA8_eofS);
    static final char[] DFA8_min = DFA.unpackEncodedStringToUnsignedChars(DFA8_minS);
    static final char[] DFA8_max = DFA.unpackEncodedStringToUnsignedChars(DFA8_maxS);
    static final short[] DFA8_accept = DFA.unpackEncodedString(DFA8_acceptS);
    static final short[] DFA8_special = DFA.unpackEncodedString(DFA8_specialS);
    static final short[][] DFA8_transition;

    static {
        int numStates = DFA8_transitionS.length;
        DFA8_transition = new short[numStates][];
        for (int i=0; i<numStates; i++) {
            DFA8_transition[i] = DFA.unpackEncodedString(DFA8_transitionS[i]);
        }
    }

    class DFA8 extends DFA {

        public DFA8(BaseRecognizer recognizer) {
            this.recognizer = recognizer;
            this.decisionNumber = 8;
            this.eot = DFA8_eot;
            this.eof = DFA8_eof;
            this.min = DFA8_min;
            this.max = DFA8_max;
            this.accept = DFA8_accept;
            this.special = DFA8_special;
            this.transition = DFA8_transition;
        }
        public String getDescription() {
            return "275:1: section returns [Node returnNode] : (newSectionGen+= newSection | multipleSectionGen+= multipleSection | propertySectionGen+= propertySection | valueSectionGen+= valueSection );";
        }
        public int specialStateTransition(int s, IntStream _input) throws NoViableAltException {
            TokenStream input = (TokenStream)_input;
        	int _s = s;
            switch ( s ) {
                    case 0 : 
                        int LA8_12 = input.LA(1);

                         
                        int index8_12 = input.index();
                        input.rewind();
                        s = -1;
                        if ( (synpred10_api2mol()) ) {s = 7;}

                        else if ( (true) ) {s = 11;}

                         
                        input.seek(index8_12);
                        if ( s>=0 ) return s;
                        break;
            }
            if (state.backtracking>0) {state.failed=true; return -1;}
            NoViableAltException nvae =
                new NoViableAltException(getDescription(), 8, _s, input);
            error(nvae);
            throw nvae;
        }
    }
 

    public static final BitSet FOLLOW_contextSection_in_mainRule51 = new BitSet(new long[]{0x0000000000001212L});
    public static final BitSet FOLLOW_defaultMetaclassSection_in_mainRule57 = new BitSet(new long[]{0x0000000000001202L});
    public static final BitSet FOLLOW_mapping_in_mainRule63 = new BitSet(new long[]{0x0000000000001202L});
    public static final BitSet FOLLOW_AT_in_contextSection87 = new BitSet(new long[]{0x0000000000000020L});
    public static final BitSet FOLLOW_CONTEXT_in_contextSection92 = new BitSet(new long[]{0x0000000000000200L});
    public static final BitSet FOLLOW_instanceName_in_contextSection97 = new BitSet(new long[]{0x00000000000000C0L});
    public static final BitSet FOLLOW_COMMA_in_contextSection103 = new BitSet(new long[]{0x0000000000000200L});
    public static final BitSet FOLLOW_instanceName_in_contextSection108 = new BitSet(new long[]{0x00000000000000C0L});
    public static final BitSet FOLLOW_SEMI_in_contextSection115 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_AT_in_defaultMetaclassSection138 = new BitSet(new long[]{0x0000000000000100L});
    public static final BitSet FOLLOW_DEFAULT_METACLASS_in_defaultMetaclassSection143 = new BitSet(new long[]{0x0000000000000200L});
    public static final BitSet FOLLOW_ID_in_defaultMetaclassSection148 = new BitSet(new long[]{0x0000000000000400L});
    public static final BitSet FOLLOW_LPAREN_in_defaultMetaclassSection153 = new BitSet(new long[]{0x0000000000000200L});
    public static final BitSet FOLLOW_ID_in_defaultMetaclassSection158 = new BitSet(new long[]{0x0000000000000800L});
    public static final BitSet FOLLOW_RPAREN_in_defaultMetaclassSection163 = new BitSet(new long[]{0x0000000000000080L});
    public static final BitSet FOLLOW_SEMI_in_defaultMetaclassSection168 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_ENUM_in_mapping191 = new BitSet(new long[]{0x0000000000001200L});
    public static final BitSet FOLLOW_metaclassName_in_mapping198 = new BitSet(new long[]{0x0000000000002000L});
    public static final BitSet FOLLOW_COLON_in_mapping203 = new BitSet(new long[]{0x0000000000000200L});
    public static final BitSet FOLLOW_instanceName_in_mapping208 = new BitSet(new long[]{0x0000000000004000L});
    public static final BitSet FOLLOW_LCURLY_in_mapping213 = new BitSet(new long[]{0x0000000000008210L});
    public static final BitSet FOLLOW_section_in_mapping218 = new BitSet(new long[]{0x0000000000008210L});
    public static final BitSet FOLLOW_RCURLY_in_mapping224 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_ID_in_metaclassName247 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_ID_in_instanceName270 = new BitSet(new long[]{0x0000000000010002L});
    public static final BitSet FOLLOW_DOT_in_instanceName276 = new BitSet(new long[]{0x0000000000000200L});
    public static final BitSet FOLLOW_ID_in_instanceName281 = new BitSet(new long[]{0x0000000000010002L});
    public static final BitSet FOLLOW_newSection_in_section305 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_multipleSection_in_section317 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_propertySection_in_section329 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_valueSection_in_section341 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_AT_in_newSection363 = new BitSet(new long[]{0x0000000000020000L});
    public static final BitSet FOLLOW_NEW_in_newSection368 = new BitSet(new long[]{0x0000000000000202L});
    public static final BitSet FOLLOW_constructorCall_in_newSection373 = new BitSet(new long[]{0x0000000000000202L});
    public static final BitSet FOLLOW_AT_in_multipleSection398 = new BitSet(new long[]{0x0000000000040000L});
    public static final BitSet FOLLOW_MULTIPLE_in_multipleSection403 = new BitSet(new long[]{0x0000000000000202L});
    public static final BitSet FOLLOW_statement_in_multipleSection408 = new BitSet(new long[]{0x0000000000000202L});
    public static final BitSet FOLLOW_ID_in_propertySection431 = new BitSet(new long[]{0x0000000000002000L});
    public static final BitSet FOLLOW_COLON_in_propertySection436 = new BitSet(new long[]{0x0000000000000202L});
    public static final BitSet FOLLOW_statement_in_propertySection441 = new BitSet(new long[]{0x0000000000000202L});
    public static final BitSet FOLLOW_ID_in_valueSection465 = new BitSet(new long[]{0x0000000000002000L});
    public static final BitSet FOLLOW_COLON_in_valueSection470 = new BitSet(new long[]{0x0000000000000200L});
    public static final BitSet FOLLOW_instanceName_in_valueSection475 = new BitSet(new long[]{0x0000000000000080L});
    public static final BitSet FOLLOW_SEMI_in_valueSection480 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_ID_in_statement502 = new BitSet(new long[]{0x0000000000000680L});
    public static final BitSet FOLLOW_LPAREN_in_statement508 = new BitSet(new long[]{0x0000000000000200L});
    public static final BitSet FOLLOW_variable_in_statement513 = new BitSet(new long[]{0x0000000000000840L});
    public static final BitSet FOLLOW_COMMA_in_statement519 = new BitSet(new long[]{0x0000000000000200L});
    public static final BitSet FOLLOW_variable_in_statement524 = new BitSet(new long[]{0x0000000000000840L});
    public static final BitSet FOLLOW_RPAREN_in_statement531 = new BitSet(new long[]{0x0000000000000280L});
    public static final BitSet FOLLOW_methodCall_in_statement539 = new BitSet(new long[]{0x0000000000000080L});
    public static final BitSet FOLLOW_SEMI_in_statement546 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_ID_in_constructorCall568 = new BitSet(new long[]{0x0000000000000400L});
    public static final BitSet FOLLOW_LPAREN_in_constructorCall573 = new BitSet(new long[]{0x0000000000000A00L});
    public static final BitSet FOLLOW_param_in_constructorCall579 = new BitSet(new long[]{0x0000000000000840L});
    public static final BitSet FOLLOW_COMMA_in_constructorCall585 = new BitSet(new long[]{0x0000000000000200L});
    public static final BitSet FOLLOW_param_in_constructorCall590 = new BitSet(new long[]{0x0000000000000840L});
    public static final BitSet FOLLOW_RPAREN_in_constructorCall599 = new BitSet(new long[]{0x0000000000000080L});
    public static final BitSet FOLLOW_SEMI_in_constructorCall604 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_ID_in_methodCall626 = new BitSet(new long[]{0x0000000000000402L});
    public static final BitSet FOLLOW_LPAREN_in_methodCall632 = new BitSet(new long[]{0x0000000000000A00L});
    public static final BitSet FOLLOW_param_in_methodCall638 = new BitSet(new long[]{0x0000000000000840L});
    public static final BitSet FOLLOW_COMMA_in_methodCall644 = new BitSet(new long[]{0x0000000000000200L});
    public static final BitSet FOLLOW_param_in_methodCall649 = new BitSet(new long[]{0x0000000000000840L});
    public static final BitSet FOLLOW_RPAREN_in_methodCall658 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_ID_in_variable682 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_ID_in_param705 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_propertySection_in_synpred10_api2mol329 = new BitSet(new long[]{0x0000000000000002L});

}