<?xml version="1.0" encoding="UTF-8"?>


<xsl:stylesheet
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
  xmlns:tei="http://www.tei-c.org/ns/1.0"
  xmlns:html="http://www.w3.org/1999/xhtml"
  exclude-result-prefixes="xs xd"
  version="2.0">
  <xd:doc scope="stylesheet">
    <xd:desc>
      <xd:p>
        <xd:b>Created on:</xd:b>
        Nov 7, 2017</xd:p>
      <xd:p>
        <xd:b>Author:</xd:b>
        kst</xd:p>
      <xd:p></xd:p>
    </xd:desc>
  </xd:doc>

  <xsl:param name="mode"/>

  <xsl:template match="tei:TEI">

        <xsl:choose>

          <xsl:when test="$mode = 'list_all'">
            <div class="pers-info" id="pInfo">

              <!-- Get all persons from listPerson -->
              <xsl:for-each select="//tei:listPerson/tei:person">
                <div class="pers-info-entry" id="{./@xml:id}">
                  <h3><xsl:value-of select=".//tei:surname"/>, <xsl:value-of select=".//tei:forename"/></h3>
                  <h5>Spitznamen:</h5>
                  <p><xsl:value-of select=".//tei:addName" separator=", "/></p>
                  <h5>Kategorie:</h5>
                  <p><xsl:value-of select="./@role"/></p>

                  <!-- Do not display GND-infobox if no information is availible -->
                  <xsl:choose>

                    <xsl:when test=".//tei:persName/@ref">
                      <h5>GND:</h5>
                      <h6>
                        <a href="{./tei:persName/@ref}" target="_blank">Link</a>
                      </h6>
                      <div class="GND_entries">

                        <xsl:for-each select=".//tei:note">
                          <div>
                            <p><xsl:value-of select="./text()"/></p>
                          </div>
                        </xsl:for-each>
                      </div>
                    </xsl:when>
                  </xsl:choose>
                </div>
              </xsl:for-each>
            </div>
          </xsl:when>

          <xsl:otherwise>
            <data>
              Wrong mode-parameter!
            </data>
          </xsl:otherwise>
        </xsl:choose>
  </xsl:template>
</xsl:stylesheet>
