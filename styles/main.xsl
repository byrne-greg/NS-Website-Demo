<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
  version="1.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xalan="http://xml.apache.org/xalan" 
  xmlns:redirect="http://xml.apache.org/xalan/redirect"
  exclude-result-prefixes="str"
  extension-element-prefixes="redirect">

  <xsl:output method="html" indent="yes" omit-xml-declaration="yes" encoding="UTF-8" />

  <xsl:strip-space elements="*"/>
  
  <xsl:param name="data-dir" select="'data'" />
  <xsl:param name="web-dir" select="'web'"/>
   
  <xsl:import href="utils.xsl"/>

  <xsl:variable name="info-file" select="concat($data-dir,'/school_info.xml')"/>  
  <xsl:variable name="info-doc" select="document($info-file)"/>
  <xsl:variable name="info" select="$info-doc/SCHOOL_INFO"/>

  <xsl:variable name="news-file" select="concat($data-dir,'/school_news.xml')"/>  
  <xsl:variable name="news-doc" select="document($news-file)"/>
  <xsl:variable name="news-items" select="$news-doc/SCHOOL_NEWS/NEWS/NEWS-ITEM"/>
  <xsl:variable name="headline-news-items-allowed" select="3"/>

  <xsl:variable name="history-file" select="concat($data-dir,'/school_history.xml')"/>  
  <xsl:variable name="history-doc" select="document($history-file)"/>
  <xsl:variable name="history" select="$history-doc/SCHOOL_HISTORY"/>
  
  <xsl:variable name="policies-file" select="concat($data-dir,'/school_policies.xml')"/>  
  <xsl:variable name="policies-doc" select="document($policies-file)"/>
  <xsl:variable name="policies" select="$policies-doc/SCHOOL_POLICIES"/>

  <xsl:variable name="calendar-file" select="concat($data-dir,'/school_calendar.xml')"/>  
  <xsl:variable name="calendar-doc" select="document($calendar-file)"/>
  <xsl:variable name="calendar" select="$calendar-doc/SCHOOL_CALENDARS"/>

  <xsl:variable name="members-file" select="concat($data-dir,'/school_members.xml')"/>  
  <xsl:variable name="members-doc" select="document($members-file)"/>
  <xsl:variable name="members" select="$members-doc/SCHOOL_MEMBERS"/>

  <xsl:variable name="properties" select="MAIN/PROPERTIES"/>
  <xsl:variable name="schoolprop" select="$info/SCHOOL"/>
  <xsl:variable name="school-name" select="$schoolprop/@name"/>
  <xsl:variable name="school-add1" select="$schoolprop/@address1"/>

  <xsl:template match="MAIN">
  	<xsl:call-template name="create-index-page"/>
  	<xsl:call-template name="create-news-page"/>
  	<xsl:call-template name="create-history-page"/>
  	<xsl:call-template name="create-staff-page"/>
  	<xsl:call-template name="create-policies-page"/>
  	<xsl:call-template name="create-calendar-page"/>
  </xsl:template>

  <xsl:template name="html-header">
     <xsl:comment>This page is generated from a build process</xsl:comment>
     <head>
      <meta charset="UTF-8"/>
      <meta name="viewport" content="width=device-width, initial-scale=1"/>
      <meta name="author" content="Greg Byrne - https://www.linkedin.com/in/byrne-greg/"/>
      <meta name="description" content="Sample page for a national school"/>
      <meta name="google-site-verification" content="mcg3-kPe_nOSRpxx0wW6VzzS3RUkEIbXiUSzGt5v3k4" />
      <title><xsl:value-of select="$school-name"/> - <xsl:value-of select="$school-add1"/></title>
      <link rel="shortcut icon" type="image/png" href="icons/favicon.png"/>
      <link href="https://fonts.googleapis.com/css?family=Stint+Ultra+Expanded" rel="stylesheet" type="text/css"/>
      <link href="https://fonts.googleapis.com/css?family=Roboto" rel="stylesheet" type="text/css"/>
      <link href="css/ns.css" rel="stylesheet" type="text/css" />
      <script src="https://code.jquery.com/jquery-3.3.1.min.js" integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8=" crossorigin="anonymous"></script>
      <script src="js/ns.js"></script>
    </head>
  </xsl:template>

  <xsl:template name="create-index-page">
  	<html lang="en">
			<xsl:call-template name="html-header"/>
	  		<body>
				<xsl:call-template name="sidenav-bar"/>
				<div class="index_grid">
					<xsl:call-template name="create-navigation-banner"/>
					<xsl:call-template name="create-display-banner"/>
					<xsl:call-template name="create-about-banner"/>	
					<xsl:call-template name="create-headline-news"/>
					<xsl:call-template name="create-facebook-feed"/>
					<xsl:call-template name="create-contact-banner"/>
					<xsl:call-template name="create-footer"/>
				</div>
  			</body>
		</html>
	</xsl:template>

  <xsl:template name="sidenav-bar">
    <!-- Scrim div used to allow click anywhere close -->
    <div class="scrim" onclick="closeNav()" style="opacity: 0; pointer-events: none;"></div>
    <div class="sidenav" onclick="closeNav()">
      <div class="sidenav_linkcontainer">
        <a href="index.html">Home</a>
        <a href="news.html">News</a>
        <a href="staff.html">Staff &amp; B.O.M</a>
        <a href="policies.html">Policies</a>
        <a href="calendar.html">Calendar</a>
        <a href="history.html">History</a>
        <a href="index.html#contact">Contact</a>
      </div>
    </div>
  </xsl:template>

  <xsl:template name="create-navigation-banner">
      <div id="navigation_banner">
      <div class="navigation_sidenav_toggle" onclick="openNav()">
        <div class="navigation_sidenav_toggle_bar"></div>
        <div class="navigation_sidenav_toggle_bar"></div>
        <div class="navigation_sidenav_toggle_bar"></div>
      </div>
      <div class="navigation_text banner_font">
        <xsl:value-of select="$school-name"/>, <xsl:value-of select="$school-add1"/>
      </div>
    </div>   
  </xsl:template>

    <xsl:template name="create-display-banner">
      <div id="display_banner">
        <div class="display_banner_text_container">
          <div class="display_banner_text banner_font">
            <h1><xsl:value-of select="$school-name"/></h1>
            <h2><xsl:value-of select="$school-add1"/>, <xsl:value-of select="$schoolprop/@address2"/>, <xsl:value-of select="$schoolprop/@address3"/></h2>
          </div>
        </div>
        <div class="display_banner_image parallax"/>
      </div>
    </xsl:template>

    <xsl:template name="create-about-banner">
      <div id="about_banner" class="grid-item-padding">
        <div class="about_banner_container about_banner_image parallax">
          <div class="about_banner_info_bubbles">
              <xsl:call-template name="create-info-bubble">
                <xsl:with-param name="info-bubble-title" select="'Students'"/>
                <xsl:with-param name="info-bubble-id" select="'info_bubble_student'"/>
                <xsl:with-param name="info-bubble-counter-value" select="$schoolprop/@pupilCount"/>
              </xsl:call-template>
              <xsl:call-template name="create-info-bubble">
                <xsl:with-param name="info-bubble-title" select="'Teachers'"/>
                <xsl:with-param name="info-bubble-id" select="'info_bubble_teacher'"/>
                <xsl:with-param name="info-bubble-counter-value" select="$schoolprop/@teacherCount"/>
              </xsl:call-template>
              <xsl:call-template name="create-info-bubble">
                <xsl:with-param name="info-bubble-title" select="'Special Education Teachers'"/>
                <xsl:with-param name="info-bubble-id" select="'info_bubble_sna'"/>
                <xsl:with-param name="info-bubble-counter-value" select="$schoolprop/@sntCount"/>
              </xsl:call-template>       
          </div>
        </div>
      </div>  
    </xsl:template>

    <xsl:template name="create-info-bubble">
      <xsl:param name="info-bubble-title" select="''"/>
      <xsl:param name="info-bubble-id" select="''"/>
      <xsl:param name="info-bubble-counter-value" select="''"/>
      <div class="about_banner_info_bubble_container">
        <div class="about_banner_info_bubble-title title_font"><xsl:value-of select="$info-bubble-title"/></div>
        <div class="about_banner_info_bubble" id="{$info-bubble-id}">
          <span class="about_banner_info_bubble_counter_value title_font"><xsl:value-of select="$info-bubble-counter-value"/></span>
        </div>
      </div>
    </xsl:template>

    <xsl:template name="create-headline-news">
      <div id="headline_news" class="grid-item-padding">
      <div class="headline_news_title title_font">
        <h2>School News</h2>
      </div>
      <div class="headline_newsitem_container">
        <xsl:call-template name="create-news-items">
          <xsl:with-param name="news-items-allowed" select="$headline-news-items-allowed"/>
        </xsl:call-template>
      </div>
      <button class="headline_news_button_morenews title_font" onclick="location.href='news.html';">More News</button>
    </div>
    </xsl:template>

    <xsl:template name="create-news-items">
      <xsl:param name="news-items-allowed" select="100"/>
      <xsl:for-each select="$news-items">
        <xsl:sort select="@yyyyMMdd" order="descending"/>
        <xsl:sort select="@time" order="descending"/>
        <xsl:if test="position() &lt; ($news-items-allowed+1)">
          <div class="news_item">
            <div class="news_item_date">
              <xsl:call-template name="format-datetime-for-display">
                <xsl:with-param name="yyyyMMdd" select="@yyyyMMdd"/>
                <xsl:with-param name="time" select="@time"/>
              </xsl:call-template>
            </div>
            <div class="news_item_title title_font"><xsl:value-of select="title/text()"/></div>
            <div class="news_item_text text_font">
              <xsl:variable name="news-item-text">
                <xsl:call-template name="replace-newline-with-pagebreak">
                  <xsl:with-param name="text" select="content/text()"/>
                </xsl:call-template>
              </xsl:variable>
              <xsl:value-of select="$news-item-text" disable-output-escaping="yes"/>
            </div> 
          </div>
        </xsl:if>
      </xsl:for-each>
    </xsl:template>

    <xsl:template name="create-facebook-feed">
      <div id="facebook_feed" class="grid-item-padding">
        <div class="facebook_feed_container">
         <xsl:variable name="facebook-feed-link" select="$properties/FACEBOOK/@feedLink"/>
         <iframe id="fb-feed" src="{$facebook-feed-link}" width="340" height="500" style="border:none;overflow:hidden" scrolling="no" frameborder="0" allowTransparency="true"/>
        </div>
      </div>
    </xsl:template>

    <xsl:template name="create-contact-banner">
      <div id="contact" class="grid-item-padding">
      <div class="contact_title title_font">
        <h2>Contact Us</h2>
      </div>
      <div class="contact_container text_font">
        <div class="contact_item">
          <img src="icons/phone-24.ico" alt="Phone" class="contact_item_icon"/>
          <xsl:variable name="school-contact-num" select="$schoolprop/@contactNumber"/>
          <a href="tel:{$school-contact-num}"><xsl:value-of select="$school-contact-num"/></a>
        </div>
        <div class="contact_item">
          <img src="icons/email-24.ico" alt="Email" class="contact_item_icon"/>
          <xsl:variable name="school-contact-email" select="$schoolprop/@contactEmail"/>
          <a href="mailto:{$school-contact-email}"><xsl:value-of select="$school-contact-email"/></a>
        </div>
        <div class="contact_item">
          <img src="icons/facebook-24.ico" alt="Facebook" class="contact_item_icon"/>
          <xsl:variable name="fb-link" select="$properties/FACEBOOK/@link"/>
              <a href="{$fb-link}"><xsl:value-of select="$school-name"/></a>
        </div>
      </div>
          <xsl:variable name="google-map-link" select="$properties/GOOGLE/@mapLink"/>
            <iframe id="contact_map" src="{$google-map-link}" frameborder="0" allowfullscreen=""/>
        </div>
    </xsl:template>  

    <xsl:template name="create-footer">
      <div id="footer" class="grid-item-padding">
      <div class="footer_text title_font">Content Copyright © <xsl:value-of select="$properties/COPYRIGHT/@years"/>. <xsl:value-of select="$school-name"/>, <xsl:value-of select="$school-add1"/>. All Rights Reversed.</div>
      <button class="footer_button text_font" onclick="topFunction()">Back to Top</button>
    </div>
    </xsl:template>

  	<xsl:template name="create-news-page">
  		<redirect:write file="{$web-dir}/news.html">
  			<html lang="en">
  				<xsl:call-template name="html-header"/>
  				<body>
	  				<xsl:call-template name="sidenav-bar"/>
  					<div class="page_grid">
  						<xsl:call-template name="create-navigation-banner"/>
  						<div class="pane">
  							<div class="pane_content_item" id="news">
  								<div class="pane_content_title title_font">
                     <h2>News</h2>
                   </div>
  								<div class="news_container">
  									<xsl:call-template name="create-news-items"/>
  								</div>
	  						</div>
  						</div>
  						<xsl:call-template name="create-footer"/>
  					</div>
  				</body>
  			</html>
  		</redirect:write>
  	</xsl:template>

    <xsl:template name="create-staff-page">
      <redirect:write file="{$web-dir}/staff.html">
        <html lang="en">
          <xsl:call-template name="html-header"/>
          <body>
            <xsl:call-template name="sidenav-bar"/>
            <div class="page_grid">
              <xsl:call-template name="create-navigation-banner"/>
              <div class="pane">               
                <div class="pane_content_item" id="staff-bom">
                  <div id="staff">
                   <div class="pane_content_title title_font">
                     <h2>Staff</h2>
                   </div>
                    <div class="custom_table_container">
                      <table class="custom_table">
                        <thead class="title_font">
                          <tr>
                            <td>Staff Member</td>
                            <td>Role(s)</td>
                          </tr>
                        </thead>
                        <tbody class="text_font">
                          <xsl:for-each select="$members/STAFF/MEMBER">
                            <tr>
                              <td><xsl:value-of select="@name"/></td>
                              <td>  
                                <xsl:value-of select="ROLE"/>
                                <xsl:if test="ROLE != '' and ROLE/TEACHER">
                                  <xsl:text>, </xsl:text>
                                </xsl:if>
                                <xsl:if test="ROLE/TEACHER">
                                  <xsl:text>Teacher (</xsl:text>
                                  <xsl:value-of select="ROLE/TEACHER/@class"/>
                                  <xsl:text> class)</xsl:text>
                                </xsl:if>
                              </td>
                            </tr>
                          </xsl:for-each>
                        </tbody>
                      </table>
                    </div>
                  </div>
                  <div id="bom">
                    <div class="pane_content_title title_font">
                     <h2>Board of Management</h2>
                   </div>                    
                    <div class="custom_table_container">
                      <table class="custom_table" id="bom-member-table">
                        <thead class="title_font">
                          <tr>
                            <td>B.O.M. Member</td>
                            <td>Role(s)</td>
                          </tr>
                        </thead>
                        <tbody class="text_font">
                          <xsl:for-each select="$members/BOM/MEMBER">
                            <tr>
                              <td><xsl:value-of select="@name"/></td>
                              <td>  
                                <xsl:for-each select="ROLE">
                                  <xsl:value-of select="."/>
                                  <xsl:if test="position() != last()"><xsl:text>, </xsl:text></xsl:if>
                                </xsl:for-each>
                              </td>
                            </tr>
                          </xsl:for-each>
                        </tbody>
                      </table>
                    </div>
                  </div>
                </div>
              </div>
              <xsl:call-template name="create-footer"/>
            </div>
          </body>
        </html>
      </redirect:write>
    </xsl:template>

    <xsl:template name="create-policies-page">
      <redirect:write file="{$web-dir}/policies.html">
        <html lang="en">
          <xsl:call-template name="html-header"/>
          <body>
            <xsl:call-template name="sidenav-bar"/>
            <div class="page_grid">
              <xsl:call-template name="create-navigation-banner"/>
              <div class="pane">
                  <div class="pane_content_item" id="policies">
                    <div class="pane_content_title title_font">
                     <h2>Policies</h2>
                   </div>
                   <div class="accordion_container">    
                    <xsl:for-each select="$policies/POLICY">
                      <xsl:variable name="policy-file-name" select="@name"/>
                      <xsl:variable name="policy-file" select="@relativeFileLocation"/>
                      <button class="accordion"><span class="policy_title title_font"><xsl:value-of select="@name"/></span></button>
                    <div class="accordion_panel">
                      <xsl:if test="./text()">
                     <span class="policy_text text_font">
                          <xsl:call-template name="replace-newline-with-pagebreak">
                            <xsl:with-param name="text" select="./text()"/>
                          </xsl:call-template>
                        </span>
                      </xsl:if>
                        <xsl:if test="@relativeFileLocation">
                          <span class="policy_viewdownload">
                            <a href="./{$policy-file}">View</a>
                          </span>
                          <span class="policy_viewdownload">
                            <a href="./{$policy-file}" download="{$policy-file-name}">Download</a>
                        </span>
                        </xsl:if>
                    </div>
                    </xsl:for-each>
                  </div>
                </div>
                </div>
              <xsl:call-template name="create-footer"/>
            </div>
          </body>
        </html>
      </redirect:write>
    </xsl:template>


    <xsl:template name="create-calendar-page">
      <redirect:write file="{$web-dir}/calendar.html">
        <html lang="en">
          <xsl:call-template name="html-header"/>
          <body>
            <xsl:call-template name="sidenav-bar"/>
            <div class="page_grid">
              <xsl:call-template name="create-navigation-banner"/>
              <div class="pane">
                  <div class="pane_content_item" id="calendar">
                   <div class="pane_content_title title_font">
                     <h2><xsl:text>Calendar </xsl:text><xsl:value-of select="$schoolprop/CALENDAR/@years"/></h2>
                   </div>
                   <div class="calendar_table"> 
                    <table class="custom_table">
                      <tbody class="text_font">
                        <xsl:for-each select="$calendar/CALENDAR/CALENDARITEM">
                          <tr>
                            <td><xsl:value-of select="@event"/></td>
                            <td>
                              <xsl:call-template name="replace-newline-with-pagebreak">
                              <xsl:with-param name="text" select="./text()"/>
                            </xsl:call-template>
                          </td>
                          </tr>
                        </xsl:for-each>
                      </tbody>
                    </table>
                  </div>
                </div>
              </div>
              <xsl:call-template name="create-footer"/>
               </div>
          </body>
        </html>
      </redirect:write>
    </xsl:template>

    <xsl:template name="create-history-page">
      <redirect:write file="{$web-dir}/history.html">
        <html lang="en">
          <xsl:call-template name="html-header"/>
          <body>
            <xsl:call-template name="sidenav-bar"/>
            <div class="page_grid">
              <xsl:call-template name="create-navigation-banner"/>
              <div class="pane">
                  <div class="pane_content_item" id="history">
                    <div class="pane_content_title title_font">
                     <h2>History</h2>
                   </div>
                   <div class="history_text text_font">
                    <p>
                      <xsl:call-template name="replace-newline-with-pagebreak">
                      <xsl:with-param name="text" select="$history"/>
                    </xsl:call-template>
                  </p>
                  </div>
                </div>         
              </div>
              <xsl:call-template name="create-footer"/>
            </div>
          </body>
        </html>
      </redirect:write>
    </xsl:template>

</xsl:stylesheet>