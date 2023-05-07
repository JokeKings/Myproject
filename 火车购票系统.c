
/*----------该程序主要实现火车票信息的管理----------*/
#include <string.h>
#include <stdio.h>

/*----------定义车次、出发站、终点站、发车时间、到达时间、票价数组----------*/
char    trains[10][10], start_station[10][10], end_station[10][10], start_time[10][10], end_time[10][10];
int price[10], i = 0, j = 0, k = 0, l = 0, x = 0; /* ----------定义全局变量---------- */
void set( void );
void search( void );
void sum( void );
void sort( void );
void edit( void );
void del( void );
int main( void )
{
    int o;  /* ----------o在此处为选项数值---------- */
/*----------以下代码为主菜单选项----------*/
    for ( o = 1; o != 0; o )
    {
        printf( "\n------------------------------------------------\n" );
        printf( "----------欢迎使用火车票管理系统主菜单----------" );
        printf( "\n------------------------------------------------\n" );
        printf( "          1.set                (录入)\n" );
        printf( "          2.search              (查询)\n" );
        printf( "          3.sum                (统计)\n" );
        printf( "          4.sort                (排序)\n" );
        printf( "          5.edit                (编辑)\n" );
        printf( "          6.del                (删除)\n" );
        printf( "          0.exit                (退出)\n" );
        printf( "\n请输入要选择的服务项目:" );
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
            printf( "\n请输入正确的数字!n\n" );
    }
}
/*----------录入子函数---------*/
void set( void )
{
    printf( "\n请输入准备录入的信息数:" );
    scanf( "%d", &i );
    if ( i <= 0 || i > 10 )
    {
        printf( "\n----------请正确输入1-10之间的整数!----------\n" );
        return;
    }
    i = i + x;
    for ( j = x; j < i; j++ )
    {
        ++x; /* ----------记录录入的信息总条数---------- */
        printf( "\n请输入车次:" );
        scanf( "%s", &trains[j] );
        printf( "\n请输入出发站:" );
        scanf( "%s", &start_station[j] );
        printf( "\n请输入终点站:" );
        scanf( "%s", &end_station[j] );
        printf( "\n请输入发车时间:" );
        scanf( "%s", &start_time[j] );
        printf( "\n请输入到达时间:" );
        scanf( "%s", &end_time[j] );
        printf( "\n请输入票价:" );
        scanf( "%d", &price[j] );
    }
    printf( "\n----------信息录入完毕----------n\n" );
}
/*----------查询子函数----------*/
void search( void )
{
    char    search[10];
    int search1;
    k = 0;
    if ( x == 0 )
    {
        printf( "\n----------暂无数据可查询!----------\n" );
        return;
    }
    printf( "\n--------------------------------\n" );
    printf( "----------查询功能菜单----------" );
    printf( "\n--------------------------------\n" );
    printf( "          1.车次\n" );
    printf( "          2.出发站\n" );
    printf( "          3.终点站\n" );
    printf( "          4.发车时间\n" );
    printf( "          5.到达时间\n" );
    printf( "          6.票价\n" );
    printf( "\n请输入要查询方式的编号:" );
    scanf( "%d", &l );
    if ( x == 0 )
    {
        printf( "\n----------当前数据库为空----------\n" );
    }else if ( l == 1 )
    {
        printf( "\n请输入需要查询的车次:" );
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
                    printf( "车次 出发站 终点站 发车时间 到达时间 票价" );
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
        printf( "\n----------查询结束,本次共查询的%d个结果----------n\n", k );
    }else if ( l == 2 )
    {
        printf( "\n请输入需要查询的出发站:" );
        scanf( "%s", search );
        for ( i = 0; i < x; i++ )
        {
            j = strcmp( search, start_station[i] );
            if ( j == 0 )
            {
                ++k;
                if ( k == 1 )
                    printf( "\n车次 出发站 终点站 发车时间 到达时间 票价\n" );
                printf( "%-8s ", trains[i] );
                printf( "%-10s ", start_station[i] );
                printf( "%-10s ", end_station[i] );
                printf( "%-12s ", start_time[i] );
                printf( "%-12s ", end_time[i] );
                printf( "%-8d", price[i] );
                printf( "\n" );
            }
        }
        printf( "\n----------查询结束,本次共查询的%d个结果----------n\n", k );
    }else if ( l == 3 )
    {
        printf( "\n请输入需要查询的终点站:" );
        scanf( "%s", search );
        for ( i = 0; i < x; i++ )
        {
            j = strcmp( search, end_station[i] );
            if ( j == 0 )
            {
                ++k;
                if ( k == 1 )
                    printf( "\n车次 出发站 终点站 发车时间 到达时间 票价\n" );
                printf( "%-8s ", trains[i] );
                printf( "%-10s ", start_station[i] );
                printf( "%-10s ", end_station[i] );
                printf( "%-12s ", start_time[i] );
                printf( "%-12s ", end_time[i] );
                printf( "%-8d", price[i] );
                printf( "\n" );
            }
        }
        printf( "\n----------查询结束,本次共查询的%d个结果----------n\n", k );
    }else if ( l == 4 )
    {
        printf( "\n请输入需要查询的发车时间:" );
        scanf( "%s", search );
        for ( i = 0; i < x; i++ )
        {
            j = strcmp( search, start_time[i] );
            if ( j == 0 )
            {
                ++k;
                if ( k == 1 )
                    printf( "\n-------------------------------------------------------------\n" );
                printf( "车次 出发站 终点站 发车时间 到达时间 票价" );
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
        printf( "\n----------查询结束,本次共查询的%d个结果----------n\n", k );
    }else if ( l == 5 )
    {
        printf( "\n请输入需要查询的到达时间:" );
        scanf( "%s", search );
        for ( i = 0; i < x; i++ )
        {
            j = strcmp( search, end_time[i] );
            if ( j == 0 )
            {
                ++k;
                if ( k == 1 )
                    printf( "\n-------------------------------------------------------------\n" );
                printf( "车次 出发站 终点站 发车时间 到达时间 票价" );
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
        printf( "\n----------查询结束,本次共查询的%d个结果----------n\n", k );
    }else if ( l == 6 )
    {
        printf( "\n请输入需要查询的票价:" );
        scanf( "%d", &search1 );
        for ( i = 0; i < x; i++ )
        {
            j = search1 == price[i] ? 0 : 1;
            if ( j == 0 )
            {
                ++k;
                if ( k == 1 )
                    printf( "\n-------------------------------------------------------------\n" );
                printf( "车次 出发站 终点站 发车时间 到达时间 票价" );
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
        printf( "\n----------查询结束,本次共查询的%d个结果----------n\n", k );
    }else
        printf( "\n请正确输入排序方式编号!\n" );
}
/*----------列表子函数----------*/
void sum( void )
{
    if ( x != 0 )
    {
        printf( "\n----------------------------------------------------------------------\n" );
        printf( "编号 车次 出发站 终点站 发车时间 到达时间 票价" );
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
    printf( "\n----------共有%d条记录----------\n", x );
}
/*----------排序子函数----------*/
void sort( void )
{
    char    sort[1][10];
    int sort1;
    if ( x == 0 )
    {
        printf( "\n----------无数据可排序!----------\n" );
        return;
    }
    printf( "\n--------------------------------\n" );
    printf( "----------排序功能菜单----------" );
    printf( "\n--------------------------------\n" );
    printf( "          1.车次\n" );
    printf( "          2.出发站\n" );
    printf( "          3.终点站\n" );
    printf( "          4.发车时间\n" );
    printf( "          5.到达时间\n" );
    printf( "          6.票价\n" );
    printf( "\n请输入要排序的序号:" );
    scanf( "%d", &k );
/*----------以下为排序工作流程----------*/
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
        printf( "\n----------你的输入错误!----------n\n" );
/*----------排序工作流程结束----------*/
    printf( "\n-------------------------------------------------------------\n" );
    printf( "车次 出发站 终点站 发车时间 到达时间 票价" );
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
/*----------编辑子函数----------*/
void edit( void )
{
    if ( x != 0 )
    {
        printf( "\n----------------------------------------------------------------------\n" );
        printf( "编号 车次 出发站 终点站 发车时间 到达时间 票价" );
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
        printf( "----------编辑功能主菜单----------" );
        printf( "\n----------------------------------\n" );
    }
    if ( x == 0 )
        printf( "\n----------没有数据可编辑!----------\n" );
    else{
        printf( "\n请输入要修改信息的编号:" );
        scanf( "%d", &j );
        if ( j >= 1 && j <= x )
        {
            printf( "\n--------------" );
            printf( "\n  1.车次      " );
            printf( "\n  2.出发站    " );
            printf( "\n  3.终点站    " );
            printf( "\n  4.发车时间  " );
            printf( "\n  5.到达时间  " );
            printf( "\n  6.票价      " );
            printf( "\n--------------" );
            printf( "\nn请输入要修改的项目:" );
            scanf( "%d", &k );
            if ( k == 1 || k == 2 || k == 3 || k == 4 || k == 5 || k == 6 )
            {
                printf( "\n请输入你要修改的数据:" );
                if ( k == 1 )
                {
                    scanf( "%s", &trains[j - 1] );
                    printf( "\n----------编辑操作成功----------\n" );
                }else if ( k == 2 )
                {
                    scanf( "%s", &start_station[j - 1] );
                    printf( "\n----------编辑操作成功----------\n" );
                }else if ( k == 3 )
                {
                    scanf( "%s", &end_station[j - 1] );
                    printf( "\n----------编辑操作成功----------\n" );
                }else if ( k == 4 )
                {
                    scanf( "%s", &start_time[j - 1] );
                    printf( "\n----------编辑操作成功----------\n" );
                }else if ( k == 5 )
                {
                    scanf( "%s", &end_time[j - 1] );
                    printf( "\n----------编辑操作成功----------\n" );
                }else  {
                    scanf( "%d", &price[j - 1] );
                    printf( "\n----------编辑操作成功----------\n" );
                }
            }else
                printf( "\n----------请输入正确的项目!----------\n" );
        }else
            printf( "\n----------请输入正确的编号!----------\n" );
    }
}
/*----------删除子函数----------*/
void del( void )
{
    if ( x != 0 )
    {
        printf( "\n----------------------------------------------------------------------\n" );
        printf( "编号 车次 出发站 终点站 发车时间 到达时间 票价" );
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
        printf( "----------删除功能主菜单----------" );
        printf( "\n----------------------------------\n" );
        printf( "\n请输入以上要删除信息的编号:" );
        scanf( "%d", &j );
    }
    if ( x == 0 )
        printf( "\n----------没有数据可删除!----------\n" );
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
        printf( "\n----------删除操作成功!----------\n" );
    }else if ( j == x )
    {
        x = x - 1;
        printf( "\n----------删除操作成功!----------\n" );
    }else
        printf( "\n----------请输入正确的编号!----------\n" );
}