---
title: Google Geo Location Issues
description: How google picks locations for where an IP is, and not using ARIN.
slug: google-geo-location-issues
date: 2022-03-06 00:00:00+0000
image: cover.jpg
categories:
    - Google
    - Networking
tags:
    - GeoLocations
weight: 1       # You can add weight to some posts to override the default sorting (date descending)
---
Google runs its database like ARIN on who owns what IP and sets a location. If you look up an IP owner in ARIN, you’ll see the name, address, and IP location. Google does this as well, but it’s private.

This becomes important when your Google page suddenly shows Belarus. You need to contact Google or ARIN. You’ll know it’s a Google issue if you don’t see this issue in Bing or DuckDuckGo.

If you’re reading this, your Google location now shows a different country or area from your owned IP location in ARIN. Google has changed this in their database. The process to fix this will take 1–2 months. You need to open a ticket with noc@google.com

If you’re an ISP, you can use https://isp.google.com/. Anyone who runs a VPN for a company website or other service must open a ticket with the NOC. If you can get an ISP account, you can control IP address locations.

I got this information from the nanog@nanog.org mailing list. I contacted a Google Ops Engineer on this list, who told me to use noc@google.com for all Google-related issues. They were able to send my issue over to the correct department. For all my funky-related network issues, I posted them to this list to get help from other engineers.

See the below response from Google.

At the end of the day, a bug in the service saw traffic from Belarus, and Google started to assume this was the main location where that IP belonged. After talking with other engineers from other companies, this is “normal” when you start to branch out in hiring from other countries. However, it would never be an issue if Google just used the ARIN database like everyone else.
