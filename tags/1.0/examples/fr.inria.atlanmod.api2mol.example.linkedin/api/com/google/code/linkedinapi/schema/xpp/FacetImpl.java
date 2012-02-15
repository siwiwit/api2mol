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

import org.xmlpull.v1.XmlPullParser;
import org.xmlpull.v1.XmlPullParserException;
import org.xmlpull.v1.XmlSerializer;

import com.google.code.linkedinapi.schema.Buckets;
import com.google.code.linkedinapi.schema.Facet;
import com.google.code.linkedinapi.schema.FacetType;

public class FacetImpl
	extends BaseSchemaEntity
    implements Facet
{

    private final static long serialVersionUID = 2461660169443089969L;
    protected String name;
    protected FacetType code;
    protected BucketsImpl buckets;

    public String getName() {
        return name;
    }

    public void setName(String value) {
        this.name = value;
    }

    public FacetType getCode() {
        return code;
    }

    public void setCode(FacetType value) {
        this.code = value;
    }

    public Buckets getBuckets() {
        return buckets;
    }

    public void setBuckets(Buckets value) {
        this.buckets = ((BucketsImpl) value);
    }

	@Override
	public void init(XmlPullParser parser) throws IOException, XmlPullParserException {
        parser.require(XmlPullParser.START_TAG, null, null);

        while (parser.nextTag() == XmlPullParser.START_TAG) {
        	String name = parser.getName();
        	
        	if (name.equals("code")) {
        		setCode(FacetType.fromValue(XppUtils.getElementValueFromNode(parser)));
            } else if (name.equals("name")) {
        		setName(XppUtils.getElementValueFromNode(parser));
            } else if (name.equals("buckets")) {
    			BucketsImpl buckets = new BucketsImpl();
    			buckets.init(parser);
    			setBuckets(buckets);
            } else {
                // Consume something we don't understand.
            	LOG.warning("Found tag that we don't recognize: " + name);
            	XppUtils.skipSubTree(parser);
            }
        }
	}

	@Override
	public void toXml(XmlSerializer serializer) throws IOException {
		XmlSerializer element = serializer.startTag(null, "facet");
		XppUtils.setElementValueToNode(element, "name", getName());
		XppUtils.setElementValueToNode(element, "code", getCode().value());
		if (getBuckets() != null) {
			((BucketsImpl) getBuckets()).toXml(serializer);
		}
		serializer.endTag(null, "facet");
	}
}
