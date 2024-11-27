opcode kholasaLead, 0, iio

iNote, iUnison, iPartial xin

iMargin init 1/12
iNote += ( iUnison - 2 ) * iMargin

iAttack init 1/4096
iDecay init 1/16
iSustain init 1/64
iRelease init p3 - iAttack - iDecay

aNote = 0

kAmplitude adsr iAttack, iDecay, iSustain, iRelease
kAmplitude *= .5/iUnison

kFrequency linseg cpsmidinn ( iNote + 72 ), iAttack, cpsmidinn ( iNote + 36 ), iAttack, cpsmidinn ( iNote ), iRelease, cpsmidinn ( iNote - 1/4 )

aBody vco2 kAmplitude, kFrequency
aBody butterlp aBody, kFrequency

aNote += aBody

aModulator poscil 1, kFrequency
aDing poscil kAmplitude, kFrequency*2 * aModulator

aNote += aDing/2

aClip jspline .5, 0, 4
aClip += .5

aSkew jspline .5, 0, 4
aSkew += .5

aHighestShade squinewave a ( kFrequency * 8 ), aClip, aSkew
aHighestShade *= kAmplitude/2

aNote += aHighestShade

aHigherShade squinewave a ( kFrequency * 4 ), aClip, aSkew
aHigherShade *= kAmplitude/2

aNote += aHigherShade

aHighShade squinewave a ( kFrequency * 2 ), aClip, aSkew
aHighShade *= kAmplitude/2

aNote += aHighShade

kAmplitude adsr iAttack, iDecay/8, iSustain, iRelease
kAmplitude *= .5/iUnison

aRightShade poscil kAmplitude/4, kFrequency/4

aNote += aRightShade

aBass poscil kAmplitude/8, kFrequency/8

aNote += aBass

aRighterBass poscil kAmplitude/8, kFrequency/16

aNote += aRighterBass

aRighterBass poscil kAmplitude/8, kFrequency/32

aNote += aRighterBass

aRightestBass poscil kAmplitude/16, kFrequency/32

aNote += aRightestBass

aLeft, aRight pan2 aNote, 1/iUnison

outs aLeft, aRight

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

kholasaLead iNote, 2

endin

instr bass

aLeft, aRight subinstr "_bass", p4

outs aLeft/2, aRight/2

endin

instr _bass

iOctave init 48
iNote init giKey + iOctave + p4
p1 += iNote / 1000

kholasaLead iNote, 2

endin
