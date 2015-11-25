#include "bsp/bspExt.h"

#include <iostream>
#include <sstream>

void BspTest()
{
    bsp_begin( 20 );

    size_t s = bsp_pid();
    size_t nprocs = bsp_nprocs();

    size_t i = s;

    BSPLib::PushReg( i );

    bsp_sync();

    BSPLib::Send( ( uint32_t )( ( s + 7 ) % nprocs ), NULL, i );

    bsp_sync();

    BSPLib::Move( i );

    {
        std::stringstream ss;
        ss << s << " has " << i << "\n";

        std::cout << ss.str();
    }

    BSPLib::PopReg( i );

    bsp_sync();

    std::vector< uint32_t > ints( 100 );

    ints[25] = ( uint32_t )s;

    BSPLib::PushReg( ints.begin(), ints.end() );

    bsp_sync();

    BSPLib::Put( ( uint32_t )( ( s + 7 ) % nprocs ), ints.begin() + 10, ints.begin() + 40, ints.begin(),
                 ints.begin() + 10 );
    //bsp_put( ( uint32_t )( ( s + 7 ) % nprocs ), ints[25], ints[25] );

    bsp_sync();

    {
        std::stringstream ss;
        ss << s << " has " << ints[25] << "\n";

        std::cout << ss.str();
    }

    bsp_end();
}

void SyncTest()
{
    bsp_begin( 8 );

    size_t pid = bsp_pid();

    uint32_t j = 0;
    bsp_push_reg( &j, 4 );
    bsp_sync();

    for ( uint32_t i = 0; i < 1000000; ++i )
    {
        bsp_put( ( pid + 1 ) % 8, &j, &j, 0, 4 );
        bsp_sync();

        assert( j == i );
        ++j;
    }

    bsp_end();
}

#define BSPTEST 0


#if BSPTEST == 0
int main( int argc, char **argv )
{
    bsp_init( BspTest, argc, argv );

    BspTest();

    system( "pause" );
}
#endif

#if BSPTEST == 1
int main( int argc, char **argv )
{
    bsp_begin( 4 );
    printf( "Hello BSP Worldwide from process %d of %d\n", ( int )bsp_pid(), ( int )bsp_nprocs() );
    bsp_end();
}
#endif

#if BSPTEST == 2
int main( int argc, char **argv )
{
    bsp_init( SyncTest, argc, argv );

    SyncTest();
    system( "pause" );
}
#endif