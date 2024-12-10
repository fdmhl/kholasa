instr tak

aLeft, aRight subinstr "_tak", p4

aLeft clip aLeft, 1, 1
aRight clip aRight, 1, 1

iDistance init 1.5

chnmix aLeft / iDistance, "left"
chnmix aRight / iDistance, "right"

endin

instr _tak

iOctave init 48
iNote init giKey + iOctave + p4
p1 += iNote / 1000

iAttack init 1/64
iDecay init 1/64 
iSustain init 1/32
iRelease init 1/32

p3 init iAttack + iDecay + iRelease

aMainSubAmplitude adsr iAttack, iDecay, iSustain, iRelease

aMainSubFrequency linseg cpsmidinn ( 48 + iNote ), iAttack/16, cpsmidinn ( iNote ), iRelease, cpsmidinn ( iNote - 2 )

aMainSub poscil aMainSubAmplitude, aMainSubFrequency

outs aMainSub, aMainSub

iHighSubSegment init 8

aHighSubAmplitude adsr iAttack / iHighSubSegment, iDecay / iHighSubSegment, iSustain, iRelease / iHighSubSegment
aHighSubFrequency linseg cpsmidinn ( 60 + iNote ), iAttack/8, cpsmidinn ( iNote + 12 ), iRelease, cpsmidinn ( iNote + 12 - 2 )

aHighSub poscil aHighSubAmplitude, aHighSubFrequency

outs aHighSub/4, aHighSub/4

aGogobell gogobel 1, cpsmidinn ( iNote + 48 ), .5, .5, giStrikeFT, 6.0, 0.3, giVibratoFT
aGogobellAmplitude linseg 1, p3, 0
aGogobell *= aGogobellAmplitude/2

outs aGogobell, aGogobell

aSnatchAmplitude linseg 0, iAttack/2, 1, iDecay/2, 0

aSnatchFrequency linseg cpsmidinn ( 120 + iNote ), iAttack/16, cpsmidinn ( 12 + iNote )

aSnatch noise aSnatchAmplitude, 0
aSnatch butterlp aSnatch, aSnatchFrequency

outs aSnatch, aSnatch

iNote = 96 + p4

aSagat tambourine 1, p3, 128, .5, 0, cpsmidinn ( iNote ), cpsmidinn ( iNote + 9 ), cpsmidinn ( iNote + 18 )

outs aSagat/8, aSagat/8

endin
