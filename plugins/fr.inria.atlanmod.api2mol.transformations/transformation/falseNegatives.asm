<?xml version = '1.0' encoding = 'ISO-8859-1' ?>
<asm version="1.0" name="0">
	<cp>
		<constant value="falseNegatives"/>
		<constant value="links"/>
		<constant value="NTransientLinkSet;"/>
		<constant value="col"/>
		<constant value="J"/>
		<constant value="main"/>
		<constant value="A"/>
		<constant value="OclParametrizedType"/>
		<constant value="#native"/>
		<constant value="Collection"/>
		<constant value="J.setName(S):V"/>
		<constant value="OclSimpleType"/>
		<constant value="OclAny"/>
		<constant value="J.setElementType(J):V"/>
		<constant value="TransientLinkSet"/>
		<constant value="A.__matcher__():V"/>
		<constant value="A.__exec__():V"/>
		<constant value="A.mapElements():V"/>
		<constant value="self"/>
		<constant value="__resolve__"/>
		<constant value="1"/>
		<constant value="J.oclIsKindOf(J):B"/>
		<constant value="18"/>
		<constant value="NTransientLinkSet;.getLinkBySourceElement(S):QNTransientLink;"/>
		<constant value="J.oclIsUndefined():B"/>
		<constant value="15"/>
		<constant value="NTransientLink;.getTargetFromSource(J):J"/>
		<constant value="17"/>
		<constant value="30"/>
		<constant value="Sequence"/>
		<constant value="2"/>
		<constant value="A.__resolve__(J):J"/>
		<constant value="QJ.including(J):QJ"/>
		<constant value="QJ.flatten():QJ"/>
		<constant value="e"/>
		<constant value="value"/>
		<constant value="resolveTemp"/>
		<constant value="S"/>
		<constant value="NTransientLink;.getNamedTargetFromSource(JS):J"/>
		<constant value="name"/>
		<constant value="__matcher__"/>
		<constant value="A.__matchemptyClass():V"/>
		<constant value="__exec__"/>
		<constant value="emptyClass"/>
		<constant value="NTransientLinkSet;.getLinksByRule(S):QNTransientLink;"/>
		<constant value="A.__applyemptyClass(NTransientLink;):V"/>
		<constant value="__matchemptyClass"/>
		<constant value="ClassType"/>
		<constant value="REFLECT"/>
		<constant value="IN"/>
		<constant value="MMOF!Classifier;.allInstancesFrom(S):QJ"/>
		<constant value="isMainType"/>
		<constant value="digestFields"/>
		<constant value="J.size():J"/>
		<constant value="0"/>
		<constant value="J.=(J):J"/>
		<constant value="J.and(J):J"/>
		<constant value="B.not():B"/>
		<constant value="37"/>
		<constant value="TransientLink"/>
		<constant value="NTransientLink;.setRule(MATL!Rule;):V"/>
		<constant value="src"/>
		<constant value="NTransientLink;.addSourceElement(SJ):V"/>
		<constant value="tgt"/>
		<constant value="EmptyClass"/>
		<constant value="FN"/>
		<constant value="NTransientLink;.addTargetElement(SJ):V"/>
		<constant value="NTransientLinkSet;.addLink2(NTransientLink;B):V"/>
		<constant value="19:4-19:7"/>
		<constant value="19:4-19:18"/>
		<constant value="19:23-19:26"/>
		<constant value="19:23-19:39"/>
		<constant value="19:23-19:46"/>
		<constant value="19:49-19:50"/>
		<constant value="19:23-19:50"/>
		<constant value="19:4-19:50"/>
		<constant value="22:3-24:4"/>
		<constant value="__applyemptyClass"/>
		<constant value="NTransientLink;"/>
		<constant value="NTransientLink;.getSourceElement(S):J"/>
		<constant value="NTransientLink;.getTargetElement(S):J"/>
		<constant value="3"/>
		<constant value="canonicalName"/>
		<constant value="classTypeName"/>
		<constant value="classType"/>
		<constant value="23:21-23:24"/>
		<constant value="23:21-23:38"/>
		<constant value="23:4-23:38"/>
		<constant value="26:3-26:6"/>
		<constant value="26:20-26:23"/>
		<constant value="26:3-26:24"/>
		<constant value="25:2-27:3"/>
		<constant value="link"/>
		<constant value="mapElements"/>
		<constant value="SpuriousElements"/>
		<constant value="FalseNegativeElement"/>
		<constant value="J.allInstances():J"/>
		<constant value="33:22-33:45"/>
		<constant value="33:22-33:60"/>
		<constant value="33:4-33:60"/>
	</cp>
	<field name="1" type="2"/>
	<field name="3" type="4"/>
	<operation name="5">
		<context type="6"/>
		<parameters>
		</parameters>
		<code>
			<getasm/>
			<push arg="7"/>
			<push arg="8"/>
			<new/>
			<dup/>
			<push arg="9"/>
			<pcall arg="10"/>
			<dup/>
			<push arg="11"/>
			<push arg="8"/>
			<new/>
			<dup/>
			<push arg="12"/>
			<pcall arg="10"/>
			<pcall arg="13"/>
			<set arg="3"/>
			<getasm/>
			<push arg="14"/>
			<push arg="8"/>
			<new/>
			<set arg="1"/>
			<getasm/>
			<pcall arg="15"/>
			<getasm/>
			<pcall arg="16"/>
			<getasm/>
			<pcall arg="17"/>
		</code>
		<linenumbertable>
		</linenumbertable>
		<localvariabletable>
			<lve slot="0" name="18" begin="0" end="26"/>
		</localvariabletable>
	</operation>
	<operation name="19">
		<context type="6"/>
		<parameters>
			<parameter name="20" type="4"/>
		</parameters>
		<code>
			<load arg="20"/>
			<getasm/>
			<get arg="3"/>
			<call arg="21"/>
			<if arg="22"/>
			<getasm/>
			<get arg="1"/>
			<load arg="20"/>
			<call arg="23"/>
			<dup/>
			<call arg="24"/>
			<if arg="25"/>
			<load arg="20"/>
			<call arg="26"/>
			<goto arg="27"/>
			<pop/>
			<load arg="20"/>
			<goto arg="28"/>
			<push arg="29"/>
			<push arg="8"/>
			<new/>
			<load arg="20"/>
			<iterate/>
			<store arg="30"/>
			<getasm/>
			<load arg="30"/>
			<call arg="31"/>
			<call arg="32"/>
			<enditerate/>
			<call arg="33"/>
		</code>
		<linenumbertable>
		</linenumbertable>
		<localvariabletable>
			<lve slot="2" name="34" begin="23" end="27"/>
			<lve slot="0" name="18" begin="0" end="29"/>
			<lve slot="1" name="35" begin="0" end="29"/>
		</localvariabletable>
	</operation>
	<operation name="36">
		<context type="6"/>
		<parameters>
			<parameter name="20" type="4"/>
			<parameter name="30" type="37"/>
		</parameters>
		<code>
			<getasm/>
			<get arg="1"/>
			<load arg="20"/>
			<call arg="23"/>
			<load arg="20"/>
			<load arg="30"/>
			<call arg="38"/>
		</code>
		<linenumbertable>
		</linenumbertable>
		<localvariabletable>
			<lve slot="0" name="18" begin="0" end="6"/>
			<lve slot="1" name="35" begin="0" end="6"/>
			<lve slot="2" name="39" begin="0" end="6"/>
		</localvariabletable>
	</operation>
	<operation name="40">
		<context type="6"/>
		<parameters>
		</parameters>
		<code>
			<getasm/>
			<pcall arg="41"/>
		</code>
		<linenumbertable>
		</linenumbertable>
		<localvariabletable>
			<lve slot="0" name="18" begin="0" end="1"/>
		</localvariabletable>
	</operation>
	<operation name="42">
		<context type="6"/>
		<parameters>
		</parameters>
		<code>
			<getasm/>
			<get arg="1"/>
			<push arg="43"/>
			<call arg="44"/>
			<iterate/>
			<store arg="20"/>
			<getasm/>
			<load arg="20"/>
			<pcall arg="45"/>
			<enditerate/>
		</code>
		<linenumbertable>
		</linenumbertable>
		<localvariabletable>
			<lve slot="1" name="34" begin="5" end="8"/>
			<lve slot="0" name="18" begin="0" end="9"/>
		</localvariabletable>
	</operation>
	<operation name="46">
		<context type="6"/>
		<parameters>
		</parameters>
		<code>
			<push arg="47"/>
			<push arg="48"/>
			<findme/>
			<push arg="49"/>
			<call arg="50"/>
			<iterate/>
			<store arg="20"/>
			<load arg="20"/>
			<get arg="51"/>
			<load arg="20"/>
			<get arg="52"/>
			<call arg="53"/>
			<pushi arg="54"/>
			<call arg="55"/>
			<call arg="56"/>
			<call arg="57"/>
			<if arg="58"/>
			<getasm/>
			<get arg="1"/>
			<push arg="59"/>
			<push arg="8"/>
			<new/>
			<dup/>
			<push arg="43"/>
			<pcall arg="60"/>
			<dup/>
			<push arg="61"/>
			<load arg="20"/>
			<pcall arg="62"/>
			<dup/>
			<push arg="63"/>
			<push arg="64"/>
			<push arg="65"/>
			<new/>
			<pcall arg="66"/>
			<pusht/>
			<pcall arg="67"/>
			<enditerate/>
		</code>
		<linenumbertable>
			<lne id="68" begin="7" end="7"/>
			<lne id="69" begin="7" end="8"/>
			<lne id="70" begin="9" end="9"/>
			<lne id="71" begin="9" end="10"/>
			<lne id="72" begin="9" end="11"/>
			<lne id="73" begin="12" end="12"/>
			<lne id="74" begin="9" end="13"/>
			<lne id="75" begin="7" end="14"/>
			<lne id="76" begin="29" end="34"/>
		</linenumbertable>
		<localvariabletable>
			<lve slot="1" name="61" begin="6" end="36"/>
			<lve slot="0" name="18" begin="0" end="37"/>
		</localvariabletable>
	</operation>
	<operation name="77">
		<context type="6"/>
		<parameters>
			<parameter name="20" type="78"/>
		</parameters>
		<code>
			<load arg="20"/>
			<push arg="61"/>
			<call arg="79"/>
			<store arg="30"/>
			<load arg="20"/>
			<push arg="63"/>
			<call arg="80"/>
			<store arg="81"/>
			<load arg="81"/>
			<dup/>
			<getasm/>
			<load arg="30"/>
			<get arg="82"/>
			<call arg="31"/>
			<set arg="83"/>
			<pop/>
			<load arg="81"/>
			<load arg="30"/>
			<set arg="84"/>
		</code>
		<linenumbertable>
			<lne id="85" begin="11" end="11"/>
			<lne id="86" begin="11" end="12"/>
			<lne id="87" begin="9" end="14"/>
			<lne id="76" begin="8" end="15"/>
			<lne id="88" begin="16" end="16"/>
			<lne id="89" begin="17" end="17"/>
			<lne id="90" begin="16" end="18"/>
			<lne id="91" begin="16" end="18"/>
		</linenumbertable>
		<localvariabletable>
			<lve slot="3" name="63" begin="7" end="18"/>
			<lve slot="2" name="61" begin="3" end="18"/>
			<lve slot="0" name="18" begin="0" end="18"/>
			<lve slot="1" name="92" begin="0" end="18"/>
		</localvariabletable>
	</operation>
	<operation name="93">
		<context type="6"/>
		<parameters>
		</parameters>
		<code>
			<push arg="94"/>
			<push arg="65"/>
			<new/>
			<store arg="20"/>
			<load arg="20"/>
			<dup/>
			<getasm/>
			<push arg="95"/>
			<push arg="65"/>
			<findme/>
			<call arg="96"/>
			<call arg="31"/>
			<set arg="0"/>
			<pop/>
		</code>
		<linenumbertable>
			<lne id="97" begin="7" end="9"/>
			<lne id="98" begin="7" end="10"/>
			<lne id="99" begin="5" end="12"/>
		</linenumbertable>
		<localvariabletable>
			<lve slot="1" name="63" begin="3" end="13"/>
			<lve slot="0" name="18" begin="0" end="13"/>
		</localvariabletable>
	</operation>
</asm>
