
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

let scene;

if ( argv [ 0 ] instanceof Scenarist .Scene )
scene = Object .create ( argv .shift () );

else
scene = new Scenarist .Scene ( ... argv [ 0 ] instanceof Array ? argv .shift () : [] );

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

static Scene = class Scene extends Array {

get player () { return Object .getPrototypeOf ( this ) };

}; // Scenarist .Scene

}; // Scenarist

export default scenario => new Scenarist ( scenario ) .$;
