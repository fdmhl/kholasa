instr dom

aLeft, aRight subinstr "_dom", p4

aLeft clip aLeft, 1, 1
aRight clip aRight, 1, 1

iDistance init 1.5

chnmix aLeft / iDistance, "left"
chnmix aRight / iDistance, "right"

endin

instr _dom

iOctave init 24
iNote init giKey + iOctave + p4
p1 += iNote / 1000

iAttack init 1/16
iDecay init 1/8 
iSustain init 1/32
iRelease init p3 - iAttack - iDecay

aMainSubAmplitude adsr iAttack, iDecay, iSustain, iRelease

aMainSubFrequency linseg cpsmidinn ( iNote + 48 ), iAttack/2, cpsmidinn ( iNote + 12 ), iRelease, cpsmidinn ( iNote - 2 )

aMainSub poscil aMainSubAmplitude, aMainSubFrequency

outs aMainSub, aMainSub

iHighSubSegment init 16

aHighSubAmplitude adsr iAttack / iHighSubSegment, iDecay / iHighSubSegment, 0, iRelease / iHighSubSegment

aHighSubFrequency linseg cpsmidinn ( 48 + iNote ), iAttack / iHighSubSegment, cpsmidinn ( iNote + 36 ), iRelease, cpsmidinn ( iNote + 12 - 2 )

aHighSub poscil aHighSubAmplitude, aHighSubFrequency

outs aHighSub/2, aHighSub/2

iHighSubSegment init 8

aHighSubAmplitude adsr iAttack / iHighSubSegment, iDecay / iHighSubSegment, 0, iRelease / iHighSubSegment

aHighSubFrequency linseg cpsmidinn ( 48 + iNote ), iAttack / iHighSubSegment, cpsmidinn ( iNote + 36 ), iRelease, cpsmidinn ( iNote + 24 - 2 )

aHighSub poscil aHighSubAmplitude, aHighSubFrequency

outs aHighSub, aHighSub

aGogobell gogobel 1, cpsmidinn ( iNote + 12 ), .5, .5, giStrikeFT, 6.0, 0.3, giVibratoFT

outs aGogobell, aGogobell

aSnatchAmplitude linseg 0, iAttack/2, 1, iDecay/2, 0

aSnatchFrequency linseg cpsmidinn ( 96 + iNote ), iAttack/8, cpsmidinn ( iNote )

aSnatch noise aSnatchAmplitude, 0
aSnatch butterlp aSnatch, aSnatchFrequency

outs aSnatch, aSnatch

iNote = 108 + p4

aSagat tambourine 1, p3, 128, .5, 0, cpsmidinn ( iNote ), cpsmidinn ( iNote + 9 + p5 ), cpsmidinn ( iNote + 18 )

outs aSagat/8, aSagat/8

endin
