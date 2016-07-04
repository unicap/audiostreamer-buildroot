<?php
	include('strings.php');
	include('functions.inc.php');
	include('style.css');

	if($_GET["lang"] === "en") $lang='en'; else $lang='de';

	$ini_array = parse_ini_file("/mnt/mmcblk0p1/userconfig.txt", 1);
	if ( isset($_POST['submit']) )
	{
		if ($_POST['DHCP'] == "OFF")
		{
			if ( !validate_input("IPADDR",$_POST['IPADDR']) )
				$error="${error_invalid_ipaddr._.$lang}<br />";
		}

		if ($_POST['DHCP'] == "OFF")
		{
			if ( !validate_input("IPADDR",$_POST['DNSSERV']) )
				$error.="${error_invalid_dnsserver._.$lang}<br />";
		}

		if ( !validate_input("HOSTNAME",$_POST['HOSTNAME']) )
			$error.="${error_invalid_hostname._.$lang}<br />";

		if ($_POST['DHCP'] == "OFF")
		{
			if ( !validate_input("NETMASK",$_POST['NETMASK']) )
				$error.="${error_invalid_netmask._.$lang}<br />";
		}

		if ($_POST['DHCP'] == "OFF")
		{
			if ( !validate_input("HOSTNAMEORIP",$_POST['GATEWAY']) )
				$error.="${error_invalid_gateway._.$lang}<br />";
		}

		if ($_POST['DHCP'] == "OFF")
		{
			if ( !validate_input("LMS",$_POST['SERVERNAME']) )
				$error.="${error_invalid_servername._.$lang}<br />";
		}

		if ( !validate_input("SERVERPORT",$_POST['SERVERPORT']) )
			$error.="${error_invalid_squeezeport._.$lang}<br />";

		if ( !$error )
		{
			$shell_exec_ret=shell_exec('mount -o remount,rw /mnt/mmcblk0p1/');
			write_config();
			$shell_exec_ret=shell_exec('mount -o remount,ro /mnt/mmcblk0p1/');
			unset($_POST['reboot']);
			$ini_array = parse_ini_file("/mnt/mmcblk0p1/userconfig.txt", 1);
			echo '<meta http-equiv="refresh"> ';
		}
	}

	if ( isset($_POST['reboot']) )
	{
		write_config();
		unset($_POST['submit']);
		print '<h1>Configuration saved, will reboot now and redirect you here...</h1>';
		sleep(3);
		shell_exec('reboot -d 1 &');
		echo '<meta http-equiv="refresh" content="15">';
	}

	if ( isset($_POST['scan']))
	{
		$wifilist=scanwifi();
	}

	if ( isset($_POST['lms_submit']) )
	{
		write_config();
		restart_lms();
		$ini_array = parse_ini_file("/mnt/mmcblk0p1/userconfig.txt", 1);
	}

?>

<html>
	<meta name="viewport" content="width=615, initial-scale=1">
	<head>
		<title> <? print ${title_main._.$lang}; ?> </title>
	</head>

	<a href="http://www.abacus-electronics.de" target="_blank"><img src="abacus_logo_wide.png" border="0"></a>

	<body>
		<br><a href="<?php echo $PHP_SELF?>?lang=en" target=""><img src="english.png" border="0"></a>
		<a href="<?php echo $PHP_SELF?>?lang=de" target=""><img src="german.png" border="0"></a>
		<a href="index.php" target=""><? print ${linktext_configuration._.$lang} ?></a>
		<a href="system.php" target=""><? print ${linktext_system._.$lang} ?></a>
		<a href="credits.php" target=""><? print ${linktext_credits._.$lang} ?></a>

		<h1> <? print ${title_main._.$lang} ; if ( isset($_POST['submit'])) print $_POST['HOSTNAME']; else print $ini_array["HOSTNAME"] ?></h1>

		<?if(!$error && isset($_POST['submit']))
		{
			echo '<h1>Configuration saved!</h1>';
			//unset($_POST['submit']);
		}
		else  echo $error;?>

		<form id="Network settings" Name="Network settings" action="" method="post">
			<div id="content">
			<fieldset>
				<legend><? print ${network_form._.$lang} ; ?></legend>

					<a style="text-decoration: none href="#" title="<? print ${helptext_hostname._.$lang} ?>"class="tooltip">
						<span title=""><label for="Hostname">Hostname</label></span></a>

					<input class="actiongroup" <?if ( isset($_POST['submit']) && !validate_input("HOSTNAME",$_POST['HOSTNAME']) ){echo 'style="border:2px solid #ff0000"';};?> type="text" name="HOSTNAME" value="<? if (isset($_POST['submit']))print $_POST['HOSTNAME']; else print $ini_array["HOSTNAME"] ?>">
					<br>

					<a style="text-decoration: none href="#"  title="<? print ${helptext_dhcp._.$lang} ?>"class="tooltip">
						<span title=""><label for="DHCP"><? print ${dhcp._.$lang} ; ?></label></span></a>
					<?
					if ($ini_array["DHCP"] == "OFF" || $_POST["DHCP"] == "OFF")
					{?>
						<input class="actiongroup" type="radio" name="DHCP" value="ON"> <?print ${dhcp_on._.$lang}?>
						<input class="actiongroup" type="radio" name="DHCP" value="OFF" checked> <?print ${dhcp_off._.$lang}?>
						<br>
					<?}
					else
					{?>
						<input class="actiongroup" type="radio" name="DHCP" value="ON" checked> <?print ${dhcp_on._.$lang}?>
						<input class="actiongroup" type="radio" name="DHCP" value="OFF"> <?print ${dhcp_off._.$lang}?>
						<br> 
					<?}

					if ($ini_array["DHCP"] == "OFF" || $_POST['DHCP'] == "OFF")
					{?>
						<a style="text-decoration: none href="#" title="<? print ${helptext_ipaddr._.$lang} ?>"class="tooltip">
							<span title=""><label for="IP-address"> <? print ${ipaddr._.$lang} ; ?> </label></span></a>
						<input class="actiongroup" <?if ( isset($_POST['submit']) && !validate_input("IPADDR",$_POST['IPADDR']) ){echo 'style="border:2px solid #ff0000"';};?> type="text" name="IPADDR" value="<? if (isset($_POST['submit']))print $_POST['IPADDR']; else print $ini_array["IPADDR"]; ?>">
						<br>

						<a style="text-decoration: none href="#" title="<? print ${helptext_netmask._.$lang} ?>"class="tooltip">
							<span title=""><label for="Network-mask"> <? print ${netmask._.$lang} ; ?> </label></span></a>
						<input class="actiongroup" <?if ( isset($_POST['submit']) && !validate_input("NETMASK",$_POST['NETMASK']) ){echo 'style="border:2px solid #ff0000"';};?> type="text" name="NETMASK" value="<?if (isset($_POST['submit']))print $_POST['NETMASK']; else print $ini_array["NETMASK"]; ?>">
						<br>

						<a style="text-decoration: none href="#" title="<? print ${helptext_dnsserv._.$lang} ?>"class="tooltip">
							<span title=""><label for="DNS-server"> <? print ${dnsserv._.$lang} ; ?> </label></span></a>
						<input class="actiongroup" <?if ( isset($_POST['submit']) && !validate_input("IPADDR",$_POST['DNSSERV']) ){echo 'style="border:2px solid #ff0000"';};?> type="text" name="DNSSERV" value="<?if (isset($_POST['submit']))print $_POST['DNSSERV']; else print $ini_array["DNSSERV"] ?>">
						<br>

						<a style="text-decoration: none href="#" title="<? print ${helptext_gateway._.$lang} ?>"class="tooltip">
							<span title=""><label for="Gateway"> <? print ${gateway._.$lang} ; ?> </label></span></a>
							<input class="actiongroup" <?if ( isset($_POST['submit']) && !validate_input("HOSTNAMEORIP",$_POST['GATEWAY']) ){echo 'style="border:2px solid #ff0000"';};?> type="text" name="GATEWAY" value="<? if (isset($_POST['submit']))print $_POST['GATEWAY']; else  print $ini_array["GATEWAY"] ?>">
							<br>
					<?}
					else
					{
						$test_wlan=test_wlan();
						if ($test_wlan == "0")
						{?>
							<a style="text-decoration: none href="#" title="<? print ${helptext_wlanssid._.$lang} ?>"class="tooltip">
								<span title=""><label for="Wireless network"> <? print ${wlanssid._.$lang} ; ?> </label></span></a>
							<?
							echo'<select name="WLANSSID" class="actiongroup">';

							if (isset($_POST['scan']))
							{
								foreach($wifilist as $ssid)
								{
									if($ssid == $ini_array["WLANSSID"])
									{
										echo'<option selected>'.$ssid.'</option>';
									}
									else echo'<option>'.$ssid.'</option>';
								}
							}
							//elseif (isset($_POST['WLANSSID'])) echo'<option selected>'.$_POST['WLANSSID'].'</option>';
							else echo'<option selected>'.$ini_array['WLANSSID'].'</option>';

							echo'</select>';
							?>
							<br>
							<a style="text-decoration: none href="#" title="<? print ${helptext_sitesurvey._.$lang} ?>"class="tooltip">
							<span title=""><label for="Scan"> <? print ${site_survey._.$lang} ; ?> </label></span></a>
							<input class="actiongroup" type="submit" value="Scan networks" name="scan">
							<br>

							<a style="text-decoration: none href="#" title="<? print ${helptext_wlanpwd._.$lang} ?>"class="tooltip">
								<span title=""><label for="Wireless passphrase"> <? print ${wlanpwd._.$lang} ; ?> </label></span></a>
							<input class="actiongroup" type="password" name="WLANPWD" value="<? print $ini_array["WLANPWD"] ?>">
							<br>

							<a style="text-decoration: none href="#" title="<? print ${helptext_userpwd._.$lang} ?>"class="tooltip">
								<span title=""><label for="Userpassword"> <? print ${userpwd._.$lang} ; ?> </label></span></a>
							<input class="actiongroup" type="password" name="USERPASSWD" value="<? print $ini_array["USERPASSWD"] ?>">
							<br>
						<?}
					}?>

			</fieldset>
			</div>

			<div id="content">
			<fieldset>
				<legend> <? print ${squeeze_serv_form._.$lang} ; ?> </legend>
				<a style="text-decoration: none href="#" title="<? print ${helptext_servername._.$lang} ?>"class="tooltip">
						<span title=""><label for="Address or hostname"> <? print ${squeeze_serv_hostname._.$lang} ; ?> </label></span></a>
				<input class="actiongroup" <?if ($_POST['DHCP'] == "OFF") {if ( isset($_POST['submit']) && !validate_input("LMS",$_POST['SERVERNAME']) ){echo 'style="border:2px solid #ff0000"';};}?> type="text" name="SERVERNAME" value="<? if (isset($_POST['submit']))print $_POST['SERVERNAME']; else print $ini_array["SERVERNAME"] ?>">
				<br>

				<a style="text-decoration: none href="#" title="<? print ${helptext_squeezeuser._.$lang} ?>"class="tooltip">
						<span title=""><label for="Username (if set)"> <? print ${squeeze_serv_user._.$lang} ; ?> </label></span></a>
				<input class="actiongroup" type="text" name="SQUEEZEUSER" value="<? print $ini_array["SQUEEZEUSER"] ?>">
				<br>

				<a style="text-decoration: none href="#" title="<? print ${helptext_squeezepwd._.$lang} ?>"class="tooltip">
						<span title=""><label for="Password (if set)"> <? print ${squeeze_serv_passwd._.$lang} ; ?> </label></span></a>
				<input class="actiongroup" type="password" name="SQUEEZEPWD" value="<? print $ini_array["SQUEEZEPWD"] ?>">
				<br>

				<a style="text-decoration: none href="#" title="<? print ${helptext_serverport._.$lang} ?>"class="tooltip">
						<span title=""><label for="Port (default 9000)"> <? print ${squeeze_serv_port._.$lang} ; ?> </label></span></a>
				<input class="actiongroup" <?if ( isset($_POST['submit']) && !validate_input("SERVERPORT",$_POST['SERVERPORT']) ){echo 'style="border:2px solid #ff0000"';};?> type="text" name="SERVERPORT" value="<? if (isset($_POST['submit']))print $_POST['SERVERPORT']; else print $ini_array["SERVERPORT"] ?>">
			</fieldset>
			</div>

			<div id="content">
			<fieldset>
				<legend> <? print ${audio_form._.$lang} ; ?> </legend>
				<a style="text-decoration: none href="#" title="<? print ${helptext_playername._.$lang} ?>"class="tooltip">
						<span title=""><label for="Squeeze-player name"> <? print ${squeeze_player_name._.$lang} ; ?> </label></span></a>
				<? if ( $ini_array["PLAYERNAME"] == "" ) { $ini_array["PLAYERNAME"] = $ini_array["HOSTNAME"]; } ?>
				<input class="actiongroup" type="text" name="PLAYERNAME" value="<? print $ini_array["PLAYERNAME"] ?>">
				<br>

				<a style="text-decoration: none href="#" title="<? print ${helptext_mscoding._.$lang} ?>"class="tooltip">
						<span title=""><label for="Output MS-decoded"> <? print ${mscoded._.$lang} ; ?> </label></span></a>
				<? if ($ini_array["MSCODING"] == "ON") { ?>
					<input class="actiongroup" type="radio" name="MSCODING" value="ON" checked> <? print ${mscoded_on._.$lang} ; ?>
					<input class="actiongroup" type="radio" name="MSCODING" value="OFF"> <? print ${mscoded_off._.$lang} ; ?>
					<br>
				<?}

				else
				{?>
					<input class="actiongroup" type="radio" name="MSCODING" value="ON"> <? print ${mscoded_on._.$lang} ; ?>
					<input class="actiongroup" type="radio" name="MSCODING" value="OFF" checked> <? print ${mscoded_off._.$lang} ; ?>
					<br>
				<?}
				?>

				<a style="text-decoration: none href="#" title="<? print ${helptext_volume._.$lang} ?>"class="tooltip">
						<span title=""><label for="Volume"> <? print ${volume._.$lang} ; ?> </label></span></a>
					<? print_optgroup("VOLUME",$arr_volume,$ini_array["VOLUME"]); ?>
					<br>

				<a style="text-decoration: none href="#" title="<? print ${helptext_alsaoutbuff._.$lang} ?>"class="tooltip">
						<span title=""><label for="Output buffer in KB"> <? print ${alsaoutbuff._.$lang} ; ?></label></span></a>
					<? print_optgroup("ALSAOUTBUFF",$arr_alsa,$ini_array["ALSAOUTBUFF"]); ?>
				<br>

				<a style="text-decoration: none href="#" title="<? print ${helptext_alsaperiod._.$lang} ?>"class="tooltip">
						<span title=""><label for="Period size"> <? print ${alsaperiod._.$lang} ; ?> </label></span></a>
					<? print_optgroup("ALSAPERIOD",$arr_alsa,$ini_array["ALSAPERIOD"]); ?>
				<br>
				<a style="text-decoration: none href="#" title="<? print ${helptext_alsasamplefmt._.$lang} ?>"class="tooltip">
						<span title=""><label for="Sample format"> <? print ${alsasamplefmt._.$lang} ; ?> </label></span></a>
					<? print_optgroup("ALSASAMPLEFMT",$arr_samplingres,$ini_array["ALSASAMPLEFMT"]) ?>
				<br>

				<a style="text-decoration: none href="#" title="<? print ${helptext_alsammap._.$lang} ?>"class="tooltip">
						<span title=""><label for="Use MMAP"> <? print ${alsammap._.$lang} ; ?> </label></span></a>
				<?
				if ($ini_array["ALSAMMAP"] == "1")
					{?>
					<input class="actiongroup" type="radio" name="ALSAMMAP" value="1" checked> <? print ${alsammap_on._.$lang} ; ?>
					<input class="actiongroup" type="radio" name="ALSAMMAP" value="0"> <? print ${alsammap_off._.$lang} ; ?>
					<br>
				<?}
				else
				{?>
					<input class="actiongroup" type="radio" name="ALSAMMAP" value="1"> <? print ${alsammap_on._.$lang} ; ?>
					<input class="actiongroup" type="radio" name="ALSAMMAP" value="0" checked> <? print ${alsammap_off._.$lang} ; ?>
					<br>
				<?}
				?>

				<a style="text-decoration: none href="#" title="<? print ${helptext_streambuff._.$lang} ?>"class="tooltip">
						<span title=""><label for="Streambuffer size"> <? print ${alsastreambuff._.$lang} ; ?></label></span></a>
					<? print_optgroup("STREAMBUFF",$arr_alsa,$ini_array["STREAMBUFF"]);  ?>
				<br>
			</fieldset>
			</div>
			<br>
			<input type="submit" value="submit" name="submit">
			<input type="submit" value="reboot" name="reboot">
		</form>
	</body>
<? unset($_POST['submit']);?>
</html>
