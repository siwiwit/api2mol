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

package com.google.code.linkedinapi.schema.impl;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;
import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlAttribute;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlType;
import javax.xml.bind.annotation.adapters.XmlJavaTypeAdapter;
import com.google.code.linkedinapi.schema.Adapter1;
import com.google.code.linkedinapi.schema.Connections;
import com.google.code.linkedinapi.schema.Person;

@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "", propOrder = {
    "personList"
})
@XmlRootElement(name = "connections")
public class ConnectionsImpl
    implements Serializable, Connections
{

    private final static long serialVersionUID = 2461660169443089969L;
    @XmlElement(name = "person", type = PersonImpl.class)
    protected List<Person> personList;
    @XmlAttribute
    @XmlJavaTypeAdapter(Adapter1 .class)
    protected Long count;
    @XmlAttribute
    @XmlJavaTypeAdapter(Adapter1 .class)
    protected Long start;
    @XmlAttribute(required = true)
    @XmlJavaTypeAdapter(Adapter1 .class)
    protected Long total;

    public List<Person> getPersonList() {
        if (personList == null) {
            personList = new ArrayList<Person>();
        }
        return this.personList;
    }

    public Long getCount() {
        return count;
    }

    public void setCount(Long value) {
        this.count = value;
    }

    public Long getStart() {
        return start;
    }

    public void setStart(Long value) {
        this.start = value;
    }

    public Long getTotal() {
        return total;
    }

    public void setTotal(Long value) {
        this.total = value;
    }

}
