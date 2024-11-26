opcode monoWave, a, iiiiii

iModulator, iNote, iAttack, iDecay, iSustain, iRelease xin

iFrequency init cpsmidinn ( iNote )
iPitch init iNote % 12

aCarrier linseg cpsmidinn ( iNote + 96 ), iAttack, cpsmidinn ( iNote + 48 ), iDecay, iFrequency, iRelease, iFrequency * cent ( -1225 )
aSpline jspline 1, 0, 4
aFrequency poscil aCarrier * cent ( 1200 * aSpline ), iFrequency * iModulator * cent ( 10 * aSpline )

aAmplitude linseg 0, iAttack, 1, iDecay, iSustain, iRelease, 0

aNote poscil aAmplitude, aFrequency

aNote butterlp aNote, iFrequency * cent ( 1200 * k ( aSpline ) )

xout aNote

endop

opcode wave, aa, iiiiii

iFM, iNote, iAttack, iDecay, iSustain, iRelease xin

aLeft monoWave iFM, iNote, iAttack, iDecay, iSustain, iRelease
aRight monoWave iFM, iNote, iAttack, iDecay, iSustain, iRelease

xout aLeft, aRight

endop
