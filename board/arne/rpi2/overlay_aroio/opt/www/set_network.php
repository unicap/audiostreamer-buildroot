<?php
	print_r ($_POST);
	$handle=fopen("/mnt/mmcblk0p1/userconfig.txt","w");
	foreach($_POST as $key=> $value)
		{
			switch($key)
				{
					case "HOSTNAME":
					$string = $key."="."\"".$value."\"";
					break;

					case "DHCP":
					$string .= "\n".$key."="."\"".$value."\"";
					break;
					
					case "IPADDR":
					$string .= "\n".$key."="."\"".$value."\"";
					break;
					
					case "NETMASK":
					$string .= "\n".$key."="."\"".$value."\"";
					break;

					case "DNSSERV":
					$string .= "\n".$key."="."\"".$value."\"";
					break;

					case "GATEWAY":
					$string .= "\n".$key."="."\"".$value."\"";
					break;

					case "WLANSSID":
					$string .= "\n".$key."="."\"".$value."\"";
					break;

					case "WLANPWD":
					$string .= "\n".$key."="."\"".$value."\"";
					break;

					case "MSCODING":
					$string .= "\n".$key."="."\"".$value."\"";
					break;

					case "DEBUG":
					$string .= "\n".$key."="."\"".$value."\"";
					break;

					case "SERVERNAME":
					$string .= "\n".$key."="."\"".$value."\"";
					break;

					case "PLAYERNAME":
					$string .= "\n".$key."="."\"".$value."\"";
					break;

					case "ALSAOUTBUFF":
					$string .= "\n".$key."="."\"".$value."\"";
					break;

					case "ALSAPERIOD":
					$string .= "\n".$key."="."\"".$value."\"";
					break;

					case "ALSASAMPLEFMT":
					$string .= "\n".$key."="."\"".$value."\"";
					break;

					case "ALSAMMAP":
					$string .= "\n".$key."="."\"".$value."\"";
					break;

					case "STREAMBUFF":
					$string .= "\n".$key."="."\"".$value."\"";
					break;

					case "WLANPWD":
					$string .= "\n".$key."="."\"".$value."\"";
					break;
				}
		}
	fwrite($handle, $string);
	header ("Location: /opt/www/test.php");
	exit;
?>
