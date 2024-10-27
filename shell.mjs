
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
