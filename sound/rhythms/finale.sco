$tempo

#include "rhythms/maqsum.sco"
#include "rhythms/maqsumBass.sco"
b 4
#include "rhythms/maqsum.sco"
#include "rhythms/maqsumBass.sco"

b 0

v [1/2]

i "lead" 0 4 $lG
i . 6 2 $F
i . + . $G
i . 14 . $D
i . + . $C

i "response" 0 1 $lf
i . + [1/2] $lG
i . + .

{ 8 beat

v [1/4]

i "response" [ 2 + $beat ] [1/2] $lC
i . + . $lG

}

v [1/2]

i "response" 6 2 $lG

s 8
