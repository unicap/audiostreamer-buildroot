<?php
	include('strings.php');
	include('functions.inc.php');
	include('style.css');



	if($_GET["lang"] === "en") $lang='en'; else $lang='de';

	$ini_array = parse_ini_file("/etc/aroio/userconfig", 1);

    if ( isset($_POST['check_update']) )
	{
		//$shell_exec_ret=shell_exec('chmod 750 /usr/bin/update check');
		// wrtToUserconfig('USEBETA',$_POST['USEBETA']);
        $ini_array[USEBETA] = $_POST['USEBETA'];
		exec ( "/usr/bin/update check" , $ausgabe , $return_var  );
		list($remote[0], $remote[1]) = explode(".", $ausgabe[0]);
		list($local[0], $local[1]) = explode(".", $ausgabe[1]);
		if (is_numeric("$remote[0]")){
			if ($remote[0] > $local[0]) $update_message="<h1>${infotext_update_available._.$lang}</h1>";}
		if ($remote[0] == $local[0] && $remote[1] > $local[1])
			{
				$update_message="<h1>${infotext_update_available._.$lang}</h1>";
				shell_exec('mount -o remount,rw /mnt/mmcblk0p1/');
			}
		else
			{
			$update_message="<h1>${infotext_update_unchanged._.$lang}</h1>";
				shell_exec('mount -o remount,rw /mnt/mmcblk0p1/');	
			}
		unset($_POST['submit']);
	}


	if ( isset($_POST['update']) )
	{
		$update=true;
		//exec("/usr/bin/update update" , $update_output);
	}
	?>

<html>
	<meta name="viewport" content="width=615, initial-scale=1">
	<head>
		<title> <? print ${title_system._.$lang}; ?> </title>
	</head>

	<a href="http://www.abacus-electronics.de" target="_blank"><img src="abacus_logo_wide.png" border="0"></a>

	<body>
		<br><a href="<?php echo $PHP_SELF?>?lang=en" target=""><img src="english.png" border="0"></a>
		<a href="<?php echo $PHP_SELF?>?lang=de" target=""><img src="german.png" border="0"></a>
		<a href="index.php" target=""><? print ${linktext_configuration._.$lang} ?></a>
		<a href="system.php" target=""><? print ${linktext_system._.$lang} ?></a>
		<a href="measurement.php" target=""><? print ${linktext_measurement._.$lang} ?></a>
		<!-- <a href="credits.php" target=""><? print ${linktext_credits._.$lang} ?></a> -->
		<? if ($ini_array['BRUTEFIR'] == "ON")
		{?>
			<a href="brutefir.php"target=""><? print ${linktext_brutefir._.$lang} ?></a> <?
		}?>

		<h1> <? print ${title_system._.$lang} ; if ( isset($_POST['submit'])) print $_POST['HOSTNAME']; else print $ini_array["HOSTNAME"] ?></h1>

		<form id="Network settings" Name="Network settings" action="" method="post">
			<div class="content">
				<fieldset>
					<legend> <? print ${update_form._.$lang} ; ?> </legend>

					<? if ($update == false)
					{ ?>
						<input type="submit" value=" <? print ${button_check_update._.$lang} ?> " name="check_update">
						<br><br>
						<a style="text-decoration: none href="#" title="<? print ${helptext_beta._.$lang} ?>"class="tooltip">
                                                <span title=""><label for="Use beta"> <? print ${beta._.$lang} ; ?> </label></span></a>
						<? if ($ini_array['USEBETA'] == "ON")
						{ ?>
							<input class="actiongroup" type="radio" name="USEBETA" value="OFF"> <? print ${use_beta_off._.$lang} ; ?>
							<input class="actiongroup" type="radio" name="USEBETA" value="ON" checked> <? print ${use_beta_on._.$lang} ; ?>
						<? }
						else
						{ ?>
							<input class="actiongroup" type="radio" name="USEBETA" value="OFF" checked> <? print ${use_beta_off._.$lang} ; ?>
							<input class="actiongroup" type="radio" name="USEBETA" value="ON"> <? print ${use_beta_on._.$lang} ; ?>
						<? } ?>
						<br>
						<p> <? print ${local_version._.$lang} ; echo $local[0].".".$local[1]; ?>
						<br><? print ${remote_version._.$lang} ; echo $remote[0].".".$remote[1]; ?> </p>
						<? if ($update_message != "")
							{
								print $update_message; ?>
								<input type="submit" value=" <? print ${button_update._.$lang} ?> " name="update">
							<?}
					}
					else
						{
							print ${infotext_update_running._.$lang};
							echo '<pre>';
							system('/usr/bin/update update');
							echo '</pre>';
							print_r($update_output);
						}
					?>
				</fieldset>
				<fieldset>
					<legend> <? print ${sysinfo_form._.$lang} ; ?> </legend>
					<?
						$uptime=echo_uptime();
						$mac_addr_lan=echo_mac_lan();
						$ip_addr_lan=get_ipaddr_lan();
						$mac_addr_wlan=echo_mac_wlan();
						$ip_addr_wlan=get_ipaddr_wlan();
						$carrierstate=echo_carrierstate();
						if ( $carrierstate == '0')
							$carrierstate=${infotext_carrierstate_0._.$lang};
						else $carrierstate=${infotext_carrierstate_1._.$lang};
							$squeezeserverstate=ping_squeezeserver();
						if ( $squeezeserverstate == "0")
						{
							echo $ini_array["SERVERPORT"];
							$squeezeserverstate=${infotext_squeezeserverstate_1._.$lang}.' unter <a target="_blank" href="http://'.print_squeezeaddr($ini_array["SERVERPORT"]).'">http://'.print_squeezeaddr($ini_array["SERVERPORT"]).'</a>';
						}
						else
							{
								$squeezeserverstate=${infotext_squeezeserverstate_0._.$lang};
							}
					?>

					<p> <? print ${infotext_uptime._.$lang} ; echo "$uptime"; ?> <br>
						<? print ${infotext_macaddr_lan._.$lang} ; echo "$mac_addr_lan"; ?> <br>
						<? print ${infotext_ipaddr_lan._.$lang} ; echo "$ip_addr_lan[0]"; ?> <br>
						<? $test_wlan=test_wlan();
						if ($test_wlan == "0")
							{
								print ${infotext_macaddr_wlan._.$lang} ; echo "$mac_addr_wlan"; ?> <br>
								<? print ${infotext_ipaddr_wlan._.$lang} ; if ($ip_addr_wlan[0] == "") echo ${infotext_wlan_unconfigured._.$lang};
								else echo "$ip_addr_wlan[0]"; ?> <br>
							<?}?>
						<? print ${infotext_carrierstate._.$lang}.$carrierstate; ?> <br>
						<? print ${infotext_squeezeserverstate._.$lang}.$squeezeserverstate; ?> <br>

					</p>
					<input type="submit" class="actiongroup" value=" <? print ${button_ifconfig._.$lang} ?> " name="ifconfig">
					<input type="submit" class="actiongroup" value=" <? print ${button_dmesg._.$lang} ?> " name="dmesg">
					<input type="submit" class="actiongroup" value=" <? print ${button_mount._.$lang} ?> " name="mount">
					<input type="submit" class="actiongroup" value=" <? print ${button_free._.$lang} ?> " name="free">
					<input type="submit" class="actiongroup" value="squeezelitelog" name="squeezelitelog">
					<input type="submit" class="actiongroup" value="shairportlog" name="shairportlog">
					<?
						if ( isset($_POST['ifconfig']) )
						print_cmdout('ifconfig');
						if ( isset($_POST['dmesg']) )
						print_cmdout('dmesg');
						if ( isset($_POST['mount']) )
						print_cmdout('mount');
						if ( isset($_POST['free']) )
						print_cmdout('free');
						if ( isset($_POST['squeezelitelog']) )
						print_txtrelative('squeezelitelog.txt');
						if ( isset($_POST['shairportlog']) )
                        print_txtrelative('shairportlog.txt');
					?>
				</fieldset>
			</div>
		</form>
	</body>
</html>
