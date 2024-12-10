instr sak

aLeft, aRight subinstr "_sak", p4

outs aLeft/2, aRight/2

endin

instr _sak

iOctave init 60
iNote init giKey + iOctave + p4
p1 += iNote / 1000

iAttack init 1/128
iDecay init 1/128 
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

aGogobell gogobel 1, cpsmidinn ( iNote ), .5, .5, giStrikeFT, 6.0, 0.3, giVibratoFT
aGogobellAmplitude linseg 1, p3, 0
aGogobell *= aGogobellAmplitude/4

outs aGogobell, aGogobell

aSnatchAmplitude linseg 0, iAttack, 1, iDecay, 0
aSnatchFrequency linseg cpsmidinn ( 84 + iNote ), iAttack/2, cpsmidinn ( 12 + iNote )

aSnatch noise aSnatchAmplitude, 0
aSnatch butterlp aSnatch, aSnatchFrequency

outs aSnatch/2, aSnatch/2

endin
