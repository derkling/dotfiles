#!/usr/bin/env python3
# This script is useful for setting fallback mtime for isync/mbsync CopyArrivalDate option
# If you use notmuch then you could do something like this to fix mtime on new mail
# notmuch search --output=files tag:new | xargs -P0 -i ~/code/mailutils/fix_maildir_mtime.py {}

import email
import sys
import os
from email.utils import parsedate_tz, mktime_tz

if len(sys.argv) < 2:
    print("Usage: {} email".format(sys.argv[0]))
    sys.exit(1)

mfp = open(sys.argv[1], 'rb')

mail_stat = os.stat(mfp.fileno())
msg = email.message_from_binary_file(mfp)
for header in ("Date", "Received"):
    value = msg.get(header)
    if value is None:
        continue
    try:
        email_date = parsedate_tz(value.split('\n')[-1].split(';')[-1].strip())
        os.utime(mfp.fileno(), (mail_stat.st_atime, mktime_tz(email_date)))
    except:
        pass
