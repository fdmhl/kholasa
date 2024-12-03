#include "maqam.sco"

#include "rhythms/tempo.sco"

#include "rhythms/questioning1.sco"
#include "rhythms/questioning2.sco"
#include "rhythms/questioning3.sco"

#include "rhythms/response1.sco"
#include "rhythms/response2.sco"

#include "rhythms/response1.sco"
#include "rhythms/response2.sco"

$tempo

i "lead" 0 8 $lG

i "response" 0 8 $lG
i "response" 0 [1/2] $C

b 4
#include "rhythms/tempoGuide.sco"

s 8

$tempo

#include "rhythms/maqsumBass.sco"
#include "rhythms/maqsum.sco"
b 4
#include "rhythms/maqsumBass.sco"
#include "rhythms/maqsum.sco"

s 8
