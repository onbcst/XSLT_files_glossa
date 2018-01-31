<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:tei="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="xs xd" version="2.0">

  <xsl:output method="xml" indent="yes"/>
  <xd:doc scope="stylesheet">
    <xd:desc>
      <xd:p>
        <xd:b>Created on:</xd:b>
        Nov 13, 2017</xd:p>
      <xd:p>
        <xd:b>Author:</xd:b>
        csteindl</xd:p>
      <xd:p></xd:p>
    </xd:desc>
  </xd:doc>

  <xsl:param name="mode"/>

  <xsl:template match="/">

      <xsl:choose>

        <xsl:when test="starts-with($mode, 'title_')">
          Guter Parameter!
          <xsl:copy-of select="."/>
        </xsl:when>

        <xsl:otherwise>
          <data>
            Wrong mode-parameter!!!!1!
          </data>
        </xsl:otherwise>
      </xsl:choose>
  </xsl:template>
</xsl:stylesheet>
