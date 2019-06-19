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


def filiais_lld():
    conf = config_load()
    conf = conf['filiais_to_check']
    print("{ ")
    print("\t\"data\":[")
    for i in range(len(conf)):
        if i < (len(conf) - 1):
            print "\t\t", json.dumps(conf[i]), ","
        else:
            print "\t\t", json.dumps(conf[i])
    print "\t]"
    print "}"


def return_usu_intnfv(cod_filial):
    sql = "SELECT COUNT(1) \
                FROM SAPIENS.e140nfv \
                WHERE codemp = 1 \
                    AND codfil = {0} \
                    AND usu_intnfv is null".format(cod_filial)
    sqlresult = execute_query(sql)
    for i in sqlresult:
        print i[0]

def return_usu_intcan(cod_filial):
    sql = "SELECT COUNT(1) \
                FROM SAPIENS.e140nfv \
                WHERE codemp = 1 \
                    AND codfil = {0} \
                    AND sitnfv = 3 \
                    AND usu_intcan is null".format(cod_filial)
    sqlresult = execute_query(sql)
    for i in sqlresult:
        print i[0]


if __name__ == "__main__":
    if sys.argv[2] == "filiais_lld":
        filiais_lld()
    if sys.argv[2] == "return_usu_intnfv":
        return_usu_intnfv(sys.argv[3])
    if sys.argv[2] == "return_usu_intcan":
        return_usu_intcan(sys.argv[3])
