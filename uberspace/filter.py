#!/usr/local/bin/python3
# use in .qmail-name like that
#   | /usr/bin/spamc --socket=/home/UBERSPACEUSER/tmp/spamd.sock | ./filter.py ~/users/m/

import sys, mailbox

MAILDIR = sys.argv[1]

THIS_MAIL = ""
RECEIPT_FOUND = False
SUBJECT_FOUND = False
FILTER = {'name@example.tld':  'Maildir Folder'}
DESTINATION = None

for line in sys.stdin:
    THIS_MAIL += line
    if not RECEIPT_FOUND and line.find("To:") == 0:
        RECEIPT_FOUND = True
        for key in FILTER.keys():
            if line.find(key) > -1:
                DESTINATION = 'INBOX.' + FILTER[key]
    if not SUBJECT_FOUND and line.find("Subject:") == 0:
        SUBJECT_FOUND = True
        if line.find("[SPAM]") > -1:
            DESTINATION = "SPAM"

md = mailbox.Maildir(MAILDIR,  factory = None, create = True)

if DESTINATION is not None:
    md = md.get_folder(DESTINATION)

md.add(THIS_MAIL)
