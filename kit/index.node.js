import { createWriteStream } from 'node:fs';
import { Console } from 'node:console';
import { readdir as list } from 'node:fs/promises';

new Console ( createWriteStream ( process .argv .slice ( 2 ) .shift () || 'faddys.js' ) )
.log ( 'export default', Object .assign ( {}, ... ( await Promise .all (

( await list ( '.', { withFileTypes: true } ) )
.filter ( entry => entry .isDirectory () )
.map ( async ( { name } ) => ( {

[ name ]: ( await list ( './' + name ) )
.filter ( file => file .endsWith ( '.wav' ) )
.map ( file => `/kit/${ name }/${ file }` )

} ) )

) ) ) );
