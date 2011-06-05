<?php

function gen_domain_details($tpl, $domain_id)
{
    $tpl->assign('USER_DETAILS', '');

    if (isset($_SESSION['details']) && $_SESSION['details'] == 'hide') {
        $tpl->assign(
            array(
                 'TR_VIEW_DETAILS' => tr('view aliases'),
                 'SHOW_DETAILS' => "show",
            )
        );

        return;
    } else if (isset($_SESSION['details']) && $_SESSION['details'] === "show") {
        $tpl->assign(
            array(
                 'TR_VIEW_DETAILS' => tr('hide aliases'),
                 'SHOW_DETAILS' => "hide",
            )
        );

        $alias_query = "
			SELECT
				`alias_id`, `alias_name`
			FROM
				`domain_aliasses`
			WHERE
				`domain_id` = ?
			ORDER BY
				`alias_id` DESC
		";
        $alias_rs = exec_query($alias_query, $domain_id);

        if ($alias_rs->recordCount() == 0) {
            $tpl->assign('USER_DETAILS', '');
        } else {
            while (!$alias_rs->EOF) {
                $alias_name = $alias_rs->fields['alias_name'];

                $tpl->assign('ALIAS_DOMAIN', tohtml(decode_idna($alias_name)));
                $tpl->parse('USER_DETAILS', '.user_details');

                $alias_rs->moveNext();
            }
        }
    } else {
        $tpl->assign(
            array(
                 'TR_VIEW_DETAILS' => tr('view aliases'),
                 'SHOW_DETAILS' => "show",
            )
        );

        return;
    }
}

/**
 * Helper function to generate logged from template part.
 *
 * @param  iMSCP_pTemplate $tpl iMSCP_pTemplate instance
 * @return void
 */
function gen_logged_from($tpl)
{
    if (isset($_SESSION['logged_from']) && isset($_SESSION['logged_from_id'])) {
        $tpl->assign(array(
                          'YOU_ARE_LOGGED_AS' => tr(
                              '%1$s you are now logged as %2$s',
                              $_SESSION['logged_from'],
                              decode_idna($_SESSION['user_logged'])
                          ),
                          'TR_GO_BACK' => tr('Go back')));

        $tpl->parse('LOGGED_FROM', '.logged_from');
    } else {
        $tpl->assign('LOGGED_FROM', '');
    }
}

/**
 * Helper function to generates a html list of available languages.
 *
 * This method generate a HTML list of available languages. The language used by the
 * user is pre-selected. If no language table is found in the database, a specific
 * message is shown.
 *
 * @param  iMSCP_pTemplate $tpl Template engine
 * @param  $user_def_language
 * @return void
 */
function gen_def_language($tpl, $user_def_language)
{

    /** @var $cfg iMSCP_Config_Handler_File */
    $cfg = iMSCP_Registry::get('config');

    $languages = array();
    $htmlSelected = $cfg->HTML_SELECTED;

    // Retrieve all available languages (one database table per language)
    $query = "SHOW TABLES LIKE 'lang_%';";
    $stmt = exec_query($query);

    $stmt->setFetchStyle(PDO::FETCH_NUM);

    if ($stmt->recordCount()) {
        while (!$stmt->EOF) {
            $lang_table = $stmt->fields[0];

            $query = "
			SELECT
				`msgstr`
			FROM
				`$lang_table`
			WHERE
				`msgid` = 'iMSCP_language'
			;
		";

            $stmt2 = exec_query($query);

            $query = "
			SELECT
				`msgstr`
			FROM
				`$lang_table`
			WHERE
				`msgid` = 'iMSCP_languageSetlocaleValue'
			;
		";

            $stmt3 = exec_query($query);

            if ($stmt2->recordCount() == 0 || $stmt3->recordCount() == 0) {
                $language_name = tr('Unknown');
            } else {
                $tr_langcode = tr($stmt3->fields['msgstr']);

                if ($stmt3->fields['msgstr'] == $tr_langcode) { // no translation found
                    $language_name = $stmt2->fields['msgstr'];
                } else { // found translation
                    $language_name = $tr_langcode;
                }
            }

            $selected = ($lang_table === $user_def_language) ? $htmlSelected : '';
            array_push($languages, array($lang_table, $selected, $language_name));
            $stmt->moveNext();
        }

        asort($languages[0], SORT_STRING);
        foreach ($languages as $lang) {
            $tpl->assign(
                array(
                     'LANG_VALUE' => $lang[0],
                     'LANG_SELECTED' => $lang[1],
                     'LANG_NAME' => tohtml($lang[2])
                )
            );

            $tpl->parse('DEF_LANGUAGE', '.def_language');
        }
    } else { // Only occur when all languages database tables were dropped
        $tpl->assign('LANGUAGES_AVAILABLE', '');
        set_page_message(tr('No language tables found in the database.'), 'warning');
    }
}

/**
 * Helper function to generate HTML list of months and years
 *
 * @param  iMSCP_pTemplate $tpl iMSCP_pTemplate instance
 * @param  $user_month
 * @param  $user_year
 * @return void
 */
function gen_select_lists($tpl, $user_month, $user_year)
{
    global $crnt_month, $crnt_year;

     /** @var $cfg iMSCP_Config_Handler_File */
    $cfg = iMSCP_Registry::get('config');

    if (!$user_month == '' || !$user_year == '') {
        $crnt_month = $user_month;
        $crnt_year = $user_year;
    } else {
        $crnt_month = date('m');
        $crnt_year = date('Y');
    }

    for ($i = 1; $i <= 12; $i++) {
        $selected = ($i == $crnt_month) ? $cfg->HTML_SELECTED : '';
        $tpl->assign(array('OPTION_SELECTED' => $selected, 'MONTH_VALUE' => $i));
        $tpl->parse('MONTH_LIST', '.month_list');
    }

    for ($i = $crnt_year - 1; $i <= $crnt_year + 1; $i++) {
        $selected = ($i == $crnt_year) ? $cfg->HTML_SELECTED : '';
        $tpl->assign(array('OPTION_SELECTED' => $selected, 'YEAR_VALUE' => $i));
        $tpl->parse('YEAR_LIST', '.year_list');
    }
}
