<?php

// Ping Squeeze-Server
function ping_squeezeserver($target)
{
	exec("ping -c1 $target" , $output , $return_var);
	return $return_var;
}

$test=ping_squeezeserver("192.168.20.123");
if ($test == 0) echo "null";
echo $test;

?>
