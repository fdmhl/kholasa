instr sagat

iOctave init 96
iNote init giKey + iOctave + p4
p1 += iNote / 1000

aNote tambourine 1, p3, 128, .5, 0, cpsmidinn ( iNote ), cpsmidinn ( iNote + 9 + p5 ), cpsmidinn ( iNote + 18 )

aNote /= 2

outs aNote, aNote

endin
