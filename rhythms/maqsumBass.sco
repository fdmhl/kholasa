v [1/4]

#define chordDelay #.0125#
#define chord(instrument'start'duration'note1'note2'note3) #i "$instrument" $start $duration $note1
i . [ $start + $chordDelay ] . $note2
i . [ $start + $chordDelay ] . $note3#

#define bass_C(start) #$chord(bass'$start'1'$C'$E'$G)#
#define bass_lC(start) #$chord(bass'$start'1'$lC'$lE'$lG)#

#define bass_G(start) #$chord(bass'$start'1'$G'$B'$hC)#
#define bass_lG(start) #$chord(bass'$start'1'$lG'$lB'$C)#

$bass_lC(0)
$bass_lC(8)

$bass_lG(2)
$bass_lG(6)
$bass_lG(12)

$bass_C(4)
$bass_G(5)

$bass_C(10)
$bass_G(11)

$bass_C(14)
$bass_G(15)
