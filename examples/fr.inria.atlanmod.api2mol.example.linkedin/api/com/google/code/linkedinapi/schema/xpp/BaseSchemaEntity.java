/*
 * Copyright 2010 Nabeel Mukhtar 
 * 
 * Licensed under the Apache License, Version 2.0 (the "License"); 
 * you may not use this file except in compliance with the License. 
 * You may obtain a copy of the License at 
 * 
 *  http://www.apache.org/licenses/LICENSE-2.0
 * 
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. 
 * See the License for the specific language governing permissions and
 * limitations under the License. 
 * 
 */
package com.google.code.linkedinapi.schema.xpp;

import java.io.IOException;
import java.io.Serializable;
import java.util.logging.Logger;

import org.xmlpull.v1.XmlPullParser;
import org.xmlpull.v1.XmlPullParserException;
import org.xmlpull.v1.XmlSerializer;

/**
 * The Class BaseSchemaEntity.
 * 
 * @author Nabeel Mukhtar
 */
public abstract class BaseSchemaEntity implements Serializable {
	
    protected final Logger LOG = Logger.getLogger(getClass().getCanonicalName());

	/**
	 * 
	 */
	private static final long serialVersionUID = 4249791194912997698L;

	/**
	 * To xml.
	 * 
	 * @param serializer the document
	 * @throws IOException TODO
	 */
	public abstract void toXml(XmlSerializer serializer) throws IOException;
	
	/**
	 * Inits the.
	 * 
	 * @param parser the element
	 * @throws IOException TODO
	 * @throws XmlPullParserException TODO
	 */
	public abstract void init(XmlPullParser parser) throws IOException, XmlPullParserException;
	
	
}
