opcode kholasaResponse, 0, io

iNote, iDistance xin

aClip chnget "responseClip"
aSkew chnget "responseSkew"

iDuration init abs ( p3 )

iAttack init iDuration/8
iDecay init iAttack/2
iSustain init 1/16
iRelease init iDuration - iAttack - iDecay

aAmplitude adsr iAttack, iDecay, iSustain, iRelease
aAmplitude *= 1 / ( iDistance + 1 )


iFrequencyShift init 2048

aFrequencyModulator jspline 1, 0, 4
aFrequency linseg cpsmidinn ( iNote - 12 ), iAttack / iFrequencyShift, cpsmidinn ( iNote + 2.25 ), iDecay / iFrequencyShift, cpsmidinn ( iNote ), iRelease, cpsmidinn ( iNote - .25 )
aFrequency *= cent ( aFrequencyModulator * 10 )

aNote squinewave aFrequency, aClip, aSkew

aNote butterlp aNote, aFrequency

aNote *= aAmplitude

outs aNote, aNote

aNote vco2 k ( aAmplitude ), k ( aFrequency ), 10

aNote butterlp aNote, aFrequency

;outs aNote/2, aNote/2

endop

instr response

aLeft, aRight subinstr "_response", p4

chnmix aLeft, "responseLeft"
chnmix aRight, "responseRight"

endin

instr _response

iOctave init 72
iNote init iOctave + giKey + p4

kholasaResponse iNote + 36, 8
kholasaResponse iNote + 24, 4
kholasaResponse iNote + 12, 2
kholasaResponse iNote, 1
kholasaResponse iNote - 12, 2
kholasaResponse iNote - 24, 4

chnclear "responseClip"
chnclear "responseSkew"
chnclear "responseFilter"

endin

instr _responseController

aClip jspline .5, 0, 4
aClip += .5

chnmix aClip, "responseClip"

aSkew jspline .5, 0, 4
aSkew += 1

chnmix aSkew, "responseSkew"

aLeft chnget "responseLeft"
aRight chnget "responseRight"

kSpace jspline .5, 0, 4
kSpace += .5

aLeftReverb, aRightReverb freeverb aLeft, aRight, kSpace, kSpace

iReverb init 8

aLeft += aLeftReverb / iReverb
aRight += aRightReverb / iReverb

aLeft clip aLeft, 1, 1
aRight clip aRight, 1, 1

iDistance init 2

chnmix aLeft / iDistance, "left"
chnmix aRight / iDistance, "right"

chnclear "responseLeft"
chnclear "responseRight"

endin

schedule "_responseController", 0, -1
