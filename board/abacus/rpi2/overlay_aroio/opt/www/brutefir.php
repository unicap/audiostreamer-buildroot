<?php
		include('strings.php');
        include('functions.inc.php');
        include('style.css');
		if($_GET["lang"] === "en" || $_POST[lang]=='en') 
		{
			$lang='en';
			$GLOBALS["lang"]='en';
		} 
		else
		{
			$lang='de';
			$GLOBALS["lang"]='de';
		}
		// Load ini-array from userconfig
		$ini_array = parse_ini_file("/etc/aroio/userconfig", 1);
		
		/* Save Configuration and reload 
		 * */
		/*
		if(isset($_POST[save]))
		{
			$savedVol=getVol();
			for ($i=0; $i < 10; $i++) { 
				wrtToUserconfig('COEFF_NAME'.$i,$_POST[coeff.$i]);
				wrtToUserconfig('COEFF_COMMENT'.$i,$_POST[comm.$i]);
			}
			wrtToUserconfig('COEFF_ATT'.$_POST[savedbank],getVol());
			wrtToUserconfig('DEF_COEFF',$_POST[savedbank]);
			shell_exec('/etc/init.d/brutefir reload &> /dev/null ' );

			if ($ini_array[MSCODING]=='ON') {
				volControl(1,$savedVol);
			}
			else {
				volControl(0,$savedVol);
			}			
		}*/

		if(isset($_POST[set]))
		{
			$savedbank=$_POST[savedbank];
			validateAndSet(10, $_POST, $ini_array);
			// wrtToUserconfig('DEF_COEFF',$_POST[savedbank]);
            $ini_array[DEF_COEFF] = $_POST[savedbank];
			if ($ini_array[MSCODING]=='ON') {
				volControl(1,($_POST[vol.$savedbank])*-1);
			}
			else {
				volControl(0,($_POST[vol.$savedbank])*-1);
			}
		}

		if(isset($_POST[save]))
		{
			$savedbank=$_POST[savedbank];
			validateAndSet(10,$_POST, $ini_array);
			// wrtToUserconfig('DEF_COEFF',$_POST[savedbank]);
            $ini_array[DEF_COEFF] = $_POST[savedbank];
			shell_exec('/etc/init.d/brutefir reload &> /dev/null ' );
			if ($ini_array[MSCODING]=='ON') {
				volControl(1,$_POST[vol.$savedbank]);
			}
			else {
				volControl(0,$_POST[vol.$savedbank]);
			}
		}
		

		// Switch filter bank
		if(isset($_POST[bank]))
		{
			switchFilter($_POST[bank]);
			$activeFilter = $_POST[bank];

			// Check if MSCODING is on
			if ($ini_array[MSCODING]=='ON') {
				volControl(1,$ini_array[COEFF_ATT.$activeFilter]);
			}
			else {
				volControl(0,$ini_array[COEFF_ATT.$activeFilter]);
			}
		}
		else
		{
			$activeFilter = getFilter();
		  	if(isset($_POST[save])){
				if($ini_array[MSCODING]=='ON') {
                                	volControl(1,$ini_array[COEFF_ATT.$activeFilter]);
             	}
                        	else {
                                	volControl(0,$ini_array[COEFF_ATT.$activeFilter]);
                        	}
			}
		}
			
		// Mute channels
		if(isset($_POST[mute]))
		{
			tgglMute(0);
			tgglMute(1);
		}
		
		// LOUDER !!
		if(isset($_POST[volPlus]))
		{
			$actVol=getVol();
			$actVol-=0.5;
			//if($ini_array[MSCODING]=='ON')
			//{
			//	volControl(1,$actVol);
			//}
			//else
			//{
				volControl(0,$actVol);
			//}
			$ini_array[COEFF_ATT.$activeFilter]=$actVol;
			
		}
		
		// less louder ... 
		if(isset($_POST[volMinus]))
		{
			$actVol=getVol(); //auslesen
			$actVol+=0.5;	//setzen
            //if($ini_array[MSCODING]=='ON')
     	//	{
          //  	volControl(1,$actVol);                       
           // }
            //else
            //{
                volControl(0,$actVol);
            //}
			$ini_array[COEFF_ATT.$activeFilter]=$actVol; //ins array
		}
    write_php_ini($ini_array, "/etc/aroio/userconfig");
?>
<html>
    <meta name="viewport" content="width=615, initial-scale=1">
	<head>
		<title> <? print ${title_brutefir._.$lang}; ?> </title>
	</head>
    
		<a href="http://www.abacus-electronics.de" target="_blank"><img src="abacus_logo_wide.png" border="0"></a>
	<body>
		<br><a href="<?php echo $PHP_SELF?>?lang=en" target=""><img src="english.png" border="0"></a>
            <a href="<?php echo $PHP_SELF?>?lang=de" target=""><img src="german.png" border="0"></a>
            <a href="index.php" target=""><? print ${linktext_configuration._.$lang} ?></a>
            <a href="system.php" target=""><? print ${linktext_system._.$lang} ?></a>
	    <a href="measurement.php" target=""><? print ${linktext_measurement._.$lang} ?></a>
            <? if ($ini_array['BRUTEFIR'] == "ON"){?>
				<a href="brutefir.php"target=""><? print ${linktext_brutefir._.$lang} ?></a> <?
			}?>
		<h1> <? print ${page_title_convolver._.$lang} ; if ( isset($_POST['submit'])) print $_POST['HOSTNAME']; else print $ini_array["HOSTNAME"] ?></h1>
		<div class="fltrSelect">
			<form action="<?echo $_SERVER['PHP_SELF'] ?>" method="post">
  				<fieldset>
  					<legend><? print ${convolution_filterselection._.$lang} ?></legend>
					<?echo print_filterset(10,$ini_array)?>
				</fieldset>
				<input type="hidden" name="actVol" value="<?echo getVol()?>">
				<input type="hidden" name="lang" value="<?echo $lang?>">
				<input type="hidden" name="savedbank" value="<?echo $activeFilter?>">
				<button type="submit" name="save" title="<? print ${helptext_bf_button_savereload._.$lang} ?>"><? print ${button_savefilter._.$lang}?></button>
				<button type="submit" name="set" title="<? print ${helptext_bf_button_setcoeffs._.$lang} ?>"><? print ${button_setcoeffs._.$lang}?></button>
				<button type="submit" <?if(isMuted()) echo 'style="color:red"'; else echo 'style="color:green"';?> name="mute" value="1"><? print ${button_mute._.$lang}?></button>
			</form>
		</div>
		<div class="content">
			<? print ${helptext_bf._.$lang} ;?>
		</div>
	</body>
</html>
