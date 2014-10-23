# winlogon

#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Usage - Configuration options and additional functionality](#usage)
4. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)

## Overview

winlogon is a defined type that manages the logon message that pops up before the username and password prompt on a Windows server.

## Module Description

The winlogon defined type edits two values in the registry:

	HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon\LegalNoticeCaption
	HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon\LegalNoticeText

Any value will cause the logon screen to appear.  A null entry will remove the screen.

## Usage

### Parameters

	ensure  => present | absent  # set the ensure status
	caption => 'your caption message here' # the caption, defaults to $title
	message => 'your message here' # the message, defaults to $title

If you need multiple paragraphs, you can use an array for the message, or use double quotes and the \n escape character in the message string.

### Examples: 

Set caption and message to "AUTHORIZED USERS ONLY":

	winlogon { 'AUTHORIZED USERS ONLY' : }

Set caption and a separate message:
   
	winlogon { 'AUTHORIZED USERS ONLY' :
	  message => 'This system is for authorized users only.  All logins will be reported',
	}

Set caption and a really long message :

	winlogon { 'AUTHORIZED USERS ONLY' :
	  message => ['Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec a diam lectus.',
	    'Sed sit amet ipsum mauris. Maecenas congue ligula ac quam viverra nec consectetur ante hendrerit.',
	    'Donec et mollis dolor. Praesent et diam eget libero egestas mattis sit amet vitae augue.'],
	}

## Reference

Defined Type: winlogon

## Limitations

Tested on Windows 2008 R2 and Windows 2012 R2 with Windows Management Framework 3.0 and greater.
