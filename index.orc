sr = 48000
ksmps = 32
nchnls = 2
0dbfs = 1

giKey init 0

giStrikeFT ftgen 0, 0, 256, 1, "prerequisites/marmstk1.wav", 0, 0, 0
giVibratoFT ftgen 0, 0, 128, 10, 1

#include "kit/sagat.orc"
#include "kit/lead.orc"
#include "kit/dom.orc"
#include "kit/tak.orc"
