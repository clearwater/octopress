---

title: "Google OAuth2 for Devices Revisited"
date: "2017-01-01T13:03:00+10:00"
comments: true
categories:
 - Python
 - Raspberry Pi
---

{{< img src="/resources/2012-11-06/oauth-2-sm.png" pos="right" >}}

I just dusted off an old project that uses
[Google's OAuth 2.0 for Devices](https://developers.google.com/identity/protocols/OAuth2ForDevices) API to
authenticate against Google Docs, and cleaned up my implementation.  

OAuth2ForDevices is really useful for IoT projects
that use Google APIs.  I'm using it for a device that records data directly a Google Sheet.  

While the API itself is pretty straight forward, getting the implementation 100%
battle-hardened takes a bit of work and iteration, so I'll share here what I've learned.
If you are coding in Python, you might find the OAuth class in the
 [py-gaugette](https://github.com/guyc/py-gaugette) library useful.

<!--more-->

## Theory of operation
### First-Boot OAuth2 Flow

{{< img src="/resources/2017-01-01/deviceflow.png" pos="right" >}}

The first time a device boots, it needs to request permissions from the user to access
Google Docs.

  * call the OAuth2 API to specify the permissions required and request an authorisation code.
  * show the auth code to the user
  * poll the OAuth2 API waiting for confirmation that the user has granted access to the device.
  * save the refresh token in persistent storage for next startup.

To confirm access, the user uses a web browser on a separate device, and navigates to
https://www.google.com/device to enter the authorisation code.  
The user must be logged in to a Google account when they confirm the permissions, and the
device will be granted access on behalf of that account.  The level of access is determined
by the scope parameters passed by the device, and the user will be shown which permissions
have been requested before they confirm.

### After the First Boot
On subsequent boots the device can use the saved refresh token to authenticate, so
no further user interaction is required.

## Here's What It Looks Like

### 1. The Device Presents a Code

On my time clock, I display the code on the one-line OLED display.  The device code can be quite long - the API docs
recommend ensuring you can display 15 'W'-sized characters, although current codes are formatted as XXXX-XXXX.  The length of generated codes
has increased since I first started using this API and I now need to use horizontal scrolling to
display the entire code.

{{< img src="/resources/2017-01-01/device-auth.png" >}}

### 2. The User Enters the Code

You need to communicate the URL (https://www.google.com/device) to the user somehow.  
This is the web page they will see.  They may first be prompted to log in to their
Google account or select from multiple logged in accounts.

{{< img src="/resources/2017-01-01/oauth_1.png" >}}

### 3. The User Confirms Access

The permissions listed here are determined by the scope variables you have passed.  The list of
available scopes is [defined here](https://developers.google.com/identity/protocols/googlescopes).

{{< img src="/resources/2017-01-01/oauth_2.png" >}}

## On the Device

Here's what it looks like on the device.

{{< youtube tZ6XZ1yhHJM >}}

## Making API Calls With OAuth2 tokens

The most complicated aspect of this API is passing the credentials and handling
exceptions, and a lot has changed since I wrote the earlier Feeds implementation.  Now
I'm using the [Google API Client Libraries for Python](https://developers.google.com/api-client-library/python/start/installation)
and passing in the token via a  [oauth2client.client.GoogleCredientials](http://oauth2client.readthedocs.io/en/latest/source/oauth2client.client.html#oauth2client.client.GoogleCredentials)
instance.

One nasty little surprise I discovered with long-running applications
is that after the device has idled for a long time (say 24 hours without making an API call) I start getting
BadStatusLine exceptions on all API calls.  To handle this and other errors,
I use @wrap from functools to wrap all of the API calls in a retry function.  This keeps
the extra complexity of error recovery nicely abstracted away.
