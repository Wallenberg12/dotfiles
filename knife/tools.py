# -*- coding: utf-8 -*-
"""
Created on Thu Nov 24 12:09:33 2016

@author: markus
"""

# returns the PID and memory peak of python process itself
def process_information ():
    result = {'memory_peak': 0, 'PID': None}
    fh = open('/proc/self/status')
    for line in fh:
        if (line.find ("VmPeak:") == 0):
            result["memory_peak"] = float (line.split (":")[1].strip ().split (" ")[0])
        if (line.find ("Pid:") == 0):
            result["PID"] = int (line.split (":")[1].strip ())
    fh.close ()
    return result
            