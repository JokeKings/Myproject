
/*----------�ó�����Ҫʵ�ֻ�Ʊ��Ϣ�Ĺ���----------*/
#include <string.h>
#include <stdio.h>

/*----------���峵�Ρ�����վ���յ�վ������ʱ�䡢����ʱ�䡢Ʊ������----------*/
char    trains[10][10], start_station[10][10], end_station[10][10], start_time[10][10], end_time[10][10];
int price[10], i = 0, j = 0, k = 0, l = 0, x = 0; /* ----------����ȫ�ֱ���---------- */
void set( void );
void search( void );
void sum( void );
void sort( void );
void edit( void );
void del( void );
int main( void )
{
    int o;  /* ----------o�ڴ˴�Ϊѡ����ֵ---------- */
/*----------���´���Ϊ���˵�ѡ��----------*/
    for ( o = 1; o != 0; o )
    {
        printf( "\n------------------------------------------------\n" );
        printf( "----------��ӭʹ�û�Ʊ����ϵͳ���˵�----------" );
        printf( "\n------------------------------------------------\n" );
        printf( "          1.set                (¼��)\n" );
        printf( "          2.search              (��ѯ)\n" );
        printf( "          3.sum                (ͳ��)\n" );
        printf( "          4.sort                (����)\n" );
        printf( "          5.edit                (�༭)\n" );
        printf( "          6.del                (ɾ��)\n" );
        printf( "          0.exit                (�˳�)\n" );
        printf( "\n������Ҫѡ��ķ�����Ŀ:" );
        scanf( "%d", &o );
        if ( o == 1 )
            set();
        else if ( o == 2 )
            search();
        else if ( o == 3 )
            sum();
        else if ( o == 4 )
            sort();
        else if ( o == 5 )
            edit();
        else if ( o == 6 )
            del();
        else if ( o == 0 )
            break;
        else
            printf( "\n��������ȷ������!n\n" );
    }
}
/*----------¼���Ӻ���---------*/
void set( void )
{
    printf( "\n������׼��¼�����Ϣ��:" );
    scanf( "%d", &i );
    if ( i <= 0 || i > 10 )
    {
        printf( "\n----------����ȷ����1-10֮�������!----------\n" );
        return;
    }
    i = i + x;
    for ( j = x; j < i; j++ )
    {
        ++x; /* ----------��¼¼�����Ϣ������---------- */
        printf( "\n�����복��:" );
        scanf( "%s", &trains[j] );
        printf( "\n���������վ:" );
        scanf( "%s", &start_station[j] );
        printf( "\n�������յ�վ:" );
        scanf( "%s", &end_station[j] );
        printf( "\n�����뷢��ʱ��:" );
        scanf( "%s", &start_time[j] );
        printf( "\n�����뵽��ʱ��:" );
        scanf( "%s", &end_time[j] );
        printf( "\n������Ʊ��:" );
        scanf( "%d", &price[j] );
    }
    printf( "\n----------��Ϣ¼�����----------n\n" );
}
/*----------��ѯ�Ӻ���----------*/
void search( void )
{
    char    search[10];
    int search1;
    k = 0;
    if ( x == 0 )
    {
        printf( "\n----------�������ݿɲ�ѯ!----------\n" );
        return;
    }
    printf( "\n--------------------------------\n" );
    printf( "----------��ѯ���ܲ˵�----------" );
    printf( "\n--------------------------------\n" );
    printf( "          1.����\n" );
    printf( "          2.����վ\n" );
    printf( "          3.�յ�վ\n" );
    printf( "          4.����ʱ��\n" );
    printf( "          5.����ʱ��\n" );
    printf( "          6.Ʊ��\n" );
    printf( "\n������Ҫ��ѯ��ʽ�ı��:" );
    scanf( "%d", &l );
    if ( x == 0 )
    {
        printf( "\n----------��ǰ���ݿ�Ϊ��----------\n" );
    }else if ( l == 1 )
    {
        printf( "\n��������Ҫ��ѯ�ĳ���:" );
        scanf( "%s", search );
        for ( i = 0; i < x; i++ )
        {
            j = strcmp( search, trains[i] );
            if ( j == 0 )
            {
                ++k;
                if ( k == 1 )
                {
                    printf( "\n-------------------------------------------------------------\n" );
                    printf( "���� ����վ �յ�վ ����ʱ�� ����ʱ�� Ʊ��" );
                    printf( "\n-------------------------------------------------------------\n" );
                }
                printf( "%-8s ", trains[i] );
                printf( "%-10s ", start_station[i] );
                printf( "%-10s ", end_station[i] );
                printf( "%-12s ", start_time[i] );
                printf( "%-12s ", end_time[i] );
                printf( "%-8d", price[i] );
                printf( "\n" );
            }
        }
        printf( "\n----------��ѯ����,���ι���ѯ��%d�����----------n\n", k );
    }else if ( l == 2 )
    {
        printf( "\n��������Ҫ��ѯ�ĳ���վ:" );
        scanf( "%s", search );
        for ( i = 0; i < x; i++ )
        {
            j = strcmp( search, start_station[i] );
            if ( j == 0 )
            {
                ++k;
                if ( k == 1 )
                    printf( "\n���� ����վ �յ�վ ����ʱ�� ����ʱ�� Ʊ��\n" );
                printf( "%-8s ", trains[i] );
                printf( "%-10s ", start_station[i] );
                printf( "%-10s ", end_station[i] );
                printf( "%-12s ", start_time[i] );
                printf( "%-12s ", end_time[i] );
                printf( "%-8d", price[i] );
                printf( "\n" );
            }
        }
        printf( "\n----------��ѯ����,���ι���ѯ��%d�����----------n\n", k );
    }else if ( l == 3 )
    {
        printf( "\n��������Ҫ��ѯ���յ�վ:" );
        scanf( "%s", search );
        for ( i = 0; i < x; i++ )
        {
            j = strcmp( search, end_station[i] );
            if ( j == 0 )
            {
                ++k;
                if ( k == 1 )
                    printf( "\n���� ����վ �յ�վ ����ʱ�� ����ʱ�� Ʊ��\n" );
                printf( "%-8s ", trains[i] );
                printf( "%-10s ", start_station[i] );
                printf( "%-10s ", end_station[i] );
                printf( "%-12s ", start_time[i] );
                printf( "%-12s ", end_time[i] );
                printf( "%-8d", price[i] );
                printf( "\n" );
            }
        }
        printf( "\n----------��ѯ����,���ι���ѯ��%d�����----------n\n", k );
    }else if ( l == 4 )
    {
        printf( "\n��������Ҫ��ѯ�ķ���ʱ��:" );
        scanf( "%s", search );
        for ( i = 0; i < x; i++ )
        {
            j = strcmp( search, start_time[i] );
            if ( j == 0 )
            {
                ++k;
                if ( k == 1 )
                    printf( "\n-------------------------------------------------------------\n" );
                printf( "���� ����վ �յ�վ ����ʱ�� ����ʱ�� Ʊ��" );
                printf( "\n-------------------------------------------------------------\n" );
                printf( "%-8s ", trains[i] );
                printf( "%-10s ", start_station[i] );
                printf( "%-10s ", end_station[i] );
                printf( "%-12s ", start_time[i] );
                printf( "%-12s ", end_time[i] );
                printf( "%-8d", price[i] );
                printf( "\n" );
            }
        }
        printf( "\n----------��ѯ����,���ι���ѯ��%d�����----------n\n", k );
    }else if ( l == 5 )
    {
        printf( "\n��������Ҫ��ѯ�ĵ���ʱ��:" );
        scanf( "%s", search );
        for ( i = 0; i < x; i++ )
        {
            j = strcmp( search, end_time[i] );
            if ( j == 0 )
            {
                ++k;
                if ( k == 1 )
                    printf( "\n-------------------------------------------------------------\n" );
                printf( "���� ����վ �յ�վ ����ʱ�� ����ʱ�� Ʊ��" );
                printf( "\n-------------------------------------------------------------\n" );
                printf( "%-8s ", trains[i] );
                printf( "%-10s ", start_station[i] );
                printf( "%-10s ", end_station[i] );
                printf( "%-12s ", start_time[i] );
                printf( "%-12s ", end_time[i] );
                printf( "%-8d", price[i] );
                printf( "\n" );
            }
        }
        printf( "\n----------��ѯ����,���ι���ѯ��%d�����----------n\n", k );
    }else if ( l == 6 )
    {
        printf( "\n��������Ҫ��ѯ��Ʊ��:" );
        scanf( "%d", &search1 );
        for ( i = 0; i < x; i++ )
        {
            j = search1 == price[i] ? 0 : 1;
            if ( j == 0 )
            {
                ++k;
                if ( k == 1 )
                    printf( "\n-------------------------------------------------------------\n" );
                printf( "���� ����վ �յ�վ ����ʱ�� ����ʱ�� Ʊ��" );
                printf( "\n-------------------------------------------------------------\n" );
                printf( "%-8s ", trains[i] );
                printf( "%-10s ", start_station[i] );
                printf( "%-10s ", end_station[i] );
                printf( "%-12s ", start_time[i] );
                printf( "%-12s ", end_time[i] );
                printf( "%-8d", price[i] );
                printf( "\n" );
            }
        }
        printf( "\n----------��ѯ����,���ι���ѯ��%d�����----------n\n", k );
    }else
        printf( "\n����ȷ��������ʽ���!\n" );
}
/*----------�б��Ӻ���----------*/
void sum( void )
{
    if ( x != 0 )
    {
        printf( "\n----------------------------------------------------------------------\n" );
        printf( "��� ���� ����վ �յ�վ ����ʱ�� ����ʱ�� Ʊ��" );
        printf( "\n----------------------------------------------------------------------\n" );
        for ( i = 0; i < x; i++ )
        {
            printf( "%-8d ", i + 1 );
            printf( "%-8s ", trains[i] );
            printf( "%-10s ", start_station[i] );
            printf( "%-10s ", end_station[i] );
            printf( "%-12s ", start_time[i] );
            printf( "%-12s ", end_time[i] );
            printf( "%-8d", price[i] );
            printf( "\n" );
        }
    }
    printf( "\n----------����%d����¼----------\n", x );
}
/*----------�����Ӻ���----------*/
void sort( void )
{
    char    sort[1][10];
    int sort1;
    if ( x == 0 )
    {
        printf( "\n----------�����ݿ�����!----------\n" );
        return;
    }
    printf( "\n--------------------------------\n" );
    printf( "----------�����ܲ˵�----------" );
    printf( "\n--------------------------------\n" );
    printf( "          1.����\n" );
    printf( "          2.����վ\n" );
    printf( "          3.�յ�վ\n" );
    printf( "          4.����ʱ��\n" );
    printf( "          5.����ʱ��\n" );
    printf( "          6.Ʊ��\n" );
    printf( "\n������Ҫ��������:" );
    scanf( "%d", &k );
/*----------����Ϊ����������----------*/
    if ( k == 1 )
    {
        for ( i = 0; i < x; i++ )
            for ( j = i; j < x - 1; j++ )
            {
                l = strcmp( trains[i], trains[j + 1] );
                if ( l > 0 )
                {
                    strcpy( sort[0], trains[i] );
                    strcpy( trains[i], trains[j + 1] );
                    strcpy( trains[j + 1], sort[0] );
                    strcpy( sort[0], start_station[i] );
                    strcpy( start_station[i], start_station[j + 1] );
                    strcpy( start_station[j + 1], sort[0] );
                    strcpy( sort[0], end_station[i] );
                    strcpy( end_station[i], end_station[j + 1] );
                    strcpy( end_station[j + 1], sort[0] );
                    strcpy( sort[0], start_time[i] );
                    strcpy( start_time[i], start_time[j + 1] );
                    strcpy( start_time[j + 1], sort[0] );
                    strcpy( sort[0], end_time[i] );
                    strcpy( end_time[i], end_time[j + 1] );
                    strcpy( end_time[j + 1], sort[0] );
                    sort1      = price[i];
                    price[i]    = price[j + 1];
                    price[j + 1]    = sort1;
                }
            }
    }else if ( k == 2 )
    {
        for ( i = 0; i < x; i++ )
            for ( j = i; j < x - 1; j++ )
            {
                l = strcmp( start_station[i], start_station[j + 1] );
                if ( l > 0 )
                {
                    strcpy( sort[0], trains[i] );
                    strcpy( trains[i], trains[j + 1] );
                    strcpy( trains[j + 1], sort[0] );
                    strcpy( sort[0], start_station[i] );
                    strcpy( start_station[i], start_station[j + 1] );
                    strcpy( start_station[j + 1], sort[0] );
                    strcpy( sort[0], end_station[i] );
                    strcpy( end_station[i], end_station[j + 1] );
                    strcpy( end_station[j + 1], sort[0] );
                    strcpy( sort[0], start_time[i] );
                    strcpy( start_time[i], start_time[j + 1] );
                    strcpy( start_time[j + 1], sort[0] );
                    strcpy( sort[0], end_time[i] );
                    strcpy( end_time[i], end_time[j + 1] );
                    strcpy( end_time[j + 1], sort[0] );
                    sort1      = price[i];
                    price[i]    = price[j + 1];
                    price[j + 1]    = sort1;
                }
            }
    }else if ( k == 3 )
    {
        for ( i = 0; i < x; i++ )
            for ( j = i; j < x - 1; j++ )
            {
                l = strcmp( end_station[i], end_station[j + 1] );
                if ( l > 0 )
                {
                    strcpy( sort[0], trains[i] );
                    strcpy( trains[i], trains[j + 1] );
                    strcpy( trains[j + 1], sort[0] );
                    strcpy( sort[0], start_station[i] );
                    strcpy( start_station[i], start_station[j + 1] );
                    strcpy( start_station[j + 1], sort[0] );
                    strcpy( sort[0], end_station[i] );
                    strcpy( end_station[i], end_station[j + 1] );
                    strcpy( end_station[j + 1], sort[0] );
                    strcpy( sort[0], start_time[i] );
                    strcpy( start_time[i], start_time[j + 1] );
                    strcpy( start_time[j + 1], sort[0] );
                    strcpy( sort[0], end_time[i] );
                    strcpy( end_time[i], end_time[j + 1] );
                    strcpy( end_time[j + 1], sort[0] );
                    sort1      = price[i];
                    price[i]    = price[j + 1];
                    price[j + 1]    = sort1;
                }
            }
    }else if ( k == 4 )
    {
        for ( i = 0; i < x; i++ )
            for ( j = i; j < x - 1; j++ )
            {
                l = strcmp( start_time[i], start_time[j + 1] );
                if ( l > 0 )
                {
                    strcpy( sort[0], trains[i] );
                    strcpy( trains[i], trains[j + 1] );
                    strcpy( trains[j + 1], sort[0] );
                    strcpy( sort[0], start_station[i] );
                    strcpy( start_station[i], start_station[j + 1] );
                    strcpy( start_station[j + 1], sort[0] );
                    strcpy( sort[0], end_station[i] );
                    strcpy( end_station[i], end_station[j + 1] );
                    strcpy( end_station[j + 1], sort[0] );
                    strcpy( sort[0], start_time[i] );
                    strcpy( start_time[i], start_time[j + 1] );
                    strcpy( start_time[j + 1], sort[0] );
                    strcpy( sort[0], end_time[i] );
                    strcpy( end_time[i], end_time[j + 1] );
                    strcpy( end_time[j + 1], sort[0] );
                    sort1      = price[i];
                    price[i]    = price[j + 1];
                    price[j + 1]    = sort1;
                }
            }
    }else if ( k == 5 )
    {
        for ( i = 0; i < x; i++ )
            for ( j = i; j < x - 1; j++ )
            {
                l = strcmp( end_time[i], end_time[j + 1] );
                if ( l > 0 )
                {
                    strcpy( sort[0], trains[i] );
                    strcpy( trains[i], trains[j + 1] );
                    strcpy( trains[j + 1], sort[0] );
                    strcpy( sort[0], start_station[i] );
                    strcpy( start_station[i], start_station[j + 1] );
                    strcpy( start_station[j + 1], sort[0] );
                    strcpy( sort[0], end_station[i] );
                    strcpy( end_station[i], end_station[j + 1] );
                    strcpy( end_station[j + 1], sort[0] );
                    strcpy( sort[0], start_time[i] );
                    strcpy( start_time[i], start_time[j + 1] );
                    strcpy( start_time[j + 1], sort[0] );
                    strcpy( sort[0], end_time[i] );
                    strcpy( end_time[i], end_time[j + 1] );
                    strcpy( end_time[j + 1], sort[0] );
                    sort1      = price[i];
                    price[i]    = price[j + 1];
                    price[j + 1]    = sort1;
                }
            }
    }else if ( k == 6 )
    {
        for ( i = 0; i < x; i++ )
            for ( j = i; j < x - 1; j++ )
            {
                l = price[i] > price[j + 1] ? 1 : 0;
                if ( l > 0 )
                {
                    strcpy( sort[0], trains[i] );
                    strcpy( trains[i], trains[j + 1] );
                    strcpy( trains[j + 1], sort[0] );
                    strcpy( sort[0], start_station[i] );
                    strcpy( start_station[i], start_station[j + 1] );
                    strcpy( start_station[j + 1], sort[0] );
                    strcpy( sort[0], end_station[i] );
                    strcpy( end_station[i], end_station[j + 1] );
                    strcpy( end_station[j + 1], sort[0] );
                    strcpy( sort[0], start_time[i] );
                    strcpy( start_time[i], start_time[j + 1] );
                    strcpy( start_time[j + 1], sort[0] );
                    strcpy( sort[0], end_time[i] );
                    strcpy( end_time[i], end_time[j + 1] );
                    strcpy( end_time[j + 1], sort[0] );
                    sort1      = price[i];
                    price[i]    = price[j + 1];
                    price[j + 1]    = sort1;
                }
            }
    }else
        printf( "\n----------����������!----------n\n" );
/*----------���������̽���----------*/
    printf( "\n-------------------------------------------------------------\n" );
    printf( "���� ����վ �յ�վ ����ʱ�� ����ʱ�� Ʊ��" );
    printf( "\n-------------------------------------------------------------\n" );
    for ( i = 0; i < x; i++ )
    {
        printf( "%-8s ", trains[i] );
        printf( "%-10s ", start_station[i] );
        printf( "%-10s ", end_station[i] );
        printf( "%-12s ", start_time[i] );
        printf( "%-12s ", end_time[i] );
        printf( "%-8d", price[i] );
        printf( "\n" );
    }
}
/*----------�༭�Ӻ���----------*/
void edit( void )
{
    if ( x != 0 )
    {
        printf( "\n----------------------------------------------------------------------\n" );
        printf( "��� ���� ����վ �յ�վ ����ʱ�� ����ʱ�� Ʊ��" );
        printf( "\n----------------------------------------------------------------------\n" );
        for ( i = 0; i < x; i++ )
        {
            printf( "%-8d ", i + 1 );
            printf( "%-8s ", trains[i] );
            printf( "%-10s ", start_station[i] );
            printf( "%-10s ", end_station[i] );
            printf( "%-12s ", start_time[i] );
            printf( "%-12s ", end_time[i] );
            printf( "%-8d", price[i] );
            printf( "\n" );
        }
        printf( "\n----------------------------------\n" );
        printf( "----------�༭�������˵�----------" );
        printf( "\n----------------------------------\n" );
    }
    if ( x == 0 )
        printf( "\n----------û�����ݿɱ༭!----------\n" );
    else{
        printf( "\n������Ҫ�޸���Ϣ�ı��:" );
        scanf( "%d", &j );
        if ( j >= 1 && j <= x )
        {
            printf( "\n--------------" );
            printf( "\n  1.����      " );
            printf( "\n  2.����վ    " );
            printf( "\n  3.�յ�վ    " );
            printf( "\n  4.����ʱ��  " );
            printf( "\n  5.����ʱ��  " );
            printf( "\n  6.Ʊ��      " );
            printf( "\n--------------" );
            printf( "\nn������Ҫ�޸ĵ���Ŀ:" );
            scanf( "%d", &k );
            if ( k == 1 || k == 2 || k == 3 || k == 4 || k == 5 || k == 6 )
            {
                printf( "\n��������Ҫ�޸ĵ�����:" );
                if ( k == 1 )
                {
                    scanf( "%s", &trains[j - 1] );
                    printf( "\n----------�༭�����ɹ�----------\n" );
                }else if ( k == 2 )
                {
                    scanf( "%s", &start_station[j - 1] );
                    printf( "\n----------�༭�����ɹ�----------\n" );
                }else if ( k == 3 )
                {
                    scanf( "%s", &end_station[j - 1] );
                    printf( "\n----------�༭�����ɹ�----------\n" );
                }else if ( k == 4 )
                {
                    scanf( "%s", &start_time[j - 1] );
                    printf( "\n----------�༭�����ɹ�----------\n" );
                }else if ( k == 5 )
                {
                    scanf( "%s", &end_time[j - 1] );
                    printf( "\n----------�༭�����ɹ�----------\n" );
                }else  {
                    scanf( "%d", &price[j - 1] );
                    printf( "\n----------�༭�����ɹ�----------\n" );
                }
            }else
                printf( "\n----------��������ȷ����Ŀ!----------\n" );
        }else
            printf( "\n----------��������ȷ�ı��!----------\n" );
    }
}
/*----------ɾ���Ӻ���----------*/
void del( void )
{
    if ( x != 0 )
    {
        printf( "\n----------------------------------------------------------------------\n" );
        printf( "��� ���� ����վ �յ�վ ����ʱ�� ����ʱ�� Ʊ��" );
        printf( "\n----------------------------------------------------------------------\n" );
        for ( i = 0; i < x; i++ )
        {
            printf( "%-8d ", i + 1 );
            printf( "%-8s ", trains[i] );
            printf( "%-10s ", start_station[i] );
            printf( "%-10s ", end_station[i] );
            printf( "%-12s ", start_time[i] );
            printf( "%-12s ", end_time[i] );
            printf( "%-8d", price[i] );
            printf( "\n" );
        }
        printf( "\n----------------------------------\n" );
        printf( "----------ɾ���������˵�----------" );
        printf( "\n----------------------------------\n" );
        printf( "\n����������Ҫɾ����Ϣ�ı��:" );
        scanf( "%d", &j );
    }
    if ( x == 0 )
        printf( "\n----------û�����ݿ�ɾ��!----------\n" );
    else if ( j < x && j > 0 )
    {
        for (; j < x + 1; j++ )
        {
            strcpy( trains[j - 1], trains[j] );
            strcpy( start_station[j - 1], start_station[j] );
            strcpy( end_station[j - 1], end_station[j] );
            strcpy( start_time[j - 1], start_time[j] );
            strcpy( end_time[j - 1], end_time[j] );
            price[j - 1] = price[j];
        }
        x = x - 1;
        printf( "\n----------ɾ�������ɹ�!----------\n" );
    }else if ( j == x )
    {
        x = x - 1;
        printf( "\n----------ɾ�������ɹ�!----------\n" );
    }else
        printf( "\n----------��������ȷ�ı��!----------\n" );
}