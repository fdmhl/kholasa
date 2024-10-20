
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
