<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:tei="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="xs xd" version="2.0">

  <xsl:output method="html" omit-xml-declaration="yes" version="1.0" encoding="UTF-8" indent="yes"/>

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

  <xsl:variable name="date">e<xsl:value-of select="substring-after($mode, '_')"/></xsl:variable>

  <xsl:variable name="url" select="//tei:div[@type='entry' and @xml:id=$date]/preceding::tei:pb[1]/@facs"/>

  <xsl:template match="//tei:TEI">
    <response>

      <xsl:choose>

        <xsl:when test="contains($mode, 'title')">
          <data>
            <h1>Title: "<xsl:value-of select="//tei:titleStmt/tei:title"/>"</h1>
          </data>
        </xsl:when>

        <xsl:when test="contains($mode, 'fac')">
          <img_url>https://fue.onb.ac.at/okopenko/+<xsl:value-of select="replace($url, '\\', '/')"/></img_url>
          <manifest>/manifest/+<xsl:value-of select="replace($url, '\\', '/')"/>/info.json</manifest>
          <data>https://fue.onb.ac.at/okopenko/+<xsl:value-of select="replace($url, '\\', '/')"/></data>
        </xsl:when>

        <xsl:when test="contains($mode, 'xml')">
          <data>
            <p>XML</p>
          </data>
        </xsl:when>

        <xsl:when test="contains($mode, 'rea')">
          <data>
            <p><xsl:value-of select="//tei:div[@type='entry' and @xml:id=$date]/*/text()"/></p>
          </data>
        </xsl:when>

        <xsl:when test="contains($mode, 'tra')">
          <data>
            <p>Diplomatische Umschrift</p>
          </data>
        </xsl:when>

        <xsl:when test="contains($mode, 'com')">
          <data>
            <p>Kommentar</p>
          </data>
        </xsl:when>

        <xsl:when test="contains($mode, 'all')">
          <title><xsl:value-of select="//tei:titleStmt/tei:title"/></title>
          <rea><xsl:value-of select="//tei:div[@type='entry' and @xml:id=$date]/*/text()"/></rea>
          <tra>Diplomatische Umschrift</tra>
          <com>Kommentar</com>
          <img_url>https://fue.onb.ac.at/okopenko/+<xsl:value-of select="replace($url, '\\', '/')"/></img_url>
          <manifest>/manifest/+<xsl:value-of select="replace($url, '\\', '/')"/>/info.json</manifest>
          <data>https://fue.onb.ac.at/okopenko/+<xsl:value-of select="replace($url, '\\', '/')"/></data>
          <!-- Remove leading "e" character and replace "-" with "/" to match flask url scheme -->
          <next_entry><xsl:value-of select="replace(substring(//tei:div[@type='entry' and @xml:id=$date]/following-sibling::tei:div[@type='entry'][1]/@xml:id, 2), '-', '/')"/></next_entry>
          <prev_entry><xsl:value-of select="replace(substring(//tei:div[@type='entry' and @xml:id=$date]/preceding-sibling::tei:div[@type='entry'][1]/@xml:id, 2), '-', '/')"/></prev_entry>
          <raw_xml><xsl:copy-of select="//tei:div[@type='entry' and @xml:id=$date]"/></raw_xml>
        </xsl:when>

        <xsl:otherwise>
          <data>
            Falscher mode Parameter!
          </data>
        </xsl:otherwise>
      </xsl:choose>
    </response>
  </xsl:template>
</xsl:stylesheet>
