instr xbass

iOctave init 48
iNote init giKey + iOctave + p4
p1 += iNote / 1000

iAttack init 1/128
iDecay init 1/32
iSustain init 1/2
iRelease init p3 - iAttack - iDecay

aLeft, aRight wave 0, iNote, iAttack, iDecay, iSustain, iRelease

aLeftLow, aRightLow wave 0, iNote - 12, iAttack, iDecay, iSustain, iRelease

aLeft += aLeftLow/8
aRight += aRightLow/8

aLeftHigh, aRightHigh wave 0, iNote + 12, iAttack, iDecay, iSustain, iRelease

aLeft += aLeftHigh/4/2
aRight += aRightHigh/4/2

outs aLeft, aRight

endin
