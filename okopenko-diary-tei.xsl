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

  <xsl:variable name="date">e<xsl:value-of select="substring-after($mode, '_')"/></xsl:variable>
  <xsl:variable name="page"><xsl:value-of select="substring-after($mode, '_')"/></xsl:variable>

  <xsl:variable name="img_url_entry" select="//tei:div[@type='entry' and @xml:id=$date]/preceding::tei:pb[1]/@facs"/>
  <xsl:variable name="img_url_page" select="//tei:pb[@n=$page]/@facs"/>

  <xsl:variable name="barcode" select="substring-before((//tei:pb)[1]/@facs, '\')"></xsl:variable>

  <xsl:variable name="previous_page" select="//tei:pb[@n=$page]/preceding::tei:pb[1]/@n"/>
  <xsl:variable name="next_page" select="//tei:pb[@n=$page]/following::tei:pb[1]/@n"/>

  <xsl:param name="start">5</xsl:param>
  <xsl:param name="end">6</xsl:param>

  <xsl:template match="//tei:TEI">
    <response>

      <xsl:choose>

        <xsl:when test="starts-with($mode, 'title_')">
          <data>
            <h1>Title: "<xsl:value-of select="//tei:titleStmt/tei:title"/>"</h1>
          </data>
        </xsl:when>

        <xsl:when test="starts-with($mode, 'face_')">
          <img_url>https://fue.onb.ac.at/okopenko/+<xsl:value-of select="replace($img_url_entry, '\\', '/')"/></img_url>
          <manifest>/iiif/+<xsl:value-of select="replace($img_url_entry, '\\', '/')"/>/info.json</manifest>
          <data>https://fue.onb.ac.at/okopenko/+<xsl:value-of select="replace($img_url_entry, '\\', '/')"/></data>
        </xsl:when>

        <xsl:when test="starts-with($mode, 'facp_')">
          <img_url>https://fue.onb.ac.at/okopenko/+<xsl:value-of select="replace($img_url_page, '\\', '/')"/></img_url>
          <manifest>/iiif/+<xsl:value-of select="replace($img_url_page, '\\', '/')"/>/info.json</manifest>
          <data>https://fue.onb.ac.at/okopenko/+<xsl:value-of select="replace($img_url_page, '\\', '/')"/></data>
        </xsl:when>

        <xsl:when test="starts-with($mode, 'xml_')">
          <data>
            <p>XML</p>
          </data>
        </xsl:when>

        <xsl:when test="starts-with($mode, 'rea_')">
          <data>
            <p><xsl:value-of select="//tei:div[@type='entry' and @xml:id=$date]/*/text()"/></p>
          </data>
        </xsl:when>

        <xsl:when test="starts-with($mode, 'tra_')">
          <data>
            <p>Diplomatische Umschrift</p>
          </data>
        </xsl:when>

        <xsl:when test="starts-with($mode, 'com_')">
          <data>
            <p>Kommentar</p>
          </data>
        </xsl:when>

        <xsl:when test="starts-with($mode, 'entry_')">
          <title><xsl:value-of select="//tei:titleStmt/tei:title"/></title>
          <rea><xsl:value-of select="//tei:div[@type='entry' and @xml:id=$date]/*/text()"/></rea>
          <tra>Diplomatische Umschrift</tra>
          <com>Kommentar</com>
          <img_url>https://fue.onb.ac.at/okopenko/+<xsl:value-of select="replace($img_url_entry, '\\', '/')"/></img_url>
          <manifest>/iiif/+<xsl:value-of select="replace($img_url_entry, '\\', '/')"/>/info.json</manifest>
          <data>https://fue.onb.ac.at/okopenko/+<xsl:value-of select="replace($img_url_entry, '\\', '/')"/></data>

          <!-- Get previous and next entry in TEI document -->
          <!-- Remove leading "e" character and replace "-" with "/" to match flask url scheme -->
          <previous><xsl:value-of select="replace(substring(//tei:div[@type='entry' and @xml:id=$date]/preceding-sibling::tei:div[@type='entry'][1]/@xml:id, 2), '-', '/')"/></previous>
          <next><xsl:value-of select="replace(substring(//tei:div[@type='entry' and @xml:id=$date]/following-sibling::tei:div[@type='entry'][1]/@xml:id, 2), '-', '/')"/></next>

          <!-- Get raw xml version of the current entry -->
          <raw_xml><xsl:copy-of select="//tei:div[@type='entry' and @xml:id=$date]"/></raw_xml>
          <!-- Get barcode and current page -->
          <barcode>+<xsl:value-of select="$barcode"/></barcode>
          <current_page><xsl:value-of select="//tei:div[@type='entry' and @xml:id=$date]/preceding::tei:pb[1]/@n"/></current_page>
        </xsl:when>

        <xsl:when test="starts-with($mode, 'page_')">
          <title><xsl:value-of select="//tei:titleStmt/tei:title"/></title>
          <rea><xsl:value-of select="//tei:pb[@n=$page+1]/preceding::node()[count(.|//tei:pb[@n=$page]/following::node()) = count(//tei:pb[@n=$page]/following::node())]/text()"/></rea>
          <tra>Diplomatische Umschrift in Arbeit</tra>
          <com>Kommentar</com>
          <img_url>https://fue.onb.ac.at/okopenko/+<xsl:value-of select="replace($img_url_page, '\\', '/')"/></img_url>
          <manifest>/iiif/+<xsl:value-of select="replace($img_url_page, '\\', '/')"/>/info.json</manifest>
          <data>https://fue.onb.ac.at/okopenko/+<xsl:value-of select="replace($img_url_page, '\\', '/')"/></data>

          <!-- Get previous and next page-number in TEI document -->
          <previous><xsl:value-of select="$previous_page"/></previous>
          <next><xsl:value-of select="$next_page"/></next>

          <!-- Get raw xml version of the current page -->
          <raw_xml><xsl:apply-templates mode="page_xml"></xsl:apply-templates></raw_xml>
          <!-- Get barcode and current page -->
          <barcode>+<xsl:value-of select="$barcode"/></barcode>
          <current_page><xsl:value-of select="//tei:pb[@n=$page]/@n"/></current_page>
        </xsl:when>

        <xsl:otherwise>
          <data>
            Wrong mode-parameter!
          </data>
        </xsl:otherwise>
      </xsl:choose>
    </response>
  </xsl:template>

    <xsl:template match="tei:pb" mode="page_xml">
        <xsl:if test="@n = $page">
            <xsl:copy-of select="."/>
        </xsl:if>
    </xsl:template>

    <xsl:template match="text()" mode="page_xml">
        <xsl:choose>
            <xsl:when test="preceding::tei:pb[@n = $next_page]"> </xsl:when>
            <xsl:when test="following::tei:pb[@n = $page]"> </xsl:when>
            <xsl:otherwise>
                <xsl:copy-of select="."/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="*" mode="page_xml">
        <xsl:choose>
            <xsl:when test=".//tei:pb[@n = $page or @n = $next_page]">
                <xsl:copy>
                    <xsl:copy-of select="@*"/>
                    <xsl:apply-templates mode="page_xml"/>
                </xsl:copy>
            </xsl:when>
            <xsl:when
                test="
                following::tei:pb[@n = $next_page] and
                preceding::tei:pb[@n = $page]">
                <xsl:copy-of select="."/>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
</xsl:stylesheet>
