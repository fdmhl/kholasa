sr = 48000
ksmps = 32
nchnls = 2
0dbfs = 1

giStrikeFT ftgen 0, 0, 256, 1, "prerequisites/marmstk1.wav", 0, 0, 0
giVibratoFT ftgen 0, 0, 128, 10, 1

instr dom
iPitch init iNote % 12

iNote ntom S ( p4 )

iAttack init 1/16
iDecay init 1/8 
iSustain init 1/4
iRelease init 1/2

p3 init iAttack + iDecay + iRelease

aMainSubAmplitude adsr iAttack, iDecay, iSustain, iRelease
aMainSubFrequency linseg cpsmidinn ( iNote ), iAttack, cpsmidinn ( 24 + iPitch )

aMainSub poscil aMainSubAmplitude, aMainSubFrequency

chnmix aMainSub, "dom"

iHighSubSegment init 8

aHighSubAmplitude adsr iAttack / iHighSubSegment, iDecay / iHighSubSegment, iSustain, iRelease / iHighSubSegment
aHighSubFrequency linseg cpsmidinn ( 24 + iNote ), iAttack/2, cpsmidinn ( 48 + iPitch )

aHighSub poscil aHighSubAmplitude, aHighSubFrequency

chnmix aHighSub / iHighSubSegment, "dom"

aGogobell gogobel 1, cpsmidinn ( 24 + iPitch ), .5, .5, giStrikeFT, 6.0, 0.3, giVibratoFT

aNote += aGogobell / 4

aSnatchAmplitude linseg 0, iAttack/8, 1, iDecay/8, 0
aSnatchFrequency linseg cpsmidinn ( 10 + iNote ), iAttack/2, cpsmidinn ( 9 + iNote )

aSnatch noise aSnatchAmplitude, 0
aSnatch butterlp aSnatch, aSnatchFrequency

aNote += aSnatch*4

endin

instr out

STrack strget p4
SLeft strcat STrack, "/left"
SRight strcat STrack, "/right"

aLeft chnget SLeft
aRight chnget SRight

outs aLeft, aRight

chnclear SLeft
chnclear SRight

endin
