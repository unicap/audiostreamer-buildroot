<?php

function scanwifi()
{
	$wifiscan=exec('iwlist scan 2>/dev/null | sed \'s/\"//g\' | awk -F":" \'/ESSID/{print $2}\' | sort -f  ',$wifilist);
	return $wifilist;
}

function validate_input($case,$input)
{
	switch ($case)
	{
	case "IPADDR":
		$check='/^(\b(?:\d{1,3}\.){3}\d{1,3}\b)$/';
		break;
    case "HOSTNAME":
    	$check='/^$|[0-9a-zA-Z]([0-9a-zA-Z\-]{0,61}[0-9a-zA-Z])?(\.[0-9a-zA-Z](0-9a-zA-Z\-]{0,61}[0-9a-zA-Z])?)*$/';
    	break;
	case "HOSTNAMEORIP":
    	//$check='/^([A-Za-z0-9]+(?:-[A-Za-z0-9]+)*(?:\.[A-Za-z0-9]+(?:-[A-Za-z0-9]+)*)*$)|(\b(?:\d{1,3}\.){3}\d{1,3}\b)/' ;
    	$check='/^([A-Za-z0-9]+(?:-[A-Za-z0-9]+)*(?:\.[A-Za-z0-9]+(?:-[A-Za-z0-9]+)*)*$)|(\b(?:\d{1,3}\.){3}\d{1,3}\b)/' ;
       	break;
    case "LMS":
    	//$check='/^([A-Za-z0-9]+(?:-[A-Za-z0-9]+)*(?:\.[A-Za-z0-9]+(?:-[A-Za-z0-9]+)*)*$)|(\b(?:\d{1,3}\.){3}\d{1,3}\b)/' ;
    	$check='/^$|([A-Za-z0-9]+(?:-[A-Za-z0-9]+)*(?:\.[A-Za-z0-9]+(?:-[A-Za-z0-9]+)*)*$)|(\b(?:\d{1,3}\.){3}\d{1,3}\b)/' ;
       	break;
    case "NETMASK":
       	$check='/^(((0|128|192|224|240|248|252|254).0.0.0)|(255.(0|128|192|224|240|248|252|254).0.0)|(255.255.(0|128|192|224|240|248|252|254).0)|(255.255.255.(0|128|192|224|240|248|252|254)))$/';
       		break;
	case "SERVERPORT":
		$check='/^$|(\b([1-9][0-9]{0,3}|[1-5][0-9]{4}|60[0-9]{3}|61000)\b)$/'; 
		break;
		// Fehler:
		default:
       		return 0;
	}

	if ( preg_match($check, $input) )
	{
		return 1;
	}
	else
	{
		return 0;
	}
}

function write_config()
{
	$shell_exec_ret=shell_exec('mount -o remount,rw /mnt/mmcblk0p1/');
	$handle=fopen("/mnt/mmcblk0p1/userconfig.txt","w");
	foreach($_POST as $key=> $value)
		{
			switch($key)
				{
					case "LANG":
					$string = $key."="."\"".$value."\"";
					break;
					case "HOSTNAME":
					$string .= "\n".$key."="."\"".$value."\"";
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
					case "SERVERPORT":
					$string .= "\n".$key."="."\"".$value."\"";
					break;
					case "SQUEEZEUSER":
					$string .= "\n".$key."="."\"".$value."\"";
					break;
					case "SQUEEZEPWD":
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
					case "VOLUME":
					$string .= "\n".$key."="."\"".$value."\"";
					break;
					case "USERPASSWD":
					$string .= "\n".$key."="."\"".$value."\"";
					break;
				}
		}
	fwrite($handle, $string);
	$shell_exec_ret=shell_exec('mount -o remount,ro /mnt/mmcblk0p1/');
}


//Gibt Systembefehle in eigenen div aus
function print_cmdout($command)
{
	exec($command,$arr_out);
	$out = '<div class="system">';
	foreach($arr_out as $line)
	{
		$out .= $line.'<br>';
	}
	$out .= '<div>';
	echo $out;
}

function echo_uptime()
{
	$uptime=exec("uptime | awk '{print $1}'");
	return $uptime;
}

function echo_ps()
{
	echo '<pre>';
	passthru('ps');
	echo '</pre>';
}

function echo_iwlist()
{
	echo '<pre>';
	passthru('iwlist wlan0 scanning');
	echo '</pre>';
}


// 0 für nix und 1 für Kabel steckt
function echo_carrierstate()
{
	$carrierstate=exec('cat /sys/class/net/eth0/carrier');
	return $carrierstate;
}

// MAC-Adresse eth
function echo_mac_lan()
{
	$mac_lan=exec('cat /sys/class/net/eth0/address');
	return $mac_lan;
}

// MAC-Adresse wlan
function echo_mac_wlan()
{
	$mac_wlan=exec('cat /sys/class/net/wlan0/address');
	return $mac_wlan;
}

// Ping Squeeze-Server
function ping_squeezeserver()
{
	exec("ping -c1 -W1 $(cat /var/log/lmsaddress)" , $output , $return_var);
	return $return_var;
}

// IP-Adresse von eth0 rausfinden
function get_ipaddr_lan()
{
	exec("ifconfig eth0 | grep inet | grep -v 127 | awk -F: '{ print $2 }' | awk '{ print $1 }'" , $output);
	return $output;
}

// IP-Adresse von wlan0 rausfinden
function get_ipaddr_wlan()
{
	exec("ifconfig wlan0 | grep inet | grep -v 127 | awk -F: '{ print $2 }' | awk '{ print $1 }'" , $output);
	return $output;
}

function test_wlan()
{
	exec("dmesg | grep -q WLAN" , $output , $return_val);
	return $return_val;
}

function restart_lms()
{
	shell_exec('killall startstreamer.sh');
	shell_exec('killall shairport');
	shell_exec('killall squeezelite');
	//exec('killall startstreamer.sh squeezelite shairport' , $output_killall);
	shell_exec('/usr/bin/startstreamer.sh &> /dev/null &');
	//return $output_killall;
}

//HTML-Functions


//Gibt Option Group aus
//$name : Name der Opt-Group
//$arr_values: auswählbare Optionen in Array

function print_optgroup($name,$arr_values,$sel_value)
{
	$out = '<select name="'.$name.'"class="actiongroup" > \n';
	$out .= '<option selected>'.$sel_value.'</option> \n';
	foreach ($arr_values as $option)
	{
		$out.='<option>'.$option.'</option> \n';
	}
	$out.='</select>';

	echo $out;
}


//Gibt den Text aus File in eigenem div aus
//$file: Name des Files im Root-Verzeichnis
function print_txtrelative($file)
{
	$path='/var/log/'.$file;
	$handle = fopen($path,r);
	$out='<div class="system">';
	while($inhalt = fgets ($handle, 4096 ))
	{
		$out.=$inhalt.'<br>';
	}
	$out.='</div>';
	echo $out;
}


//Gibt die korrekte Squeezebox Adresse aus

function print_squeezeaddr($port)
{
	if ($port=="") $port="9000";
	$out = exec("cat /var/log/lmsaddress");
	return $out .= ":".$port;
}

?>
