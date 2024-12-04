$tempo

#include "rhythms/maqsum.sco"
#include "rhythms/maqsumBass.sco"
b 4
#include "rhythms/maqsum.sco"
#include "rhythms/maqsumBass.sco"

v [1/2]
b 0
i "response" 0 [1/2] $C
i . + .

i . 7 [1/2] $lF
i . + .
i . + . $lG
i . + .

i . 15 . $lF
i . + .

#include "rhythms/riseLow.sco"

s 8

$tempo

#include "rhythms/maqsum.sco"
#include "rhythms/maqsumBass.sco"
b 4
#include "rhythms/maqsum.sco"
#include "rhythms/maqsumBass.sco"

v [1/2]
b 0
i "response" 7 [1/2] $lB
i . + .
i . + . $C
i . + .

i "response" 0 [1/2] $G
i . + .
i . 15 . $lB
i . + .

#include "rhythms/riseHigh.sco"

s 8
