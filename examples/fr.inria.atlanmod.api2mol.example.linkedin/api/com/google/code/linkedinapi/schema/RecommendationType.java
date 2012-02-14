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

package com.google.code.linkedinapi.schema;

import javax.xml.bind.annotation.XmlEnum;


/**
 * <p>Java class for null.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * <p>
 * <pre>
 * &lt;simpleType>
 *   &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string">
 *     &lt;enumeration value="COLLEAGUE"/>
 *     &lt;enumeration value="BUSINESS_PARTNER"/>
 *     &lt;enumeration value="SERVICE_PROVIDER"/>
 *     &lt;enumeration value="STUDENT"/>
 *     &lt;enumeration value="EDUCATION"/>
 *   &lt;/restriction>
 * &lt;/simpleType>
 * </pre>
 * 
 */
@XmlEnum
public enum RecommendationType {

    COLLEAGUE,
    BUSINESS_PARTNER,
    SERVICE_PROVIDER,
    STUDENT,
    EDUCATION;

    public String value() {
        return name();
    }

    public static RecommendationType fromValue(String v) {
        return valueOf(v);
    }

}
