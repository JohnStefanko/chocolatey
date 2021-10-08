<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:template match="packages">
  <HTML>
  <HEAD>
  <link href="https://fonts.googleapis.com/css?family=Roboto" rel="stylesheet"/>
  <STYLE>
  body {
    font-family: "Roboto", Arial, sans-serif;
    }
  h1 {
  text-align:center;
  }
  table {
    table-layout: fixed;
    font-family: "Roboto", Arial, sans-serif;
    border-collapse: collapse;
    width: 80%;
    margin-left:auto; 
    margin-right:auto;
  }
  th:nth-child(1) {
    width: 20%;
  }
  th:nth-child(2) {
    width: 20%;
  }
  th:nth-child(3) {
    width: 60%;
  }  
  td:nth-child(1) {
    width: 20%;
  }
  td:nth-child(2) {
    width: 20%;
  }
  td:nth-child(3) {
    width: 60%;
  }  
  th {
    text-align: left;
    background-color: gray;
    color: white;
  }
  th, td {
    border: 1px solid lightgray;
    padding: 8px;
  }
  tr:nth-child(odd) {
  background: whitesmoke;
  }
  tr:hover {
  background-color: lightgray;
  }
  </STYLE>
  <TITLE>Chocolatey Installed Packages</TITLE>
  </HEAD>
    <BODY>
    <H1>Chocolatey Installed Packages</H1>
      <TABLE>
        <TR>
          <TH>Title</TH>
          <TH>ID</TH>
          <TH>Summary</TH>
        </TR>
      <xsl:apply-templates select="package">
      <xsl:sort select="@title"/>
      </xsl:apply-templates>
      </TABLE>
    </BODY>
  </HTML>
</xsl:template>
<xsl:template match="package">
  <TR>
    <TD>
      <a><xsl:attribute name="href"><xsl:value-of select="@projecturl"/></xsl:attribute><xsl:value-of select="@title"/></a>
    </TD>
    <TD><xsl:value-of select="@id"/></TD>
    <TD><xsl:value-of select="@summary"/></TD>
  </TR>
</xsl:template>
</xsl:stylesheet>