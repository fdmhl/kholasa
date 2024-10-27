export default class Kit {

#player;
$size = 0;

constructor ( player, input ) {

this .#player = player;

if ( input instanceof Array )
input .forEach ( ( file, index ) => {

this [ '$' + ( index + 1 ) ] = fetch ( file )
.then ( response => response .arrayBuffer () )
.then ( buffer => this .#player .decodeAudioData ( buffer ) );

this .$size++;

} );

}; // constructor

};
