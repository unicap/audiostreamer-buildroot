<?php
include('strings.php');

function scanwifi()
{
	$wifiscan=exec('ifconfig wlan0 up && iwlist scan 2>/dev/null | sed \'s/\"//g\' | awk -F":" \'/ESSID/{print $2}\' | sort -f  ',$wifilist);
	return $wifilist;
}



// from: http://stackoverflow.com/questions/5695145/how-to-read-and-write-to-an-ini-file-with-php
function write_php_ini($array, $file)
{
    $res = array();
    foreach($array as $key => $val)
    {
        if(is_array($val))
        {
            $res[] = "[$key]";
            foreach($val as $skey => $sval) $res[] = "$skey = ".(is_numeric($sval) ? $sval : '"'.$sval.'"');
        }
        else $res[] = "$key = ".(is_numeric($val) ? $val : '"'.$val.'"');
    }
    safefilerewrite($file, implode("\r\n", $res));
}

function safefilerewrite($fileName, $dataToSave)
{    if ($fp = fopen($fileName, 'w'))
    {
        $startTime = microtime(TRUE);
        do
        {            $canWrite = flock($fp, LOCK_EX);
           // If lock not obtained sleep for 0 - 100 milliseconds, to avoid collision and CPU load
           if(!$canWrite) usleep(round(rand(0, 100)*1000));
        } while ((!$canWrite)and((microtime(TRUE)-$startTime) < 5));

        //file was locked so now we can store information
        if ($canWrite)
        {            fwrite($fp, $dataToSave);
            flock($fp, LOCK_UN);
        }
        fclose($fp);
    }

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
    $ini_array = parse_ini_file("/etc/aroio/userconfig", 0);
	foreach($_POST as $key=> $value)
    {
        $allowed_keys = array("LANG",
                              "HOSTNAME",
                              "DHCP",
                              "IPADDR",
                              "NETMASK",
                              "DNSSERV",
                              "GATEWAY",
                              "WLANSSID",
                              "WLANPWD",
                              "MSCODING",
                              "DEBUG",
                              "SERVERNAME",
                              "SERVERPORT",
                              "SQUEEZEUSER",
                              "SQUEEZEPWD",
                              "PLAYERNAME",
                              "WLANPWD",
                              "VOLUME",
                              "USERPASSWD",
                              "BRUTEFIR",
                              "JACKBUFFER",
                              "AUDIOPLAYER", // maps to PLAYER for whatever reason
                              "SOUNDCARD",
                              "RATE");
        if (in_array($key, $allowed_keys)) {
            if ($key == "AUDIOPLAYER"){
                $key = "PLAYER";
            }
            $ini_array[$key] = $value;
        }
    }
    write_php_ini($ini_array, "/etc/aroio/userconfig");
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
	exec("dmesg | grep -qe WLAN -e Realtek" , $output , $return_val);
	return $return_val;
}

function restart_lms()
{
	shell_exec('/etc/init.d/audio restart &> /dev/null &');
}

function cancel_measurement()
{
	shell_exec('killall recordsweep');
	shell_exec('killall aplay');
	shell_exec('killall arecord');
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

//liest die Filter aus Pfad aus und 
function fltrSelect($id,$ini_array)
{
	$directory = '/home/sftparoio'; //evtl als konstante bzw in config-file

	if ($regexString=browseDirectory($directory)) {	    
	    /*while(false !== ($entry = readdir($handle))) 
	    {
	        if ($entry != "." && $entry != "..") $regexString.=$entry.' ';	        
	    }
	    closedir($handle);*/

		$pattern = "/(\\w*)L|R(\\d*).dbl/"; 
		
		//check if surround
		if ($ini_array[CHANNELS]==4) {
			$pattern = "/(\\w*)SL|R(\\d*).dbl/";
		}

		preg_match_all($pattern, $regexString,$banks); // in $banks[1] Coeffset-Name
		$out='<select name="coeff'.$id.'">';
		if($ini_array[COEFF_NAME.$id]!="" || !empty($ini_array[COEFF_NAME.$id]))$out .= '<option selected>'.$ini_array[COEFF_NAME.$id].'</option>';
		else $out.= '<option selected>BypassFilter</option>';
		for ($i=0; $i < count($banks[1]); $i++) {
			if(!empty($banks[1][$i])) $out.='<option>'.$banks[1][$i].'</option>';
		}
		$out.='</select>';
		return $out;
	}
	
}

//Browse Directory and return array
function browseDirectory($directory)
{
	if ($handle = opendir($directory)) {	    
	    while(false !== ($entry = readdir($handle))) 
	    {
	        if ($entry != "." && $entry != "..") $dirArr.=$entry.' ';	        
	    }
	    closedir($handle);
	    return $dirArr;	
	}
	else return null;
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

// PHP aktiver Filter für Filterset
function activeFilter() 
{
	if(isset($_GET[filter]))
	{
		switchFilter($_GET[filter]);
		return $activeFilter = $_GET[filter];
	}
	else
	{
		return $activeFilter = getFilter();
	}
}
//Filter-Control
function print_filterset($count,$ini_array)
{
	//$out='<fieldset>';
	for ($i=0;$i<$count; $i++) {
		if($GLOBALS["lang"]=='en')
		{
			if(activeFilter()==$i)
			{
				$out.='Bank '.($i).' <button type="submit" style="color:red" name="bank" value="'.$i.'"> Active </button> ';	
			}
			else
			{
				$out.='Bank '.($i).' <button type="submit" name="bank" value="'.$i.'"> Select </button> ';	
			}
			
			$out.=' Note: <input type="text" name=comm'.$i.' value="'.$ini_array[COEFF_COMMENT.$i].'"/> ';
		}
		else
		{
			if(activeFilter()==$i)
			{
				$out.='Bank '.($i).' <button type="submit" style="color:red" name="bank" value="'.$i.'"> Aktiv </button>';
			}
			else
			{
				$out.='Bank '.($i).' <button type="submit" name="bank" value="'.$i.'"> Ausw&auml;hlen </button>';
			}
			$out.=' Notiz: <input type="text" name=comm'.$i.' value="'.$ini_array[COEFF_COMMENT.$i].'"/> ';
		} 
		$out.=	fltrSelect($i,$ini_array);
		$att=$ini_array[COEFF_ATT.$i]*-1;
		if($GLOBALS["lang"]=='en')$out.='<input type="text" name=vol'.$i.' class="volume" value="'.$att.'"> dB</br>';		
		else $out.='<input type="text" name=vol'.$i.' class="volume" value="'.$att.'"> dB</br>';
	}
	return $out;
}


// Validates volume from array
// if value is numeric set in ini_array
function validateAndSet($size, $arr, $ini_array)
{
	for ($i=0; $i < $size; $i++)
	{
		if(is_numeric($arr[vol.$i])){
			if (-90<$arr[vol.$i] && $arr[vol.$i]<=3) {
				//wrtToUserconfig('COEFF_ATT'.$i,(-1*$arr[vol.$i]));
                $ini_array['COEFF_ATT'.$i] = -1 * $arr[vol.$i];
			}
		}
		//wrtToUserconfig('COEFF_NAME'.$i,$arr[coeff.$i]);
        $ini_array['COEFF_NAME'.$i] = $arr[coeff.$i];
		//wrtToUserconfig('COEFF_COMMENT'.$i,$arr[comm.$i]);
        $ini_array['COEFF_COMMENT'.$i] = $arr[comm.$i];
	}
}


// Liest die Userconfig bis zur veraenderten Variable
// und schreibt sie in das File
// function wrtToUserconfig($varName,$value)
// {
// 	$value=strval($value);
// //	echo $varName.'="'.$value.'"';
// 	$shell_exec_ret=shell_exec('mount -o remount,rw /mnt/mmcblk0p1/');
// 	$file="/mnt/mmcblk0p1/userconfig.txt";
// 	$pattern='/'.$varName.'=\".*\"/';
// 	$content=file_get_contents($file);
// 	$content=preg_replace($pattern, $varName.'="'.$value.'"', $content);
// 	file_put_contents($file, $content);
// 	$shell_exec_ret=shell_exec('mount -o remount,ro /mnt/mmcblk0p1/');
// }

//Liest die Coeffsets ein und gibt die jeweilige Zurordnung 
//als Array zurueck
//Uebergabe: anzahl an Coeffsets

function readCoeffNamesFromBrutefir($sets)
{
	$file="/root/brutefir_config";
	$content=file_get_contents($file);
	for ($i=0; $i < $sets; $i++) { 
		$pattern='/coeff\"left'.$i.'\"{filename:\"\/mnt\/mmcblk0p1\/brutefir\/(\w*)(L|R)(\d*).dbl\"/';			
		preg_match($pattern, $content,$match);
		$results[$i]=$match[1];
	}
	return $results;	
}

/* Brutefir Funktionen:
 -switchfilter
 -getFilter
 -delay
 -togglemute
 -volcontrol
 -invertPhase
*/

function switchFilter($fltrBank)
{
	$cmd = '/root/brutefir/scripts/chgFilter'; //evtl als konstante auslagern
	$directory = '/home/sftparoio'; 
	$coeffSet0=2*$fltrBank;
	$coeffSet1=2*$fltrBank+1;
	$coeffSet2=2*$fltrBank+2;
	$coeffSet3=2*$fltrBank+3;
 	
 	//Channel 0
	shell_exec($cmd.' 0 '.$coeffSet0);
	//Channel 1
	shell_exec($cmd.' 1 '.$coeffSet1);
	if ($regexString=browseDirectory($directory)) {
		$pattern = "/".$fltrBank."S[L]|[R](\\d*).dbl/"; 
		if(preg_match_all($pattern, $regexString)>0){
			shell_exec($cmd.' 2 '.$coeffSet2);
			shell_exec($cmd.' 3 '.$coeffSet3);
		}
	}
}

//returns active filter set
function getFilter()
{
	$cmd='/root/brutefir/scripts/getFilter';
	$str=shell_exec($cmd);
	$str=strtok($str, ':');
	$out=strtok(':');
	return intval($out)/2;
}

function getVol()
{
	$cmd='/root/brutefir/scripts/getVol';
	$str=shell_exec($cmd);
	$str=strtok($str, '/');
	$out=strtok('/');
	return floatval($out);
 }

 function getDelay()
 {
 	$cmd='/root/brutefir/scripts/getDelay';
	$str=shell_exec($cmd);
	$str=strtok($str, ' ');
	$out=strtok(' ');
	return floatval($out);
 }

function chgDelay($fltrBank,$delay)
{
	$cmd = '/root/brutefir/scripts/chgDelay';
	shell_exec($cmd.' '.$fltrBank.' '.$delay);	
}

function tgglMute($channel)
{
	$cmd = '/root/brutefir/scripts/tgglMute';
	shell_exec($cmd.' '.$channel);
}

function isMuted()
{
	$str = shell_exec("echo 'lo' | nc localhost 3000 ");
	$re = "/muted/"; 
	preg_match($re, $str, $matches);

	if(isset($matches[0]))
	{
		if($matches[0] == "muted") return true;
	}
	else
	{
		return false;
	}

}

function volControl($ms,$attenuation)
{
	$cmd = '/root/brutefir/scripts/volControl '.$ms.' '.$attenuation;
	shell_exec($cmd);
}


function measurement()
{
	$cmd='/usr/bin/recordsweep';
	echo '<pre>' ;
		passthru($cmd) ;
	echo '</pre>' ;
}

function upload_measurement()
{
	$cmd='/usr/bin/scp /root/measurement.wav root:toor@127.0.0.1:/tmp/measurement.wav';
	shell_exec($cmd) ;
}

?>
