# API2MoL #

A software asset enables access to its internal functionality through an Application Programming Interface (API) that describes the set of public services offered by the software. Given the importance of the API concept in software engineering, we need mechanisms to integrate APIs in Model-Driven Engineering (MDE), for instance, as part of software modernization or code-generation scenarios. However, in current approaches integration is done by hardcoding glue code directly in the MDE application.

Our generic solution API2MoL is a Domain Specific Language specially designed to integrate APIs into MDE. With API2MoL, developers can define the mappings between an API and a metamodel (i.e. mappings between API classes and metamodel elements). It is also possible to automatically create a metamodel definition directly from the API information if not existing metamodel is already available. These mappings can then be used to anytime we need to bridge the gap between software and models. For instance, we can create complete models from running applications or create complete software artifacts from models, where complete, in both examples, refers to the fact that the model/software will include all the necessary calls to the APIs used by the software.

<img width='500' src='http://svn.codespot.com/a/eclipselabs.org/api2mol/wiki/api2mol.png'>


This is the new site for the DSL, the previous one (<a href='http://modelum.es/api2mol'>http://modelum.es/api2mol</a>) is no longer updated.<br>
<br>
You can find the paper about API2MoL <a href='http://hal.inria.fr/hal-00642154/'>here</a>

<h1>Features</h1>

<ul><li>Language specially tailored to extract and inject models from APIs by  means of a mapping definition<br>
</li><li>Bidireccional mapping<br>
</li><li>Bootstrap process for automatically obtaining the API metamodel<br>
</li><li>Java-based APIs<br>
</li><li>Extraction and injection of in-memory run-time Java objects</li></ul>

<h1>Authors</h1>

API2MoL was developed as a collaboration between Atlanmod and Modelum research groups.<br>
<br>
<a href='http://www.emn.fr/z-info/atlanmod/index.php/Main_Page'><img src='https://svn.codespot.com/a/eclipselabs.org/emftocsp/wiki/LogoAtlanmod135px.png' /></a>

<a href='http://modelum.es'><img src='http://svn.codespot.com/a/eclipselabs.org/api2mol/wiki/modelum.gif' /></a>