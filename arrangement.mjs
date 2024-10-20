
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
