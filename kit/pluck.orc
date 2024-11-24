instr pluck

iNote init p4

print iNote

iAttack init 1/128
iDecay init 1/64
iSustain init 1/16
iRelease init p3 - iAttack - iDecay

aLeft wave 1, iNote, iAttack, iDecay, iSustain, iRelease
aRight wave 1, iNote, iAttack, iDecay, iSustain, iRelease

aLeftLow wave 1, iNote - 12, iAttack, iDecay, iSustain, iRelease
aRightLow wave 1, iNote - 12, iAttack, iDecay, iSustain, iRelease

aLeft += aLeftLow/8
aRight += aRightLow/8

aLeftBass wave 1, iNote - 24, iAttack, iDecay, iSustain, iRelease
aRightBass wave 1, iNote - 24, iAttack, iDecay, iSustain, iRelease

aLeft += aLeftBass/4
aRight += aRightBass/4

aLeftHigh wave 1, iNote + 12, iAttack, iDecay, iSustain, iRelease
aRightHigh wave 1, iNote + 12, iAttack, iDecay, iSustain, iRelease

aLeft += aLeftHigh/4/2
aRight += aRightHigh/4/2

outs aLeft/2, aRight/2

endin
