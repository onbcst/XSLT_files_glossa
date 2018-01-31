<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs xd"
    version="2.0">
    <xd:doc scope="stylesheet">
        <xd:desc>
            <xd:p><xd:b>Created on:</xd:b> Nov 7, 2017</xd:p>
            <xd:p><xd:b>Author:</xd:b> kst</xd:p>
            <xd:p></xd:p>
        </xd:desc>
    </xd:doc>
    
    <xsl:param name="mode" />
    
    <xsl:template match="//tei:TEI">
        Title <xsl:value-of select="//tei:titleStmt/tei:title"/> (Mode: "<xsl:value-of select="$mode"/>")
    </xsl:template>
</xsl:stylesheet>