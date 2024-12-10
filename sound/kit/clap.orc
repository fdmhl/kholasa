instr clap

iNote init giKey + p4

iAttack init 1/1024
iDecay init iAttack*16
iSustain init 1/8

aNoteAmplitude linseg 0, iAttack/2, 1, iDecay/2, 0

iShift init 1/8

aNoteFrequency linseg cpsmidinn ( iNote + 120 ), iAttack / iShift, cpsmidinn ( iNote + 24 )

aNote noise aNoteAmplitude, 0

aNote butterlp aNote, aNoteFrequency*2

chnmix aNote, "left"
chnmix aNote, "right"

endin
