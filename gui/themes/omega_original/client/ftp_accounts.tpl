<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>{TR_CLIENT_MANAGE_USERS_PAGE_TITLE}</title>
<meta name="robots" content="nofollow, noindex" />
<meta http-equiv="Content-Type" content="text/html; charset={THEME_CHARSET}" />
<meta http-equiv="Content-Style-Type" content="text/css" />
<meta http-equiv="Content-Script-Type" content="text/javascript" />
<link href="{THEME_COLOR_PATH}/css/imscp.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="{THEME_COLOR_PATH}/css/imscp.js"></script>
<!--[if lt IE 7.]>
<script defer type="text/javascript" src="{THEME_COLOR_PATH}/css/pngfix.js"></script>
<![endif]-->
<script type="text/javascript">
<!--
function action_delete(url, name) {
	if (!confirm(sprintf("{TR_MESSAGE_DELETE}", name)))
		return false;
	location = url;
}
//-->
</script>
</head>

<body onLoad="MM_preloadImages('{THEME_COLOR_PATH}/images/icons/database_a.png','{THEME_COLOR_PATH}/images/icons/domains_a.png','{THEME_COLOR_PATH}/images/icons/ftp_a.png','{THEME_COLOR_PATH}/images/icons/general_a.png' ,'{THEME_COLOR_PATH}/images/icons/email_a.png','{THEME_COLOR_PATH}/images/icons/webtools_a.png','{THEME_COLOR_PATH}/images/icons/statistics_a.png','{THEME_COLOR_PATH}/images/icons/support_a.png')">
<table width="100%" border="0" cellspacing="0" cellpadding="0" style="height:100%;padding:0;margin:0 auto;">
<!-- BDP: logged_from -->
<tr>
 <td colspan="3" height="20" nowrap="nowrap" class="backButton">&nbsp;&nbsp;&nbsp;<a href="change_user_interface.php?action=go_back"><img src="{THEME_COLOR_PATH}/images/icons/close_interface.png" width="16" height="16" border="0" style="vertical-align:middle" alt="" /></a> {YOU_ARE_LOGGED_AS}</td>
</tr>
<!-- EDP: logged_from -->
<tr>
<td align="left" valign="top" style="vertical-align: top; width: 195px; height: 56px;"><img src="{THEME_COLOR_PATH}/images/top/top_left.jpg" width="195" height="56" border="0" alt="i-MSCP Logogram" /></td>
<td style="height: 56px; width:100%; background-color: #0f0f0f"><img src="{THEME_COLOR_PATH}/images/top/top_left_bg.jpg" width="582" height="56" border="0" alt="" /></td>
<td style="width: 73px; height: 56px;"><img src="{THEME_COLOR_PATH}/images/top/top_right.jpg" width="73" height="56" border="0" alt="" /></td>
</tr>
	<tr>
		<td style="width: 195px; vertical-align: top;">{MENU}</td>
	    <td colspan="2" style="vertical-align: top;"><table style="width: 100%; padding:0;margin:0;" cellspacing="0">
          <tr style="height:95px;">
            <td style="padding-left:30px; width: 100%; background-image: url({THEME_COLOR_PATH}/images/top/middle_bg.jpg);">{MAIN_MENU}</td>
            <td style="padding:0;margin:0;text-align: right; width: 73px;vertical-align: top;"><img src="{THEME_COLOR_PATH}/images/top/middle_right.jpg" width="73" height="95" border="0" alt="" /></td>
          </tr>
          <tr>
            <td colspan="3"><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td align="left"><table width="100%" cellpadding="5" cellspacing="5">
                    <tr>
                      <td width="25"><img src="{THEME_COLOR_PATH}/images/content/table_icon_ftp.png" width="25" height="25" alt="" /></td>
                      <td colspan="2" class="title">{TR_FTP_USERS}</td>
                    </tr>
                </table></td>
                <td width="27" align="right">&nbsp;</td>
              </tr>
              <tr>
                <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td width="40">&nbsp;</td>
                      <td valign="top"><table width="100%" cellspacing="7">
                          <!-- BDP: page_message -->
                          <tr>
                            <td colspan="3" nowrap="nowrap" class="title"><span class="message">{MESSAGE}</span></td>
                          </tr>
                          <!-- EDP: page_message -->
                          <!-- BDP: table_list -->
                          <tr>
                            <td nowrap="nowrap" class="content3"><b>{TR_FTP_ACCOUNT}</b></td>
                            <td nowrap="nowrap" class="content3" align="center" colspan="2"><b>{TR_FTP_ACTION}</b></td>
                          </tr>
                          <!-- EDP: table_list -->
                          <!-- BDP: ftp_message -->
                          <tr>
                            <td colspan="3" class="title"><span class="message">{FTP_MSG}</span></td>
                          </tr>
                          <!-- EDP: ftp_message -->
                          <!-- BDP: ftp_item -->
                          <tr class="hl">
                            <td nowrap="nowrap" class="{ITEM_CLASS}"><span class="content"><img src="{THEME_COLOR_PATH}/images/icons/ftp_account.png" width="16" height="16" style="vertical-align:middle" alt="" /></span>{FTP_ACCOUNT}</td>
                            <td nowrap="nowrap" class="{ITEM_CLASS}" align="center" width="100"><img src="{THEME_COLOR_PATH}/images/icons/edit.png" width="16" height="16" style="vertical-align:middle" alt="" /> <a href="ftp_edit.php?id={UID}" class="link">{TR_EDIT}</a></td>
                            <td nowrap="nowrap" class="{ITEM_CLASS}" align="center" width="100"><img src="{THEME_COLOR_PATH}/images/icons/delete.png" width="16" height="16" border="0" style="vertical-align:middle" alt="" /> <a href="#" class="link" onClick="action_delete('ftp_delete.php?id={UID}', '{FTP_ACCOUNT}')">{TR_DELETE}</a></td>
                          </tr>
                          <!-- EDP: ftp_item -->
                          <!-- BDP: ftps_total -->
                          <tr>
                            <td colspan="3" align="right" nowrap="nowrap" class="content3">{TR_TOTAL_FTP_ACCOUNTS}&nbsp;<b>{TOTAL_FTP_ACCOUNTS}</b></td>
                          </tr>
                          <!-- EDP: ftps_total -->
                      </table></td>
                    </tr>
                </table></td>
                <td>&nbsp;</td>
              </tr>
              <tr>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
              </tr>
            </table></td>
          </tr>
        </table></td>
	</tr>
</table>
</body>
</html>