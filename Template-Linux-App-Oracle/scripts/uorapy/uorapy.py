#! /usr/bin/env python
# -*- coding: utf-8 -*-

"""
    Author: Ricardo F Klein
    Email:  klein.rfk at gmail dot com
"""

import cx_Oracle
import json
import re
import sys

# GLOBAL VARS
debug = "no"


def show_debug_message(msg):
    if debug == "yes":
        print "DEBUG: {0}".format(msg)


def config_load():
    show_debug_message("LOADING CONFIG")
    with open(sys.argv[1], 'r') as config_file:
        config_data = json.load(config_file)
        return config_data


def database_connection():
    show_debug_message("CONNECTING TO DATABASE")
    conf = config_load()
    conn = cx_Oracle.connect(
        "{0}/{1}@{2}/{3}".format(
            conf["connection_config"]['user'],
            conf["connection_config"]['password'],
            conf["connection_config"]['host'],
            conf["connection_config"]['database']))
    return conn


def execute_query(sql):
    show_debug_message("RUNNING QUERY")
    cursor = database_connection().cursor()
    cursor.execute(sql)
    res = cursor.fetchall()
    return res


def db_owners_lld():
    conf = config_load()
    conf = conf['owners_to_check']
    print("{ ")
    print("\t\"data\":[")
    for i in range(len(conf)):
        if i < (len(conf) - 1):
            print "\t\t", json.dumps(conf[i]), ","
        else:
            print "\t\t", json.dumps(conf[i])
    print "\t]"
    print "}"


def active_sessions_count():
    sql = " SELECT COUNT(1) \
                FROM gv$session \
                WHERE type = 'USER' \
                    AND status='ACTIVE' "
    sqlresult = execute_query(sql)
    for i in sqlresult:
        print i[0]


def show_invalid_objects(db_owner, objecttype):
    sql = " SELECT OBJECT_NAME \
                FROM DBA_OBJECTS \
                WHERE STATUS = 'INVALID'\
                    AND OWNER = '{0}' \
                    AND OBJECT_TYPE = '{1}'".format(db_owner, objecttype)
    sqlresult = execute_query(sql)
    if len(sqlresult) != 0:
        print "{0} invalid {1} found: {2}".format(len(sqlresult), objecttype, sqlresult)
    else:
        print "."


def show_unusable_indexes(db_owner):
    sql = " SELECT index_name    \
             FROM dba_indexes   \
            WHERE status = 'UNUSABLE'   \
            AND owner = '{0}' ".format(db_owner)
    sqlresult = execute_query(sql)
    if len(sqlresult) != 0:
        print "{0} invalid indexes found: {1}".format(len(sqlresult), sqlresult)
    else:
        print "."


def show_top_concurrent_queries(running_time, concurrent_qtd):
    sql = " SELECT * \
                FROM \
                    (SELECT user, sql_id, count(1) from gv$session \
                        WHERE type = 'USER' \
                            AND status = 'ACTIVE' \
                            AND last_call_et >= '{0}' \
                            AND user != 'ZABBIX' \
                        GROUP BY sql_id \
                        HAVING count(*) >= '{1}' \
                        ORDER BY 2 desc) \
                WHERE rownum < 5".format(running_time, concurrent_qtd)
    sqlresult = execute_query(sql)
    print "USER           SQL_ID       COUNT"
    for i in sqlresult:
        USER = str(i[0]).ljust(15)[:15]
        SQL_ID = str(i[1]).ljust(14)[:14]
        COUNT = str(i[2]).ljust(5)
        print SQL_ID + " " + COUNT


def show_active_queries():
    show_debug_message("function show_active_queryes")
    sql = " SELECT s.sid    \
                , s.serial# \
                , s.username    \
                , x.sql_id  \
                , x.sql_text    \
                , s.machine \
                , (((x.elapsed_time / 1000000) / x.executions) + ((x.cpu_time / 1000000) / x.executions)) ordenation \
            FROM gv$session s   \
                , v$sql x   \
            WHERE s.status = 'ACTIVE'   \
                AND x.sql_id = s.sql_id \
                AND x.executions > 0    \
                AND s.username != 'ZABBIX'  \
                AND ROWNUM < 21 \
            ORDER BY ordenation DESC \
        "
    sqlresult = execute_query(sql)
    print "SID     SERIAL  USERNAME         SQL_ID         SQL_TEXT                                  MACHINE"
    for i in sqlresult:
        Sid = str(i[0]).ljust(6)[:6]
        Serial = str(i[1]).ljust(6)[:6]
        Username = str(i[2]).ljust(15)[:15]
        Sqlid = i[3]
        Sqltext = i[4].replace('\n', '').replace('\r', '').replace('\t',' ').replace('   ',' ').lstrip(' ').ljust(40)[:40]
        Machine = i[5].ljust(20)[:20]
        print Sid + "  " + Serial + "  " + Username + "  " + Sqlid + "  " + Sqltext + "  " + Machine


def show_top_queries_from_last_10min():
    sql = " SELECT u.username  \
                , a.sql_id  \
                , dbms_lob.substr(a.sql_fulltext, 4000, 1) sql_text  \
                , a.executions  \
                , a.rows_processed  \
                , a.last_active_time  \
                , (((a.elapsed_time / (1000000)) / a.executions) + ((a.cpu_time / 1000000) / a.executions)) ordenation  \
            FROM v$sqlarea a,  \
                dba_users u  \
            WHERE a.last_active_time BETWEEN SYSDATE - 0.00695 AND SYSDATE  \
                AND a.executions > 0  \
                AND u.user_id = a.parsing_user_id  \
                AND u.username NOT IN ('SYS', 'SYSTEM', 'ZABBIX', 'PERFSTAT')  \
                AND ROWNUM < 21  \
            ORDER BY ordenation DESC  \
            "
    sqlresult = execute_query(sql)
    print "USERNAME         SQL_ID         SQL_TEXT                                  EXECUTIONS       ROWS            LAST_TIME"
    for i in sqlresult:
        Username = str(i[0]).ljust(15)[:15]
        Sqlid = str(i[1])
        Sqltext = str(i[2]).replace('\n','').replace('\r','').replace('\t',' ').replace('   ',' ').lstrip(' ').ljust(40)[:40]
        Executions = str(i[3]).ljust(15)[:15]
        Rows = str(i[4]).ljust(14)[:14]
        Lasttime = str(i[5]).ljust(10)[:10]
        print Username + "  " + Sqlid + "  " + Sqltext + "  " + Executions + "  " + Rows + "  " + Lasttime


def tablespaces_lld():
    sql = "SELECT TABLESPACE_NAME FROM DBA_TABLESPACES"
    sqlresult = execute_query(sql)
    print("{ ")
    print("\t\"data\":[")
    for i in range(len(sqlresult)):
        tablespace = ''.join(sqlresult[i])
        if i < (len(sqlresult) - 1):
            print "\t\t{\"{#TABLESPACENAME}\" : " + "\"" + tablespace + "\"},"
        else:
            print "\t\t{\"{#TABLESPACENAME}\" : " + "\"" + tablespace + "\"}"
    print "\t]"
    print "}"


def show_tablespace_total_size(tablespacename):
    sql = " SELECT SUM(BYTES) AS BYTES \
                FROM DBA_DATA_FILES \
                WHERE TABLESPACE_NAME = '{0}'".format(tablespacename)
    sqlresult = execute_query(sql)
    for i in sqlresult:
        print i[0]


def show_tablespace_used_size(tablespacename):
    sql = " SELECT \
                round((kbytes_alloc-nvl(kbytes_free,0))*1024, 2) used \
                FROM (SELECT sum(bytes)/1024 Kbytes_free,  tablespace_name \
                        FROM sys.dba_free_space \
                        GROUP BY tablespace_name )a \
                            ,(  SELECT sum(bytes)/1024 Kbytes_alloc, sum(maxbytes)/1024 Kbytes_max, tablespace_name \
                                    FROM sys.dba_data_files \
                                    GROUP BY tablespace_name \
                                UNION ALL \
                                SELECT sum(bytes)/1024 Kbytes_alloc, sum(maxbytes)/1024 Kbytes_max, tablespace_name \
                                    FROM sys.dba_temp_files group by tablespace_name )b \
                                    WHERE a.tablespace_name (+) = b.tablespace_name \
                                        AND b.tablespace_name = '{0}'".format(tablespacename)
    sqlresult = execute_query(sql)
    for i in sqlresult:
        print i[0]


def show_tablespace_free_size(tablespacename):
    sql = " SELECT \
                round(((nvl(kbytes_free,0))/ kbytes_alloc)*100, 2) pct_free \
                FROM (SELECT sum(bytes)/1024 Kbytes_free,  tablespace_name \
                        FROM sys.dba_free_space \
                        GROUP BY tablespace_name )a \
                            ,(SELECT sum(bytes)/1024 Kbytes_alloc, sum(maxbytes)/1024 Kbytes_max, tablespace_name \
                                FROM sys.dba_data_files \
                                GROUP BY tablespace_name \
                              UNION ALL \
                              SELECT sum(bytes)/1024 Kbytes_alloc, sum(maxbytes)/1024 Kbytes_max, tablespace_name \
                                FROM sys.dba_temp_files group by tablespace_name )b \
                                WHERE a.tablespace_name (+) = b.tablespace_name \
                                    AND b.tablespace_name = '{0}'".format(tablespacename)
    sqlresult = execute_query(sql)
    for i in sqlresult:
        print i[0]


def disk_groups_lld():
    sql = "SELECT NAME FROM V$ASM_DISKGROUP"
    sqlresult = execute_query(sql)
    print("{ ")
    print("\t\"data\":[")
    for i in range(len(sqlresult)):
        diskgroup = ''.join(sqlresult[i])
        if i < (len(sqlresult) - 1):
            print "\t\t{\"{#DGNAME}\" : " + "\"" + diskgroup + "\"},"
        else:
            print "\t\t{\"{#DGNAME}\" : " + "\"" + diskgroup + "\"}"
    print "\t]"
    print "}"


def show_disk_group_total_size(diskgroup):
    sql = " SELECT \
                a.TOTAL_MB*1024*1024 as Total_Bytes \
                from v$asm_diskgroup a \
                where a.TOTAL_MB > 0 \
                and a.NAME = '{0}'".format(diskgroup)
    sqlresult = execute_query(sql)
    for i in sqlresult:
        print i[0]


def show_disk_group_used_size(diskgroup):
    sql = " SELECT \
                ((a.TOTAL_MB-a.FREE_MB)*1024*1024) as Used_Bytes \
                FROM v$asm_diskgroup a \
                WHERE a.TOTAL_MB > 0 \
                    and a.NAME = '{0}'".format(diskgroup)
    sqlresult = execute_query(sql)
    for i in sqlresult:
        print i[0]


def show_disk_group_free_size(diskgroup):
    sql = " SELECT \
                to_char(((a.FREE_MB * 100 /a.TOTAL_MB)),'99.99') \"PCT_FREE\" \
                FROM v$asm_diskgroup a \
                where a.TOTAL_MB > 0 \
                and a.NAME = '{0}'".format(diskgroup)
    sqlresult = execute_query(sql)
    for i in sqlresult:
        print i[0].strip()


def not_online_disks_count():
    sql = " SELECT COUNT(1) FROM GV$ASM_DISK \
               WHERE MODE_STATUS != 'ONLINE' "
    sqlresult = execute_query(sql)
    for i in sqlresult:
        print i[0]

if __name__ == "__main__":
    if sys.argv[2] == "db_owners_lld":
        db_owners_lld()
    if sys.argv[2] == "tablespaces_lld":
        tablespaces_lld()
    if sys.argv[2] == "disk_groups_lld":
        disk_groups_lld()
    if sys.argv[2] == "active_sessions_count":
        active_sessions_count()
    if sys.argv[2] == "show_invalid_objects":
        show_invalid_objects(sys.argv[3], sys.argv[4])
    if sys.argv[2] == "show_unusable_indexes":
        show_unusable_indexes(sys.argv[3])
    if sys.argv[2] == "show_top_concurrent_queries":
        show_top_concurrent_queries(sys.argv[3], sys.argv[4])
    if sys.argv[2] == "show_active_queries":
        show_active_queries()
    if sys.argv[2] == "show_top_queries_from_last_10min":
        show_top_queries_from_last_10min()
    if sys.argv[2] == "not_online_disks_count":
        not_online_disks_count()
    if sys.argv[2] == "show_tablespace_total_size":
        show_tablespace_total_size(sys.argv[3])
    if sys.argv[2] == "show_tablespace_used_size":
        show_tablespace_used_size(sys.argv[3])
    if sys.argv[2] == "show_tablespace_free_size":
        show_tablespace_free_size(sys.argv[3])
    if sys.argv[2] == "show_disk_group_total_size":
        show_disk_group_total_size(sys.argv[3])
    if sys.argv[2] == "show_disk_group_used_size":
        show_disk_group_used_size(sys.argv[3])
    if sys.argv[2] == "show_disk_group_free_size":
        show_disk_group_free_size(sys.argv[3])
