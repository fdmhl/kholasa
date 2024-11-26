opcode kholasaLead, 0, ii

iNote, iUnison xin

iMargin init 1/12
iNote += ( iUnison - 2 ) * iMargin

iAttack init 1/512
iDecay init 1/8
iSustain init 1/32
iRelease init p3 - iAttack - iDecay

kAmplitude adsr iAttack, iDecay, iSustain, iRelease
kAmplitude *= .5/iUnison

kFrequency linseg cpsmidinn ( iNote + 24 ), iAttack, cpsmidinn ( iNote + 12 ), iAttack, cpsmidinn ( iNote ), iRelease, cpsmidinn ( iNote - 1/4 )

aNote vco2 kAmplitude, kFrequency
aNote butterlp aNote, kFrequency

outs aNote, aNote

aModulator poscil 1, kFrequency
aNote poscil kAmplitude, kFrequency*2 * aModulator

outs aNote/2, aNote/2

aClip jspline .5, 0, 4
aClip += .5

aSkew jspline .5, 0, 4
aSkew += .5

aNote squinewave a ( kFrequency * 8 ), aClip, aSkew
aNote *= kAmplitude/2

outs aNote, aNote

aNote squinewave a ( kFrequency * 4 ), aClip, aSkew
aNote *= kAmplitude/2

outs aNote, aNote

aNote squinewave a ( kFrequency * 2 ), aClip, aSkew
aNote *= kAmplitude/2

outs aNote, aNote

aNote poscil kAmplitude/8, kFrequency/4

outs aNote, aNote

aNote poscil kAmplitude/4, kFrequency/8

outs aNote, aNote

if iUnison > 2 then

kholasaLead iNote, iUnison - 2

endif

endop

instr lead

aLeft, aRight subinstr "_lead", p4

outs aLeft, aRight

endin

instr _lead

iOctave init 84
iNote init giKey + iOctave + p4
p1 += iNote / 1000

kholasaLead iNote, 6

endin
