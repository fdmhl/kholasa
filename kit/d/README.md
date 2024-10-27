#!/usr/bin/env roll

# Faddy's Dom/Kick Synthesizer

?# cd .workshop ; if [ ! -d node_modules/@faddys/scenarist ]; then npm i @faddys/scenarist ; fi

?# cat - > .workshop/index.orc

+==

sr = 48000
ksmps = 32
nchnls = 2
0dbfs = 1

giStrikeFT ftgen 0, 0, 256, 1, "prerequisites/marmstk1.wav", 0, 0, 0
giVibratoFT ftgen 0, 0, 128, 10, 1

instr 1, 2

aNote = 0

iPitch init p4/p5

iAttack init 1/32
iDecay init 1/8 
iRelease init 1/2

p3 init iAttack + iDecay + iRelease

aMainSubAmplitude linseg 0, iAttack, 1, iDecay, .25, iRelease, 0
aMainSubFrequency linseg cpsoct ( 8 + iPitch ), iAttack, cpsoct ( 5 + iPitch )

aMainSub poscil aMainSubAmplitude, aMainSubFrequency

aNote += aMainSub

aHighSubAmplitude linseg 0, iAttack/8, 1, iDecay/8, .25, iRelease/8, 0
aHighSubFrequency linseg cpsoct ( 10 + iPitch ), iAttack/2, cpsoct ( 7 + iPitch )

aHighSub poscil aHighSubAmplitude, aHighSubFrequency

aNote += aHighSub / 8

aGogobell gogobel 1, cpsoct ( 5 + iPitch ), .5, .5, giStrikeFT, 6.0, 0.3, giVibratoFT

aNote += aGogobell / 4

aSnatchAmplitude linseg 0, iAttack/8, 1, iDecay/8, 0
aSnatchFrequency linseg cpsoct ( 10 + iPitch ), iAttack/2, cpsoct ( 9 + iPitch )

aSnatch noise aSnatchAmplitude, 0
aSnatch butterlp aSnatch, aSnatchFrequency

aNote += aSnatch*4

aNote clip aNote, 1, 1

outch p1, aNote

endin

-==

?# cat - > .workshop/index.mjs

+==

const degrees = parseInt ( process .argv .slice ( 2 ) .shift () ) || 100;

for ( let step = 0; step < degrees; step++ ) {

let index = ( step / 100 ) .toString () .slice ( 2 );

index += '0' .repeat ( 2 - index .length );

let score = `.workshop/sco/${ index }.sco`;
let audio = index + '.wav';

console .log ( [

`echo "i 1 0 1 ${ step } ${ degrees }" > ${ score }`,
`echo "i 2 0 1 ${ step + degrees/4 } ${ degrees }" >> ${ score }`,
`csound -3 -o ${ audio } .workshop/index.orc ${ score }`

] .join ( ' ; ' ) );

}

-==

?# cd .workshop ; rm -fr index.sh sco ; mkdir sco
?# rm -f *.wav
?# $ cd .workshop ; node index.mjs >> index.sh
?# -1 -2 bash .workshop/index.sh
?# -1 -2 aplay *.wav
