// $ANTLR 3.2 Sep 23, 2009 12:02:23 api2mol.g 2010-06-24 14:24:28

import org.antlr.runtime.*;
import java.util.Stack;
import java.util.List;
import java.util.ArrayList;

public class api2molLexer extends Lexer {
    public static final int LINE_COMMENT=21;
    public static final int NEW=17;
    public static final int LCURLY=14;
    public static final int DEFAULT_METACLASS=8;
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
    public static final int DOT=16;
    public static final int COMMENT=20;

    // delegates
    // delegators

    public api2molLexer() {;} 
    public api2molLexer(CharStream input) {
        this(input, new RecognizerSharedState());
    }
    public api2molLexer(CharStream input, RecognizerSharedState state) {
        super(input,state);

    }
    public String getGrammarFileName() { return "api2mol.g"; }

    // $ANTLR start "NEW"
    public final void mNEW() throws RecognitionException {
        try {
            int _type = NEW;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // api2mol.g:704:10: ( 'new' )
            // api2mol.g:704:12: 'new'
            {
            match("new"); 


            }

            state.type = _type;
            state.channel = _channel;
        }
        finally {
        }
    }
    // $ANTLR end "NEW"

    // $ANTLR start "MULTIPLE"
    public final void mMULTIPLE() throws RecognitionException {
        try {
            int _type = MULTIPLE;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // api2mol.g:705:10: ( 'multiple' )
            // api2mol.g:705:12: 'multiple'
            {
            match("multiple"); 


            }

            state.type = _type;
            state.channel = _channel;
        }
        finally {
        }
    }
    // $ANTLR end "MULTIPLE"

    // $ANTLR start "ENUM"
    public final void mENUM() throws RecognitionException {
        try {
            int _type = ENUM;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // api2mol.g:706:10: ( 'enum' )
            // api2mol.g:706:12: 'enum'
            {
            match("enum"); 


            }

            state.type = _type;
            state.channel = _channel;
        }
        finally {
        }
    }
    // $ANTLR end "ENUM"

    // $ANTLR start "CONTEXT"
    public final void mCONTEXT() throws RecognitionException {
        try {
            int _type = CONTEXT;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // api2mol.g:707:10: ( 'context' )
            // api2mol.g:707:12: 'context'
            {
            match("context"); 


            }

            state.type = _type;
            state.channel = _channel;
        }
        finally {
        }
    }
    // $ANTLR end "CONTEXT"

    // $ANTLR start "DEFAULT_METACLASS"
    public final void mDEFAULT_METACLASS() throws RecognitionException {
        try {
            int _type = DEFAULT_METACLASS;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // api2mol.g:708:19: ( 'defaultMetaclass' )
            // api2mol.g:708:21: 'defaultMetaclass'
            {
            match("defaultMetaclass"); 


            }

            state.type = _type;
            state.channel = _channel;
        }
        finally {
        }
    }
    // $ANTLR end "DEFAULT_METACLASS"

    // $ANTLR start "SLASH"
    public final void mSLASH() throws RecognitionException {
        try {
            int _type = SLASH;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // api2mol.g:711:8: ( '\\u005C' )
            // api2mol.g:711:10: '\\u005C'
            {
            match('\\'); 

            }

            state.type = _type;
            state.channel = _channel;
        }
        finally {
        }
    }
    // $ANTLR end "SLASH"

    // $ANTLR start "COMMA"
    public final void mCOMMA() throws RecognitionException {
        try {
            int _type = COMMA;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // api2mol.g:712:8: ( '\\u002C' )
            // api2mol.g:712:10: '\\u002C'
            {
            match(','); 

            }

            state.type = _type;
            state.channel = _channel;
        }
        finally {
        }
    }
    // $ANTLR end "COMMA"

    // $ANTLR start "SEMI"
    public final void mSEMI() throws RecognitionException {
        try {
            int _type = SEMI;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // api2mol.g:713:8: ( '\\u003B' )
            // api2mol.g:713:10: '\\u003B'
            {
            match(';'); 

            }

            state.type = _type;
            state.channel = _channel;
        }
        finally {
        }
    }
    // $ANTLR end "SEMI"

    // $ANTLR start "COLON"
    public final void mCOLON() throws RecognitionException {
        try {
            int _type = COLON;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // api2mol.g:714:8: ( '\\u003A' )
            // api2mol.g:714:10: '\\u003A'
            {
            match(':'); 

            }

            state.type = _type;
            state.channel = _channel;
        }
        finally {
        }
    }
    // $ANTLR end "COLON"

    // $ANTLR start "LPAREN"
    public final void mLPAREN() throws RecognitionException {
        try {
            int _type = LPAREN;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // api2mol.g:715:8: ( '\\u0028' )
            // api2mol.g:715:10: '\\u0028'
            {
            match('('); 

            }

            state.type = _type;
            state.channel = _channel;
        }
        finally {
        }
    }
    // $ANTLR end "LPAREN"

    // $ANTLR start "RPAREN"
    public final void mRPAREN() throws RecognitionException {
        try {
            int _type = RPAREN;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // api2mol.g:716:8: ( '\\u0029' )
            // api2mol.g:716:10: '\\u0029'
            {
            match(')'); 

            }

            state.type = _type;
            state.channel = _channel;
        }
        finally {
        }
    }
    // $ANTLR end "RPAREN"

    // $ANTLR start "LCURLY"
    public final void mLCURLY() throws RecognitionException {
        try {
            int _type = LCURLY;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // api2mol.g:717:8: ( '\\u007B' )
            // api2mol.g:717:10: '\\u007B'
            {
            match('{'); 

            }

            state.type = _type;
            state.channel = _channel;
        }
        finally {
        }
    }
    // $ANTLR end "LCURLY"

    // $ANTLR start "RCURLY"
    public final void mRCURLY() throws RecognitionException {
        try {
            int _type = RCURLY;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // api2mol.g:718:8: ( '\\u007D' )
            // api2mol.g:718:10: '\\u007D'
            {
            match('}'); 

            }

            state.type = _type;
            state.channel = _channel;
        }
        finally {
        }
    }
    // $ANTLR end "RCURLY"

    // $ANTLR start "DOT"
    public final void mDOT() throws RecognitionException {
        try {
            int _type = DOT;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // api2mol.g:719:8: ( '\\u002E' )
            // api2mol.g:719:10: '\\u002E'
            {
            match('.'); 

            }

            state.type = _type;
            state.channel = _channel;
        }
        finally {
        }
    }
    // $ANTLR end "DOT"

    // $ANTLR start "AT"
    public final void mAT() throws RecognitionException {
        try {
            int _type = AT;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // api2mol.g:720:7: ( '\\u0040' )
            // api2mol.g:720:9: '\\u0040'
            {
            match('@'); 

            }

            state.type = _type;
            state.channel = _channel;
        }
        finally {
        }
    }
    // $ANTLR end "AT"

    // $ANTLR start "ID"
    public final void mID() throws RecognitionException {
        try {
            int _type = ID;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // api2mol.g:721:8: ( ( 'a' .. 'z' | 'A' .. 'Z' | '_' | '*' ) ( 'a' .. 'z' | 'A' .. 'Z' | '0' .. '9' | '_' )* )
            // api2mol.g:721:10: ( 'a' .. 'z' | 'A' .. 'Z' | '_' | '*' ) ( 'a' .. 'z' | 'A' .. 'Z' | '0' .. '9' | '_' )*
            {
            if ( input.LA(1)=='*'||(input.LA(1)>='A' && input.LA(1)<='Z')||input.LA(1)=='_'||(input.LA(1)>='a' && input.LA(1)<='z') ) {
                input.consume();

            }
            else {
                MismatchedSetException mse = new MismatchedSetException(null,input);
                recover(mse);
                throw mse;}

            // api2mol.g:721:44: ( 'a' .. 'z' | 'A' .. 'Z' | '0' .. '9' | '_' )*
            loop1:
            do {
                int alt1=2;
                int LA1_0 = input.LA(1);

                if ( ((LA1_0>='0' && LA1_0<='9')||(LA1_0>='A' && LA1_0<='Z')||LA1_0=='_'||(LA1_0>='a' && LA1_0<='z')) ) {
                    alt1=1;
                }


                switch (alt1) {
            	case 1 :
            	    // api2mol.g:
            	    {
            	    if ( (input.LA(1)>='0' && input.LA(1)<='9')||(input.LA(1)>='A' && input.LA(1)<='Z')||input.LA(1)=='_'||(input.LA(1)>='a' && input.LA(1)<='z') ) {
            	        input.consume();

            	    }
            	    else {
            	        MismatchedSetException mse = new MismatchedSetException(null,input);
            	        recover(mse);
            	        throw mse;}


            	    }
            	    break;

            	default :
            	    break loop1;
                }
            } while (true);


            }

            state.type = _type;
            state.channel = _channel;
        }
        finally {
        }
    }
    // $ANTLR end "ID"

    // $ANTLR start "COMMENT"
    public final void mCOMMENT() throws RecognitionException {
        try {
            int _type = COMMENT;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // api2mol.g:723:11: ( '/*' ( options {greedy=false; } : . )* '*/' )
            // api2mol.g:723:16: '/*' ( options {greedy=false; } : . )* '*/'
            {
            match("/*"); 

            // api2mol.g:723:21: ( options {greedy=false; } : . )*
            loop2:
            do {
                int alt2=2;
                int LA2_0 = input.LA(1);

                if ( (LA2_0=='*') ) {
                    int LA2_1 = input.LA(2);

                    if ( (LA2_1=='/') ) {
                        alt2=2;
                    }
                    else if ( ((LA2_1>='\u0000' && LA2_1<='.')||(LA2_1>='0' && LA2_1<='\uFFFF')) ) {
                        alt2=1;
                    }


                }
                else if ( ((LA2_0>='\u0000' && LA2_0<=')')||(LA2_0>='+' && LA2_0<='\uFFFF')) ) {
                    alt2=1;
                }


                switch (alt2) {
            	case 1 :
            	    // api2mol.g:723:49: .
            	    {
            	    matchAny(); 

            	    }
            	    break;

            	default :
            	    break loop2;
                }
            } while (true);

            match("*/"); 

            _channel=HIDDEN;

            }

            state.type = _type;
            state.channel = _channel;
        }
        finally {
        }
    }
    // $ANTLR end "COMMENT"

    // $ANTLR start "LINE_COMMENT"
    public final void mLINE_COMMENT() throws RecognitionException {
        try {
            int _type = LINE_COMMENT;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // api2mol.g:724:15: ( '--' (~ ( '\\n' | '\\r' ) )* '\\n' )
            // api2mol.g:724:18: '--' (~ ( '\\n' | '\\r' ) )* '\\n'
            {
            match("--"); 

            // api2mol.g:724:23: (~ ( '\\n' | '\\r' ) )*
            loop3:
            do {
                int alt3=2;
                int LA3_0 = input.LA(1);

                if ( ((LA3_0>='\u0000' && LA3_0<='\t')||(LA3_0>='\u000B' && LA3_0<='\f')||(LA3_0>='\u000E' && LA3_0<='\uFFFF')) ) {
                    alt3=1;
                }


                switch (alt3) {
            	case 1 :
            	    // api2mol.g:724:23: ~ ( '\\n' | '\\r' )
            	    {
            	    if ( (input.LA(1)>='\u0000' && input.LA(1)<='\t')||(input.LA(1)>='\u000B' && input.LA(1)<='\f')||(input.LA(1)>='\u000E' && input.LA(1)<='\uFFFF') ) {
            	        input.consume();

            	    }
            	    else {
            	        MismatchedSetException mse = new MismatchedSetException(null,input);
            	        recover(mse);
            	        throw mse;}


            	    }
            	    break;

            	default :
            	    break loop3;
                }
            } while (true);

            match('\n'); 
            _channel=HIDDEN;

            }

            state.type = _type;
            state.channel = _channel;
        }
        finally {
        }
    }
    // $ANTLR end "LINE_COMMENT"

    // $ANTLR start "WS"
    public final void mWS() throws RecognitionException {
        try {
            int _type = WS;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // api2mol.g:725:8: ( ( ' ' | '\\r' | '\\t' | '\\u000C' | '\\n' ) )
            // api2mol.g:725:12: ( ' ' | '\\r' | '\\t' | '\\u000C' | '\\n' )
            {
            if ( (input.LA(1)>='\t' && input.LA(1)<='\n')||(input.LA(1)>='\f' && input.LA(1)<='\r')||input.LA(1)==' ' ) {
                input.consume();

            }
            else {
                MismatchedSetException mse = new MismatchedSetException(null,input);
                recover(mse);
                throw mse;}

            _channel=HIDDEN;

            }

            state.type = _type;
            state.channel = _channel;
        }
        finally {
        }
    }
    // $ANTLR end "WS"

    public void mTokens() throws RecognitionException {
        // api2mol.g:1:8: ( NEW | MULTIPLE | ENUM | CONTEXT | DEFAULT_METACLASS | SLASH | COMMA | SEMI | COLON | LPAREN | RPAREN | LCURLY | RCURLY | DOT | AT | ID | COMMENT | LINE_COMMENT | WS )
        int alt4=19;
        alt4 = dfa4.predict(input);
        switch (alt4) {
            case 1 :
                // api2mol.g:1:10: NEW
                {
                mNEW(); 

                }
                break;
            case 2 :
                // api2mol.g:1:14: MULTIPLE
                {
                mMULTIPLE(); 

                }
                break;
            case 3 :
                // api2mol.g:1:23: ENUM
                {
                mENUM(); 

                }
                break;
            case 4 :
                // api2mol.g:1:28: CONTEXT
                {
                mCONTEXT(); 

                }
                break;
            case 5 :
                // api2mol.g:1:36: DEFAULT_METACLASS
                {
                mDEFAULT_METACLASS(); 

                }
                break;
            case 6 :
                // api2mol.g:1:54: SLASH
                {
                mSLASH(); 

                }
                break;
            case 7 :
                // api2mol.g:1:60: COMMA
                {
                mCOMMA(); 

                }
                break;
            case 8 :
                // api2mol.g:1:66: SEMI
                {
                mSEMI(); 

                }
                break;
            case 9 :
                // api2mol.g:1:71: COLON
                {
                mCOLON(); 

                }
                break;
            case 10 :
                // api2mol.g:1:77: LPAREN
                {
                mLPAREN(); 

                }
                break;
            case 11 :
                // api2mol.g:1:84: RPAREN
                {
                mRPAREN(); 

                }
                break;
            case 12 :
                // api2mol.g:1:91: LCURLY
                {
                mLCURLY(); 

                }
                break;
            case 13 :
                // api2mol.g:1:98: RCURLY
                {
                mRCURLY(); 

                }
                break;
            case 14 :
                // api2mol.g:1:105: DOT
                {
                mDOT(); 

                }
                break;
            case 15 :
                // api2mol.g:1:109: AT
                {
                mAT(); 

                }
                break;
            case 16 :
                // api2mol.g:1:112: ID
                {
                mID(); 

                }
                break;
            case 17 :
                // api2mol.g:1:115: COMMENT
                {
                mCOMMENT(); 

                }
                break;
            case 18 :
                // api2mol.g:1:123: LINE_COMMENT
                {
                mLINE_COMMENT(); 

                }
                break;
            case 19 :
                // api2mol.g:1:136: WS
                {
                mWS(); 

                }
                break;

        }

    }


    protected DFA4 dfa4 = new DFA4(this);
    static final String DFA4_eotS =
        "\1\uffff\5\20\16\uffff\5\20\1\36\4\20\1\uffff\1\20\1\44\3\20\1\uffff"+
        "\6\20\1\56\1\20\1\60\1\uffff\1\20\1\uffff\7\20\1\71\1\uffff";
    static final String DFA4_eofS =
        "\72\uffff";
    static final String DFA4_minS =
        "\1\11\1\145\1\165\1\156\1\157\1\145\16\uffff\1\167\1\154\1\165\1"+
        "\156\1\146\1\60\1\164\1\155\1\164\1\141\1\uffff\1\151\1\60\1\145"+
        "\1\165\1\160\1\uffff\1\170\2\154\2\164\1\145\1\60\1\115\1\60\1\uffff"+
        "\1\145\1\uffff\1\164\1\141\1\143\1\154\1\141\2\163\1\60\1\uffff";
    static final String DFA4_maxS =
        "\1\175\1\145\1\165\1\156\1\157\1\145\16\uffff\1\167\1\154\1\165"+
        "\1\156\1\146\1\172\1\164\1\155\1\164\1\141\1\uffff\1\151\1\172\1"+
        "\145\1\165\1\160\1\uffff\1\170\2\154\2\164\1\145\1\172\1\115\1\172"+
        "\1\uffff\1\145\1\uffff\1\164\1\141\1\143\1\154\1\141\2\163\1\172"+
        "\1\uffff";
    static final String DFA4_acceptS =
        "\6\uffff\1\6\1\7\1\10\1\11\1\12\1\13\1\14\1\15\1\16\1\17\1\20\1"+
        "\21\1\22\1\23\12\uffff\1\1\5\uffff\1\3\11\uffff\1\4\1\uffff\1\2"+
        "\10\uffff\1\5";
    static final String DFA4_specialS =
        "\72\uffff}>";
    static final String[] DFA4_transitionS = {
            "\2\23\1\uffff\2\23\22\uffff\1\23\7\uffff\1\12\1\13\1\20\1\uffff"+
            "\1\7\1\22\1\16\1\21\12\uffff\1\11\1\10\4\uffff\1\17\32\20\1"+
            "\uffff\1\6\2\uffff\1\20\1\uffff\2\20\1\4\1\5\1\3\7\20\1\2\1"+
            "\1\14\20\1\14\1\uffff\1\15",
            "\1\24",
            "\1\25",
            "\1\26",
            "\1\27",
            "\1\30",
            "",
            "",
            "",
            "",
            "",
            "",
            "",
            "",
            "",
            "",
            "",
            "",
            "",
            "",
            "\1\31",
            "\1\32",
            "\1\33",
            "\1\34",
            "\1\35",
            "\12\20\7\uffff\32\20\4\uffff\1\20\1\uffff\32\20",
            "\1\37",
            "\1\40",
            "\1\41",
            "\1\42",
            "",
            "\1\43",
            "\12\20\7\uffff\32\20\4\uffff\1\20\1\uffff\32\20",
            "\1\45",
            "\1\46",
            "\1\47",
            "",
            "\1\50",
            "\1\51",
            "\1\52",
            "\1\53",
            "\1\54",
            "\1\55",
            "\12\20\7\uffff\32\20\4\uffff\1\20\1\uffff\32\20",
            "\1\57",
            "\12\20\7\uffff\32\20\4\uffff\1\20\1\uffff\32\20",
            "",
            "\1\61",
            "",
            "\1\62",
            "\1\63",
            "\1\64",
            "\1\65",
            "\1\66",
            "\1\67",
            "\1\70",
            "\12\20\7\uffff\32\20\4\uffff\1\20\1\uffff\32\20",
            ""
    };

    static final short[] DFA4_eot = DFA.unpackEncodedString(DFA4_eotS);
    static final short[] DFA4_eof = DFA.unpackEncodedString(DFA4_eofS);
    static final char[] DFA4_min = DFA.unpackEncodedStringToUnsignedChars(DFA4_minS);
    static final char[] DFA4_max = DFA.unpackEncodedStringToUnsignedChars(DFA4_maxS);
    static final short[] DFA4_accept = DFA.unpackEncodedString(DFA4_acceptS);
    static final short[] DFA4_special = DFA.unpackEncodedString(DFA4_specialS);
    static final short[][] DFA4_transition;

    static {
        int numStates = DFA4_transitionS.length;
        DFA4_transition = new short[numStates][];
        for (int i=0; i<numStates; i++) {
            DFA4_transition[i] = DFA.unpackEncodedString(DFA4_transitionS[i]);
        }
    }

    class DFA4 extends DFA {

        public DFA4(BaseRecognizer recognizer) {
            this.recognizer = recognizer;
            this.decisionNumber = 4;
            this.eot = DFA4_eot;
            this.eof = DFA4_eof;
            this.min = DFA4_min;
            this.max = DFA4_max;
            this.accept = DFA4_accept;
            this.special = DFA4_special;
            this.transition = DFA4_transition;
        }
        public String getDescription() {
            return "1:1: Tokens : ( NEW | MULTIPLE | ENUM | CONTEXT | DEFAULT_METACLASS | SLASH | COMMA | SEMI | COLON | LPAREN | RPAREN | LCURLY | RCURLY | DOT | AT | ID | COMMENT | LINE_COMMENT | WS );";
        }
    }
 

}