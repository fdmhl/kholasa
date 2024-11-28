instr tak

aLeft, aRight subinstr "_tak", p4

chnmix aLeft/1.5, "left"
chnmix aRight/1.5, "right"

endin

instr _tak

iOctave init 48
iNote init giKey + iOctave + p4
p1 += iNote / 1000

iAttack init 1/64
iDecay init 1/64 
iSustain init 1/32
iRelease init 1/16

p3 init iAttack + iDecay + iRelease

aMainSubAmplitude adsr iAttack, iDecay, iSustain, iRelease
aMainSubFrequency linseg cpsmidinn ( 48 + iNote ), iAttack/2, cpsmidinn ( iNote ), iRelease, cpsmidinn ( iNote - 2 )

aMainSub poscil aMainSubAmplitude, aMainSubFrequency

outs aMainSub, aMainSub

iHighSubSegment init 8

aHighSubAmplitude adsr iAttack / iHighSubSegment, iDecay / iHighSubSegment, iSustain, iRelease / iHighSubSegment
aHighSubFrequency linseg cpsmidinn ( 60 + iNote ), iAttack/2, cpsmidinn ( iNote + 12 ), iRelease, cpsmidinn ( iNote + 12 - 2 )

aHighSub poscil aHighSubAmplitude, aHighSubFrequency

outs aHighSub/4, aHighSub/4

aGogobell gogobel 1, cpsmidinn ( iNote + 24 ), .5, .5, giStrikeFT, 6.0, 0.3, giVibratoFT
aGogobellAmplitude linseg 1, p3, 0
aGogobell *= aGogobellAmplitude/2

outs aGogobell, aGogobell

aSnatchAmplitude linseg 0, iAttack, 1, iDecay, 0
aSnatchFrequency linseg cpsmidinn ( 84 + iNote ), iAttack/2, cpsmidinn ( 12 + iNote )

aSnatch noise aSnatchAmplitude, 0
aSnatch butterlp aSnatch, aSnatchFrequency

outs aSnatch/2, aSnatch/2

endin
