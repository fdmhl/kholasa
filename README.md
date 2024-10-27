#!/usr/bin/env roll

# Kholasa

?# cat - > index.mjs

+==

export default class Kholasa {

$sr = new Kholasa .Parameter ( 48000 );
$ksmps = new Kholasa .Parameter ( 32 );
$nchnls = new Kholasa .Parameter ( 2 );
$0dbfs = new Kholasa .Parameter ( 1 );

$__ ( { $ } ) {

this .$play = new Kholasa .Instrument ( `

iNumberOfParameters pcount
iKitSize init iNumberOfParameters - 5

if iKitSize > 1 then

iIndex random 0, iKitSize - 1

else

iIndex init 0

endif

iIndex init 6 + int ( iIndex )

SFile strget p ( iIndex )
p3 filelen SFile

aSample [] diskin2 SFile
iChannel init p4
iDistance init p5

aNote = aSample [ iChannel - 1 ] / ( 1 + iDistance

chnmix aNote, S ( iChannel )

` );

this .$_out = new Kholasa .Instrument ( `

iChannel init p4
aChannel chnget S ( iChannel )
outch iChannel, aChannel
chnclear S ( iChannel )

` );

this .$loop = new Kholasa .Instrument ( 'setscorepos p4' );

};

$orc ( { $ }, ... argv ) {

if ( argv .length )
return;

return [

`sr = ${ $ ( 'sr' ) }
ksmps = ${ $ ( 'ksmps' ) }
nchnls = ${ $ ( 'nchnls' ) }
0dbfs = ${ $ ( '0dbfs' ) }`,

... Object .keys ( this )
.filter ( key => key [ 0 ] === '$' && this [ key ] instanceof Kholasa .Instrument )
.map ( key => $ ( key [ 1 ] !== '_' ? key .slice ( 1 ) : Symbol .for ( key .slice ( 2 ) ) ) )

] .join ( '\n\n' );

}; // Kholasa .prototype .$orc

static Instrument = class Instrument {

static number = 0;

number = ++Kholasa .Instrument .number;

constructor ( body ) { this .body = body .trim () };

$_ () { return `instr ${ this .number }

${ this .body }

endin` };

}; // Kholasa .Instrument

static Note = class Note {

constructor ( track ) { this ._$ = track };

$bar = new Kholasa .Parameter ();
$step = new Kholasa .Parameter ();

$_ ( { $ }, ... argv ) {

return [

'i',
$ ( 'instrument' ) + '.' + this ._$ ( 'number' ),
( $ ( 'bar' ) + $ ( 'step' ) / this ._$ ( 'measure' ) ) * this ._$ ( 'length' ) * 60 / this ._$ ( 'tempo' ),

] .join ( ' ' );

}; // Kholasa .Note .$_

}; // Kholasa .Note

static Parameter = class Parameter {

#value = 0;

constructor ( value = 0 ) { this .#value = value };

$_ ( { $ }, ... argv ) {

if ( ! argv .length )
return this .#value;

this .#value = parseFloat ( argv .shift () ) || this .#value;

return $ ( ... argv );

}; // Kholasa .Parameter .$_

}; // Kholasa .Parameter

}; // Kholasa

-==

?# cat - > scenarist.mjs

+==

class Scenarist {

$ = Scenarist .#director .bind ( this );

#scenario
#plot = new Map

constructor ( scenario ) {

this .#scenario = scenario;

if ( typeof this .#scenario [ '$__' ] === 'function' )
this .$ ( Symbol .for ( '_' ) );

}; // Scenarist .prototype .constructor

static #director ( ... argv ) {

let scene = argv [ 0 ] instanceof Array ? Object .create ( argv .shift () ) : [];
let direction = typeof argv [ 0 ] === 'symbol' ? '$_' + Symbol .keyFor ( argv [ 0 ] ) : '$' + argv [ 0 ];
let conflict = this .#scenario [ direction ];
let resolution;

if ( conflict === undefined )
conflict = this .#scenario [ direction = '$_' ];

else
argv .shift ();

if ( direction [ 0 ] === '$' && direction [ 1 ] !== '_' )
scene .push ( direction .slice ( 1 ) );

scene .$ = this .$;

switch ( typeof conflict ) {

case 'object':

this .#plot .set ( conflict, this .#plot .get ( conflict ) || new this .constructor ( conflict ) );

resolution = this .#plot .get ( conflict ) .$ ( scene, ... argv );

break;

case 'function':

resolution = this .#scenario [ direction ] ( scene, ... argv );

break;

default:

resolution = conflict;

}

scene .resolution = resolution;

return typeof this .#scenario .$_$ === 'function' ? this .#scenario .$_$ ( scene ) : scene .resolution;

}; // #director

}; // Scenarist

export default scenario => new Scenarist ( scenario ) .$;

-==

?# cat - > shell.mjs

+==

import Kholasa from './index.mjs';
import Scenarist from './scenarist.mjs';
import { createInterface } from 'node:readline';
import { stdin as input, stdout as output } from 'node:process';

const { $ } = Scenarist ( new class Shell extends Kholasa {

#interface = createInterface ( { input, output } );

$__ ( scene ) {

super .$__ ( scene );

const { $ } = scene;

this .#interface .on ( 'line', line => {

try {

const scene = $ ( [ 'kholasa' ], ... line .trim () .split ( /\s+/ ) );

console .log ( '@' + scene .join ( '/' ) + ':' );
console .log ( scene .resolution );

} catch ( error ) { console .error ( '#error', error ) }

this .#interface .prompt ();

} );

this .#interface .prompt ();

}

$_$ ( scene ) { return scene [ 0 ] === 'kholasa' ? scene : scene .resolution }

} );

-==

?# =0 $ node shell.mjs
