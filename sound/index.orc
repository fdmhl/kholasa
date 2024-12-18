sr = 48000
ksmps = 32
nchnls = 2
0dbfs = 1

giKey init 0

giStrikeFT ftgen 0, 0, 256, 1, "prerequisites/marmstk1.wav", 0, 0, 0
giVibratoFT ftgen 0, 0, 128, 10, 1

#include "kit/sagat.orc"
#include "kit/bass.orc"

#include "kit/lead.orc"
#include "kit/response.orc"
#include "kit/drone.orc"

#include "kit/dom.orc"
#include "kit/tak.orc"
#include "kit/clap.orc"

instr out

aLeft chnget "left"
aRight chnget "right"

aLeft clip aLeft, 1, 1
aRight clip aRight, 1, 1

outs aLeft, aRight

chnclear "left"
chnclear "right"

endin

#define setup #schedule "out", 0, -1
schedule "bassController", 0, -1
schedule "responseController", 0, -1
schedule "leadController", 0, -1#

instr loopback

p3 = -1

rewindscore

$setup

endin

$setup
