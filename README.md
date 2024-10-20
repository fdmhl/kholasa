#!/usr/bin/env roll

# Kholasa

Work of Faddy Michel

In Solidarity with The People of Palestine till Their Whole Land is FREE

## `notation/`

```
?# rm -fr notation ; mkdir notation

?# cat - > notation/rst.no

+==

length 4

-==

?# cat - > notation/tmp.no

+==

length 4
measure 4

0 g 0 1
1 g 0 2
2 g 0 3
3 g 0 4

-==

?# cat - > notation/clsng.no

+==

length 4
measure 8

0 g 64 3
1 g 64 3
2 g 64 3
3 g 64 3
4 g 64 3
5 g 64 3
6 g 64 3
7 g 64 3

-==

?# cat - > notation/mqsm.no

+==

length 4
measure 8

0 d 0 1
1 t 0 3

3 t 0 3
4 d 0 1

6 t 0 3

-==

?# cat - > notation/mqsm.vrnt.no

+==

length 4
measure 8

0 d 0 1


3 t 0 3
4 d 0 1

6 t 0 3

-==

?# cat - > notation/mlff.no

+==

length 4
measure 8

0 d 0 1
1.5 t 0 3
3 t 0 3

4 d 0 1
5.5 t 0 3
7 t 0 3

-==

?# cat - > notation/mqsm.acnt.no

+==

length 4
measure 16

4 s 0 4
5 s 0 4

10 s 0 4
11 s 0 4

14 s 0 4
15 s 0 4

-==

?# cat - > notation/sgt.no

+==

length 4
measure 8

0 g 0 13
3 g 0 13
6 g 0 13

-==
```

## `engine/`

```
?# rm -fr engine ; mkdir engine
```

## `engine/index.mjs`

```
/# cat - > engine/index.mjs
```

```js
//+==

import Scenarist from '@faddysk/scenarist';

await Scenarist ( new class {

parts = [

'beat',
'fm',
'out',
'loop',
'record',
'lead',
'follow'

] .map ( part => ( this, '$' + part, {
 

} );
//-==
```

## `engine/index.orc`

```
?# cat - > engine/index.orc
```

```csound
//+==

sr = 44100
ksmps = 32
nchnls = 1
0dbfs = 1

#include "engine/beat.orc"
#include "engine/fm.orc"
#include "engine/record.orc"
#include "engine/out.orc"
#include "engine/loop.orc"

//-==
```

## `engine/beat.orc`

```
?# cat - > engine/beat.orc
```

```csound
//+==

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

//-==
```

## `engine/fm.orc`

```
?# cat - > engine/fm.orc
```

```csound
//+==

giSineWaveform ftgen 0, 0, 256, 10, 1

instr fm

iInstance chnget "instance"
iInstance += 1
chnset iInstance, "instance"

iInstance /= 1000
p1 init int ( p1 ) + iInstance

iBeat init abs ( p3 )
SNote strget p4
iFrequency ntof SNote

aSweep poscil 9, 8/iBeat
aModulator poscil aSweep, iFrequency
aFrequency = iFrequency * aModulator

aAmplitude poscil 1, 8/iBeat

aClip poscil aAmplitude, 8/iBeat
aSkew poscil aAmplitude, 8/iBeat

aNote squinewave aFrequency, aClip, aSkew, 0
aNote poscil 1, iFrequency * aModulator

aNote *= aAmplitude

chnmix aNote / ( p5 + 1 ), "note"

endin

//-==
```

## `engine/out.orc`

```
?# cat - > engine/out.orc
```

```csound
//+==

instr out

aNote chnget "note"

aNote clip aNote, 2, 1

outch 1, aNote
outch 2, aNote
outch 3, aNote
outch 4, aNote
outch 5, aNote
outch 6, aNote

chnclear "note"

endin

//-==
```

## `engine/record.orc`

```
?# cat - > engine/record.orc
```

```csound
//+==

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

//-==
```

## `engine/loop.orc`

```
?# cat - > engine/loop.orc
```

```csound
//+==

instr loop

setscorepos p4

endin

//-==
```

## `controller.mjs`

```
?# cat - > controller.mjs
```

```js
//+==

import Scenarist from '@faddys/scenarist';
import $0 from '@faddys/command';
import arrangement from './arrangement.mjs';

await Scenarist ( class controller {

static instance = 0
static tempo = 0
static length = 0

static async $_producer ( $ ) {

const notation = await arrangement ();
const name = notation .shift ();
const score = [

'C 0',
'i "record" 0 -1' + ( name ?.length ? ` "${ name }"` : '' ),
'i "out" 0 -1'

];

if ( name ?.length )
await $0 ( 'mkdir -p kit/' + name );

for ( let index = 0; index < notation .length; index++ )
score .push ( await $ ( index, notation [ index ], index === notation .length - 1 )
.then ( $ => $ ( Symbol .for ( 'score' ) ) ) );

await $0 ( 'cat - > index.sco' )
.then ( $ => $ ( Symbol .for ( 'end' ), score .join ( '\n\n' ) ) );

await $0 ( 'csound -o guide.flac engine/index.orc index.sco > index.log 2>&1' );

}

static kit = {};

static async prepare ( kit ) {

const controller = this;

if ( controller .kit [ kit ] )
return controller .kit [ kit ];

const contents = await $0 ( 'file', '--mime-type', `kit/${ kit }/*` )
.then ( $ => $ ( Symbol .for ( 'output' ) ) );

return controller .kit [ kit ] = contents .map ( line => line .split ( /\s+/ ) )
.filter ( ( [ file, type ] ) => type .startsWith ( 'audio' ) )
.map ( ( [ file ] ) => `"${ file .slice ( 0, -1 ) }"` );

}

score = []
tempo = 105
length = 4
measure = 8

constructor ( file, loop ) {

this .file = file;
this .loop = loop;

Object .keys ( this )
.filter ( key => typeof this [ key ] === 'number' )
.forEach ( key => Object .defineProperty ( this, '$' + key, {

value ( $, value, ... argv ) {

this [ key ] = parseFloat ( value ) || this [ key ];

return $ ( ... argv );

}

} ) );

}

async $_producer ( $ ) {

const beat = this;

console .log ( '#beat', beat .file );

const notation = await $0 ( 'cat', ... beat .file )
.then ( $ => $ ( Symbol .for ( 'output' ) ) );

for ( let line of notation )
if ( ( line = line .trim () ) .length )
await $ ( ... line .trim () .split ( /\s+/ ) );

}

$_score () {

const beat = this;

controller .length += ( beat .length *= 60 / beat .tempo );
controller .tempo = beat .tempo;

if ( beat .loop )
beat .score .push ( `i "loop" ${ controller .length } 1` );

return beat .score .join ( '\n' );

}

async $_director ( $, ... argv ) {

if ( ! argv .length )
return;

const beat = this;
const step = parseFloat ( argv .shift () );
const kit = argv .shift ();
const swing = parseFloat ( argv .shift () );
const distance = parseFloat ( argv .shift () );

if ( typeof beat .start !== 'number' )
beat .start = controller .length * controller .tempo / beat .tempo;

beat .score .push ( [

'i',
`13.${ ++controller .instance % 10 === 0 ? ++controller .instance : controller .instance }`,
controller .length + step / beat .measure * beat .length * 60 / beat .tempo,
0,
parseFloat ( swing ) || 0,
distance || 0,
... await controller .prepare ( kit )

] .join ( ' ' ) );

}

async $fm ( $, ... argv ) {

if ( ! argv .length )
return;

const beat = this;
const step = argv .shift ();
const note = argv .shift ();
const distance = argv .shift ();

if ( typeof beat .start !== 'number' )
beat .start = controller .length * controller .tempo / beat .tempo;

beat .score .push ( [

'i "fm"',
controller .length + parseFloat ( step ) / beat .measure * beat .length * 60 / beat .tempo,
-beat .length,
`"${ note }"`,
distance || 0

] .join ( ' ' ) );

await $ ( ... argv );

}

} );

//-==
```

## `arrangement.mjs`

```
?# cat - > arrangement.mjs
```

```js
//+==

import Scenarist from '@faddys/scenarist';

export default await Scenarist ( new class extends Array {

constructor () { super (), this .argv = process .argv .slice ( 2 ) }

$_producer ( $ ) { return this .push ( this .argv .pop () ), $ ( ... this .argv ) }

times = 1

$_director ( $, ... argv ) {

if ( ! argv .length )
return this;

const notation = argv .shift () .split ( '+' ) .map ( file => `notation/${ file }.no` );

for ( let repeat = 0; repeat < this .times; repeat++ )
this .push ( notation );

return $ ( ... argv );

}

$rpt ( $, ... argv ) { return this .times = parseInt ( argv .shift () ), $ ( ... argv ) }

} );

//-==
```

```
?# $ node controller.mjs
```
