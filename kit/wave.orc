opcode wave, a, iiiiii

iFM, iNote, iAttack, iDecay, iSustain, iRelease xin

iFrequency init cpsmidinn ( iNote )
iPitch init iNote % 12

iSplineFrequency init iPitch; cpsmidinn ( 12 + iPitch )
iSplineFrequencyMax init iPitch + 4;cpsmidinn ( 12 + iPitch )

if iFM == 1 then

aFrequency poscil iFrequency, iFrequency*2

else

aFrequency = iFrequency

endif

aDetune linseg cent ( 1 ), iAttack, cent ( 5 ), iDecay, 1, iRelease, cent ( -5 )
aFrequency = aFrequency * aDetune

aClip jspline .5, iSplineFrequency, iSplineFrequencyMax
aClip += .5

aSkew jspline .5, iSplineFrequency, iSplineFrequencyMax
aSkew += .5

aNote squinewave aFrequency, aClip, aSkew

aFilter jspline 200, iSplineFrequency, iSplineFrequencyMax
aNote butterlp aNote, abs ( aFrequency / 4 * cent ( aFilter ) )

aEnvelope adsr iAttack, iDecay, iSustain, iRelease

aAmplitude poscil 1, aFrequency

xout aNote * aEnvelope; * aAmplitude

endop
