#include <stdio.h>
#include "pmi.h"

int main (int argc, char *argv[])
{
    int spawned = 0;
    int rc = 0;
    int size, rank, appnum;
    rc = PMI_Init (&spawned);
    printf ("rc from PMI_Init() is %d\n", rc);
    rc = PMI_Get_size (&size);
    printf ("rc from PMI_Get_size() is %d\n", rc);
    rc = PMI_Get_rank (&rank);
    printf ("rc from PMI_Get_rank() is %d\n", rc);
    rc = PMI_Get_appnum (&appnum);
    printf ("rc from PMI_Get_appnum() is %d\n", rc);
    rc = PMI_Barrier ();
    printf ("rc from PMI_Barrier() is %d\n", rc);
    return 0;
}
