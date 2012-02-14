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



/**
 * <p>Java class for anonymous complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType>
 *   &lt;complexContent>
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       &lt;sequence>
 *         &lt;element ref="{}id"/>
 *         &lt;element ref="{}position"/>
 *         &lt;element ref="{}company"/>
 *         &lt;element ref="{}job-poster"/>
 *         &lt;element ref="{}site-job-request"/>
 *       &lt;/sequence>
 *     &lt;/restriction>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 * 
 * 
 */
public interface Job
    extends SchemaEntity
{


    /**
     * Gets the value of the id property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    String getId();

    /**
     * Sets the value of the id property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    void setId(String value);

    /**
     * Gets the value of the position property.
     * 
     * @return
     *     possible object is
     *     {@link Position }
     *     
     */
    Position getPosition();

    /**
     * Sets the value of the position property.
     * 
     * @param value
     *     allowed object is
     *     {@link Position }
     *     
     */
    void setPosition(Position value);

    /**
     * Gets the value of the company property.
     * 
     * @return
     *     possible object is
     *     {@link Company }
     *     
     */
    Company getCompany();

    /**
     * Sets the value of the company property.
     * 
     * @param value
     *     allowed object is
     *     {@link Company }
     *     
     */
    void setCompany(Company value);

    /**
     * Gets the value of the jobPoster property.
     * 
     * @return
     *     possible object is
     *     {@link JobPoster }
     *     
     */
    JobPoster getJobPoster();

    /**
     * Sets the value of the jobPoster property.
     * 
     * @param value
     *     allowed object is
     *     {@link JobPoster }
     *     
     */
    void setJobPoster(JobPoster value);

    /**
     * Gets the value of the siteJobRequest property.
     * 
     * @return
     *     possible object is
     *     {@link SiteJobRequest }
     *     
     */
    SiteJobRequest getSiteJobRequest();

    /**
     * Sets the value of the siteJobRequest property.
     * 
     * @param value
     *     allowed object is
     *     {@link SiteJobRequest }
     *     
     */
    void setSiteJobRequest(SiteJobRequest value);

}
