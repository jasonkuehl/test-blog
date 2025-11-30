---
title: Dell N Series – No Free IP Address To Offer In Pool
description: Dell N Series – No Free IP Address To Offer In Pool
slug: Dell-N-Series-1
date: 2022-03-06 00:00:00+0000
image: cover.jpg
categories:
    - Networking
tags:
    - Dell-N-Series
weight: 1       # You can add weight to some posts to override the default sorting (date descending)
---
Dell N Series – No Free IP Address To Offer In Pool
Blog Networking
October 13, 2020 jasonkuehl

At this site we installed a new Dell N Series core replacing a bunch of old junk. As I’m doing the new build I moved all the DHCP requests to the core and away from windows which took care of all the DHCP requests. This was on a off day with no one around (Duh replacing the core) and I was not really worried. After about 30 minutes my console is filling up with the below messages.

Note: Yes it’s VLAN1 it predates me and is waaay too messy to remove in a weekend.

`Error “No Free IP Address To Offer in pool VLAN1”`

*Start freaking out* Did I fill the pool already? How can that be?

```
show ip dhcp binding
```

Everything looks fine, and the pool is not even close to full… To the Logs!

```
show logs
```

I’ve seen this before in Cisco where a device holds onto a DHCP address. You need to track down the MAC and give the device a reboot. After the reboot (of the device) these errors should go away.

Full Image
