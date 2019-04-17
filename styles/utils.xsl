<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
  version="1.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xalan="http://xml.apache.org/xalan" 
  >

	<xsl:output method="html" indent="yes" omit-xml-declaration="yes" encoding="UTF-8" />
  
	<xsl:variable name="spacechar" select="'&#10;'"/>

  	<xsl:template name="replace-newline-with-pagebreak">
	  	<xsl:param name="text" select="''"/>
  		<xsl:call-template name="string-replace-all">
			<xsl:with-param name="text" select="$text"/>
        	<xsl:with-param name="replace" select="$spacechar"/>
    		<xsl:with-param name="by"><xsl:text>&lt;br/&gt;</xsl:text></xsl:with-param>
		</xsl:call-template>
  	</xsl:template>

  	<xsl:template name="string-replace-all">
   		<xsl:param name="text"/>
   		<xsl:param name="replace"/>
   		<xsl:param name="by"/>
   		<xsl:choose>
     		<xsl:when test="contains($text,$replace)">
       			<xsl:value-of select="substring-before($text,$replace)"/>
       			<xsl:value-of select="$by" disable-output-escaping="yes"/>
       			<xsl:call-template name="string-replace-all">
         			<xsl:with-param name="text" select="substring-after($text,$replace)"/>
         			<xsl:with-param name="replace" select="$replace"/>
         			<xsl:with-param name="by" select="$by"/>
       			</xsl:call-template>
     		</xsl:when>
     		<xsl:otherwise>
       			<xsl:value-of select="$text"/>
     		</xsl:otherwise>
   		</xsl:choose>
	</xsl:template>

	<xsl:template name="format-datetime-for-display">
		<xsl:param name="yyyyMMdd"/>
		<xsl:param name="time"/>
		<xsl:variable name="year" select="substring($yyyyMMdd, 1, 4)"/>
		<xsl:variable name="month" select="substring($yyyyMMdd, 5, 2)"/>
		<xsl:variable name="date" select="substring($yyyyMMdd, 7, 2)"/>
		<xsl:variable name="time-formatted" select="concat(substring($time, 1, 2),':',substring($time, 3, 2))"/>
		<xsl:value-of select="concat($date, '/', $month, '/', $year,'  ',$time-formatted)"/>
	</xsl:template>

</xsl:stylesheet>