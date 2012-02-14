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
import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlType;
import com.google.code.linkedinapi.schema.Network;
import com.google.code.linkedinapi.schema.NetworkStats;
import com.google.code.linkedinapi.schema.Updates;

@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "", propOrder = {
    "networkStats",
    "updates"
})
@XmlRootElement(name = "network")
public class NetworkImpl
    implements Serializable, Network
{

    private final static long serialVersionUID = 2461660169443089969L;
    @XmlElement(name = "network-stats", required = true, type = NetworkStatsImpl.class)
    protected NetworkStatsImpl networkStats;
    @XmlElement(required = true, type = UpdatesImpl.class)
    protected UpdatesImpl updates;

    public NetworkStats getNetworkStats() {
        return networkStats;
    }

    public void setNetworkStats(NetworkStats value) {
        this.networkStats = ((NetworkStatsImpl) value);
    }

    public Updates getUpdates() {
        return updates;
    }

    public void setUpdates(Updates value) {
        this.updates = ((UpdatesImpl) value);
    }

}
