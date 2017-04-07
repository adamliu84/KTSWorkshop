<?php
// Run in terminal: php SpecialKHackathon.php to generate group picture
// with background. I WANT MY WATER BOTTLE!

$szSquadSrc = "./group.png";
function createImage($szBackground){
    global $szSquadSrc;

    // Modified image outcome filename
    $aTemp = pathinfo($szBackground);
    $szFilename = "NEW_".$aTemp['basename'];

    //Ref: http://stackoverflow.com/questions/2269363/put-png-over-a-jpg-in-php
    $png = imagecreatefrompng($szSquadSrc);
    $jpeg = imagecreatefromjpeg($szBackground);
    list($nBGwidth, $nBGheight) = getimagesize($szBackground);
    list($nSQwidth, $nSQheight) = getimagesize($szSquadSrc);
    $nDstY = $nBGheight - $nSQheight;
    $nDstX = $nBGwidth - $nSQwidth;
    $out = imagecreatetruecolor($nBGwidth, $nBGheight);
    imagecopyresampled($out, $jpeg, 0, 0, 0, 0, $nBGwidth, $nBGheight, $nBGwidth, $nBGheight);
    imagecopyresampled($out, $png, $nDstX, $nDstY, 0, 0, $nSQwidth, $nSQheight, $nSQwidth, $nSQheight);
    imagejpeg($out, './'.$szFilename);
}

$a = array('./background1.jpg', './background2.jpg', './background3.jpg', './background4.jpg');
array_map("createImage", $a);

?>
