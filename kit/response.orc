opcode kholasaResponse, 0, io

iNote, iDistance xin

aClip chnget "responseClip"
aSkew chnget "responseSkew"

iAttack init p3/8
iDecay init iAttack/2
iSustain init 1/16
iRelease init p3 - iAttack - iDecay

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

kSpace jspline .5, 0, 4
kSpace += .5

p3 += 1

aLeftReverb, aRightReverb freeverb aLeft, aRight, kSpace, kSpace

chnmix aLeft, "left"
chnmix aRight, "right"

chnmix aLeftReverb/8, "left"
chnmix aRightReverb/8, "right"

endin

giOctave init 72

instr _response

iNote init giOctave + giKey + p4

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

endin

schedule "_responseController", 0, -1
