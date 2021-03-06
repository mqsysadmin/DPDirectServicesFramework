<?xml version="1.0" encoding="UTF-8"?>
	<!-- *****************************************************************
	*	Copyright 2016 SysInt Pty Ltd (Australia)
	*	
	*	Licensed under the Apache License, Version 2.0 (the "License");
	*	you may not use this file except in compliance with the License.
	*	You may obtain a copy of the License at
	*	
	*	    http://www.apache.org/licenses/LICENSE-2.0
	*	
	*	Unless required by applicable law or agreed to in writing, software
	*	distributed under the License is distributed on an "AS IS" BASIS,
	*	WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
	*	See the License for the specific language governing permissions and
	*	limitations under the License.
	**********************************************************************-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:dp="http://www.datapower.com/extensions"
	xmlns:date="http://exslt.org/dates-and-times" extension-element-prefixes="dp date" version="1.0"
	exclude-result-prefixes="dp date">
	<!--========================================================================
		Purpose:
		Transform the input document with the stylesheet specified in the policy config
				
		History:
		2016-12-12	v1.0	N.A. , Tim Goodwil	Initial Version.
		2018-11-29  v1.1	Brendon Stephens	Include parameter list in transform
		========================================================================-->
	<!--============== Included Stylesheets =========================-->
	<xsl:include href="Utils.xsl"/>
	<!--============== Output Configuration =========================-->
	<xsl:output encoding="UTF-8" method="xml" indent="no" version="1.0"/>
	<!--=============================================================-->
	<!-- MATCH TEMPLATES                                             -->
	<!--=============================================================-->
	<!-- Root Template -->
	<xsl:template match="/">
		<xsl:variable name="SERVICE_METADATA" select="dp:variable($SERVICE_METADATA_CONTEXT_NAME)"/>
		<xsl:variable name="XSLT_LOCATION" select="$SERVICE_METADATA//OperationConfig/Transform[1]/Stylesheet"/>
		<xsl:variable name="PARAMETERS">
			<xsl:apply-templates select="$SERVICE_METADATA//OperationConfig/Transform[1]/ParameterList/Parameter"/>
		</xsl:variable>
		<xsl:copy-of select="dp:transform($XSLT_LOCATION, ., $PARAMETERS)"/>
	</xsl:template>
	<!-- Template to process 'Parameter' in format required for dp:transform -->
	<xsl:template match="Parameter">
		<parameter name="{@name}">
			<xsl:value-of select="@value"/>
		</parameter>
	</xsl:template>
</xsl:stylesheet>
