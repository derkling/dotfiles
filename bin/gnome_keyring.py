#!/usr/bin/env python3

import gnomekeyring as gkey
import argparse

parser = argparse.ArgumentParser(description='GNome Keyring Credentials Proxy')
parser.add_argument('-u',
                    dest='get_username',
                    action='store_const',
                    const=True,
                    default=False,
                    help='return the username')
parser.add_argument('-p',
                    dest='get_password',
                    action='store_const',
                    const=True,
                    default=False,
                    help='return the password')
parser.add_argument('repo',
                    nargs=1,
                    type=str,
                    help='repository to use')
parser.add_argument('username',
                    nargs='?',
                    type=str,
                    help='username to store')

def set_credentials(repo, user, pw):
    KEYRING_NAME = "offlineimap"
    if isinstance(repo, list):
        repo = repo[0]
    if isinstance(user, list):
        user = user[0]
    attrs = { "repo": repo, "user": user }
    keyring = gkey.get_default_keyring_sync()
    print("Set password in keyring [%s] using %s" % (KEYRING_NAME, attrs))
    gkey.item_create_sync(keyring, gkey.ITEM_NETWORK_PASSWORD,
        KEYRING_NAME, attrs, pw, True)

def get_credentials(repo):
    keyring = gkey.get_default_keyring_sync()
    attrs = {"repo": repo}
    items = gkey.find_items_sync(gkey.ITEM_NETWORK_PASSWORD, attrs)
    return (items[0].attributes["user"], items[0].secret)

def get_username(repo):
    return get_credentials(repo)[0]
def get_password(repo):
    return get_credentials(repo)[1]

# NOTE: the content of the keyring can be inspected and manipulated using the
# "seahorse" GUI under GNOME

if __name__ == "__main__":
    import sys
    import os
    import getpass

    # Parse command line args
    args = parser.parse_args()

    # Store credentials
    if args.repo and args.username:
        password = getpass.getpass("Enter password for user '%s': " % args.username)
        password_confirmation = getpass.getpass("Confirm password: ")
        if password != password_confirmation:
            print("Error: password confirmation does not match")
            sys.exit(1)
        set_credentials(args.repo, args.username, password)
        sys.exit(0)

    # Get username
    if args.repo and args.get_username:
        print(get_username(args.repo[0]))
        sys.exit(0)

    # Get password
    if args.repo and args.get_password:
        print(get_password(args.repo[0]))
        sys.exit(0)

    # By default return complete credentials
    credentials = get_credentials(args.repo[0])
    print(credentials[0], credentials[1])
