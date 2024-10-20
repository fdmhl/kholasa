
instr 13, beat

SFirst strget p6
prints "#kit.first %s\n", SFirst

iSwing random 0, 127

if p4 > iSwing then

p3 init 0

else

iCount pcount
iKit init iCount - 5
prints "#kit.size %d\n", iKit

iIndex random 0, iKit - 1
iIndex init 6 + int ( iIndex )
prints "#kit.use %d\n", iIndex

SNote strget p ( iIndex )
p3 filelen SNote

aBeat [] diskin2 SNote

aNote = aBeat [ 0 ] / ( 1 + p5 )

chnmix aNote, "note"

endif

endin
