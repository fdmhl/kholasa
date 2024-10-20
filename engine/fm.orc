
giSineWaveform ftgen 0, 0, 256, 10, 1

instr fm

iInstance chnget "instance"
iInstance += 1
chnset iInstance, "instance"

iInstance /= 1000
p1 init int ( p1 ) + iInstance

iBeat init abs ( p3 )
SNote strget p4
iFrequency ntof SNote

aSweep poscil 9, 8/iBeat
aModulator poscil aSweep, iFrequency
aFrequency = iFrequency * aModulator

aAmplitude poscil 1, 8/iBeat

aClip poscil aAmplitude, 8/iBeat
aSkew poscil aAmplitude, 8/iBeat

aNote squinewave aFrequency, aClip, aSkew, 0
aNote poscil 1, iFrequency * aModulator

aNote *= aAmplitude

chnmix aNote / ( p5 + 1 ), "note"

endin
