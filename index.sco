#include "kit/index.mac"
#include "maqam.sco"

#include "rhythms/tempo.sco"

m intro

$tempo

#include "rhythms/tempoGuide.sco"

s 4

$tempo

#include "rhythms/oneTwo.sco"
#include "rhythms/riseLow1.sco"

s 4

$tempo

#include "rhythms/oneTwo.sco"
#include "rhythms/riseLow2.sco"

s 4

$tempo

#include "rhythms/oneTwo.sco"
#include "rhythms/riseHigh1.sco"

s 4

$tempo

#include "rhythms/oneTwo.sco"
#include "rhythms/riseHigh2.sco"

s 4

$tempo

#include "rhythms/oneTwo.sco"

v [1/2]

#define octave #7#

i [ $pluck + .2 ] 1 2 $C
i . + 1 $C
i . + . $D
i . + . $E
i . + . $F
i . + . $E

s 4

$tempo

#include "rhythms/oneTwo.sco"

v [1/2]

#define octave #7#

i [ $pluck + .2 ] 0 2 $D
i . 3 1 $C
i . + 2 $E
i . 7 1 $C


s 4

$tempo

#include "rhythms/oneTwo.sco"

#define octave #7#

v [1/2]

i [ $pluck + .2 ] 0 2 $D

#define octave #6#

i . 4 2 $B
i . + 2 $A

s 4

$tempo

#include "rhythms/oneTwo.sco"

v [1/2]

#define octave #6#

i [ $pluck + .2 ] 0 2 $B
i . + 1 $A

i . 4 2 $G

;i . + 1 $A

s 4

$tempo

#include "rhythms/oneTwo.sco"

#define octave #6#

i [ $pluck + .2 ] 0 2 $G

;i . + 1 $A
i . 4 2 $G

s 4

$tempo

#include "rhythms/oneTwo.sco"

v [1/2]

#define octave #6#

i [ $pluck + .2 ] 0 4 $F
i . + 2 $G

i . + 1 $C
i . + . $F

s 4

$tempo

#include "rhythms/oneTwo.sco"

v [1/2]

#define octave #6#

i [ $pluck + .2 ] 0 2 $G

i . + 1 $E
i . + . $E
i . + 2 $C

s 4

n intro
