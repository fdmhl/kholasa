opcode kholasaDrone, 0, i

iNote xin

aClip chnget "droneClip"
aSkew chnget "droneSkew"

iBar init abs ( p3 )
iAttack init iBar/64
iDecay init iBar - iAttack
iSustain init 1/16
iRelease init iBar

aAmplitude adsr iAttack, iDecay, iSustain, iRelease

iFrequencyShift init 4

aFrequency init cpsmidinn ( iNote )
;linseg cpsmidinn ( iNote - .75 ), iAttack / iFrequencyShift, cpsmidinn ( iNote + .25 ), iDecay / iFrequencyShift, cpsmidinn ( iNote ), iRelease, cpsmidinn ( iNote - .75 )

aNote squinewave aFrequency, aClip, aSkew
aNote *= aAmplitude

outs aNote, aNote

endop

instr drone

aLeft, aRight subinstr "_drone", p4

chnmix aLeft/4, "left"
chnmix aRight/4, "right"

endin

instr _drone

iOctave init 60
iNote init iOctave + giKey + p4

kholasaDrone iNote

chnclear "droneClip"
chnclear "droneSkew"

endin

instr _droneController

aClip jspline .5, 0, 4
aClip += 1

chnmix aClip, "droneClip"

aSkew jspline .5, 0, 4
aSkew += 1

chnmix aSkew, "droneSkew"

endin


schedule "_droneController", 0, -1
