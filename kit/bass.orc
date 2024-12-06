opcode kholasaBass, 0, iiio

iNote, iDistance, iUnison, iPartial xin

iMargin init 1/12
iNote += ( iUnison - 2 ) * iMargin

iAttack init 1/4096
iDecay init iAttack*128
iSustain init 1/32
iRelease init p3 - iAttack - iDecay

aClip chnget "bassClip"
aSkew chnget "bassSkew"

aAmplitude adsr iAttack, iDecay, iSustain, iRelease
aAmplitude *= .5/iUnison * 1 / iDistance

iShift init 1/1

aFrequency linseg cpsmidinn ( iNote + 120 ), iAttack / iShift, cpsmidinn ( iNote + 36 ), iAttack / iShift, cpsmidinn ( iNote ), iRelease, cpsmidinn ( iNote - 1/4 )

aBody squinewave aFrequency, aClip, aSkew
aBody *= aAmplitude
aBody butterlp aBody, aFrequency/3

outs aBody, aBody

aDing squinewave aFrequency*2, aClip, aSkew
aDing *= aAmplitude/2

outs aDing, aDing

aDing squinewave aFrequency * 8, aClip, aSkew
aDing *= aAmplitude/2

outs aDing, aDing

aDing squinewave aFrequency * 16, aClip, aSkew
aDing *= aAmplitude/4

outs aDing, aDing

;aBass squinewave aFrequency/2, aClip, aSkew
;aBass *= aAmplitude/2

aBass poscil aAmplitude/2, aFrequency/2

outs aBass, aBass

aBass poscil aAmplitude/2, aFrequency/4

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

aLeft clip aLeft, 1, 1
aRight clip aRight, 1, 1

iDistance init 4

chnmix aLeft / iDistance, "left"
chnmix aRight / iDistance, "right"

chnclear "bassLeft"
chnclear "bassRight"

endin

schedule "_bassController", 0, -1

instr _bass

iOctave init 36
iNote init giKey + iOctave + p4
p1 += iNote / 1000

kholasaBass iNote + 12, 1, 2
kholasaBass iNote, 1, 2
kholasaBass iNote - 12, 2, 2
kholasaBass iNote - 24, 4, 2
kholasaBass iNote - 36, 8, 2

endin
