
instr record

SName strget p4
iTake chnget "take"
iTake += 1
chnset iTake, "take"
SNote sprintf "kit/%s/%d.wav", SName, iTake

aNote chnget "note"

fout SNote, -1, aNote

SInput sprintf "kit/%s/%d.in.wav", SName, iTake

aInput in

fout SInput, -1, aInput

endin
