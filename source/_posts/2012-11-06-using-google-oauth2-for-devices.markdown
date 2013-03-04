---
layout: post
title: "Using Google OAuth2 for Devices"
date: 2012-11-06 13:03
comments: true
categories:
 - Raspberry Pi
---

I've been working on a Raspberry Pi based device that needs to log data to a Google Docs spreadsheet.
There are some fine classes like [gdata](http://code.google.com/p/gdata-python-client/) and [gspread](https://github.com/burnash/gspread)
that do just this.

However if you read the [tutorial at Adafruit](http://learn.adafruit.com/dht-humidity-sensing-on-raspberry-pi-with-gdocs-logging/connecting-to-google-docs)
which uses the [gspread library](http://pypi.python.org/pypi/gspread/) you will see that
it uses the ClientLogin API for authentication, and so somewhere you need to include your Google username and password in plain text.
There are several problems with this in the context of an embedded device:

 * You need to provide a way for the user to enter their credentials on the device which may have no keyboard or GUI,
 * The credientials are stored in a non-secure way,
 * The [ClientLogin API is officially deprecated](https://developers.google.com/accounts/docs/AuthForInstalledApps),
 * I personally live in fear of accidentally committing code with plain-text credentials to GitHub.

So I don't want to use ClientLogin.

{% img right /resources/2012-11-06/oauth-2-sm.png %}

It turns out the Google's OAuth2 implementation has a great alternative for embedded applications; [OAuth 2.0 for Devices](https://developers.google.com/accounts/docs/OAuth2ForDevices).  Here's the high-level overview of how the authentication works:

 1. Just once, register your application with the [Google APIs console](https://code.google.com/apis/console/) and get a __client_key__ and __client_secret__,
 2. When your application runs for the first time, it sends an authentication request to Google which returns a short plain-text __user_code__,
 3. Your device shows the __user_code__ to the user and gives them instructions to enter that code at [http://www.google.com/device](http://www.google.com/device).
 4. Your application starts polling a Google web service waiting for confirmation that the user has approved the application,
 5. The user enters the code to Google's form, and confirms the level of permissions the application has requested,
 6. Your application gets a response from the web service it has been polling with an __access_token__ and a __refresh_token__.
 7. You pass this __access_token__ in the header of all API requests
 
The __access_token__ will expire after a relatively short time (1 hour?).  When the token expires,
it can be refreshed by making another API call using the __refresh_token__.  This returns a fresh __access_token__
but does not return an udpated __refresh_token__.  The original __refresh_token__ does not expire.

I could not find any documentation explaining how to
use the __access_token__ with any of the existing API libraries.
As far as I can tell Google's python gdata library doesn't have explicit
support for this form of authentication, but it turns out you can make it work
if you send an appropriately formatted Authorization header to the
service constructor like this:

```
headers = {
  "Authorization": "%s %s" % (token['token_type'], token['access_token'])  
}
client = gdata.spreadsheet.service.SpreadsheetsService(additional_headers=headers)
```
The extra header will be something like ```Authorization: Bearer 1/fFBGRNJru1FQd44AzqT3Zg```.
I've wrapped up what I've figured out so far into an 
[oauth class](https://github.com/guyc/py-gaugette/blob/master/src/gaugette/oauth.py)
in the [python gaugette library "py-gaugette"](https://github.com/guyc/py-gaugette).

Here's an example of how it can be used to authenticate and add a row to the end of a spreadsheet.  The library saves
the authentication tokens to the local file system so that the user only has to authenticate the device once.
The explicit token-expiration handling isn't great.  In ruby I could encapsulate that nicely using block parameters,
but I haven't yet figured out a clean abstraction for python.
The user can revoke access to the device via [this Google page](https://accounts.google.com/IssuedAuthSubTokens).

```
import gaugette.oauth
import datetime
import gdata.service
import sys

CLIENT_ID       = 'your client_id here'
CLIENT_SECRET   = 'your client secret here'
SPREADSHEET_KEY = 'your spreadsheet key here'

oauth = gaugette.oauth.OAuth(CLIENT_ID, CLIENT_SECRET)
if not oauth.has_token():
    user_code = oauth.get_user_code()
    print "Go to %s and enter the code %s" % (oauth.verification_url, user_code)
    oauth.get_new_token()

gd_client = oauth.spreadsheet_service()
spreadsheet_id = SPREADSHEET_KEY
try:
    worksheets_feed = gd_client.GetWorksheetsFeed(spreadsheet_id)
except gdata.service.RequestError as error:
    if (error[0]['status'] == 401):
        oauth.refresh_token()
        gd_client = oauth.spreadsheet_service()
        worksheets_feed = gd_client.GetWorksheetsFeed(spreadsheet_id)
    else:
        raise
    
worksheet_id = worksheets_feed.entry[0].id.text.rsplit('/',1)[1]

now = datetime.datetime.now().isoformat(' ')
row = {
    'project': 'datatest',
    'start'  : now,
    'finish' : now
    }

try:
    gd_client.InsertRow(row, spreadsheet_id, worksheet_id)
except gdata.service.RequestError as error:
    if (error[0]['status'] == 401):
        oauth.refresh_token()
        gd_client = oauth.spreadsheet_service()
        gd_client.InsertRow(row, spreadsheet_id, worksheet_id)
    else:
        raise

print "done"    
```
