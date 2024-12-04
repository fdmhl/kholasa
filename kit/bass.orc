opcode kholasaBass, 0, iiio

iNote, iDistance, iUnison, iPartial xin

iMargin init 1/12
iNote += ( iUnison - 2 ) * iMargin

iAttack init 1/2048
iDecay init 1/16
iSustain init 1/16
iRelease init p3 - iAttack - iDecay

kAmplitude adsr iAttack, iDecay, iSustain, iRelease
kAmplitude *= .5/iUnison * 1 / iDistance

kFrequency linseg cpsmidinn ( iNote + 72 ), iAttack/8, cpsmidinn ( iNote + 36 ), iAttack, cpsmidinn ( iNote ), iRelease, cpsmidinn ( iNote - 1/4 )

aBody vco2 kAmplitude, kFrequency
aBody butterlp aBody, kFrequency

outs aBody, aBody

aModulator poscil 1, kFrequency
aDing poscil kAmplitude, kFrequency*2 * aModulator

outs aDing, aDing

aClip chnget "bassClip"
aSkew chnget "bassSkew"

aShade squinewave a ( kFrequency * 8 ), aClip, aSkew
aShade *= kAmplitude/2

outs aShade, aShade

aBass poscil kAmplitude/8, kFrequency/8

outs aBass, aBass

if iUnison > 2 then

kholasaBass iNote, iDistance, iUnison - 2

endif

endop

instr bass

aLeft, aRight subinstr "_bass", p4

chnmix aLeft, "bassLeft"
chnmix aRight, "bassRight"

chnclear "bassClip"
chnclear "bassSkew"

endin

instr _bassController

aClip jspline .5, 0, 4
aClip += .5

aSkew jspline .5, 0, 4
aSkew += .5

chnmix aClip, "bassClip"
chnmix aSkew, "bassSkew"

aLeft chnget "bassLeft"
aRight chnget "bassRight"

kSpace jspline .5, 0, 4
kSpace += .5

aLeftReverb, aRightReverb freeverb aLeft, aRight, kSpace/64, kSpace

iReverb init 64

aLeft += aLeftReverb / iReverb
aRight += aRightReverb / iReverb

aLeft clip aLeft, 1, 1
aRight clip aRight, 1, 1

iDistance init 1

chnmix aLeft / iDistance, "left"
chnmix aRight / iDistance, "right"

chnclear "bassLeft"
chnclear "bassRight"

endin

schedule "_bassController", 0, -1

instr _bass

iOctave init 24
iNote init giKey + iOctave + p4
p1 += iNote / 1000

kholasaBass iNote, 1, 2
kholasaBass iNote - 12, 2, 2
kholasaBass iNote - 24, 4, 2
kholasaBass iNote - 36, 8, 2

endin
