instr dom

aLeft, aRight subinstr "_dom", p4

outs aLeft/2, aRight/2

endin

instr _dom

iOctave init 36
iNote init giKey + iOctave + p4
p1 += iNote / 1000

iAttack init 1/16
iDecay init 1/8 
iSustain init 1/64
iRelease init p3 - iAttack - iDecay

aMainSubAmplitude adsr iAttack, iDecay, iSustain, iRelease

aMainSubFrequency linseg cpsmidinn ( 36 + iNote ), iAttack/2, cpsmidinn ( iNote ), iRelease, cpsmidinn ( iNote - 2 )

aMainSub poscil aMainSubAmplitude, aMainSubFrequency

outs aMainSub, aMainSub

iHighSubSegment init 8

aHighSubAmplitude adsr iAttack / iHighSubSegment, iDecay / iHighSubSegment, iSustain, iRelease / iHighSubSegment

aHighSubFrequency linseg cpsmidinn ( 48 + iNote ), iAttack/2, cpsmidinn ( iNote + 12 ), iRelease, cpsmidinn ( iNote + 12 - 2 )

aHighSub poscil aHighSubAmplitude, aHighSubFrequency

outs aHighSub/4, aHighSub/4

aGogobell gogobel 1, cpsmidinn ( iNote ), .5, .5, giStrikeFT, 6.0, 0.3, giVibratoFT

outs aGogobell, aGogobell

aSnatchAmplitude linseg 0, iAttack/8, 1, iDecay/8, 0
aSnatchFrequency linseg cpsmidinn ( 84 + iNote ), iAttack/2, cpsmidinn ( 12 + iNote )

aSnatch noise aSnatchAmplitude, 0
aSnatch butterlp aSnatch, aSnatchFrequency

outs aSnatch/2, aSnatch/2

endin
