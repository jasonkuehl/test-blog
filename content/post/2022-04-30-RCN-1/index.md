---
title: RCN Business Cable Internet Is Not Business Ready
description: RCN Business Cable Internet Is Not Business Ready
slug: RCN-Business-Cable-Internet-Is-Not-Business-Ready
date: 2022-04-30
image: cover.jpg
categories:
    - ISP
tags:
    - RCN
weight: 1       # You can add weight to some posts to override the default sorting (date descending)
---
Before we start:
My journey with RCN over the past 6 years as a residential customer was great. I only left them due to I’m moving into a new house, and they service the area. I also what to say I’m only talking about their Cable Business internet, not any other part of their business they offer as I’ve never used their Ethernet or Fiber in business before.

My friend I wanted business internet with enough public IP space we both could use. We both liked RCN as residential users and gave them a ring. For a 2-year contract, we got 500/60 for 90 dollars a month with a /28 for 14 external IPs. Not too bad of a price and service and uptime wise, RCN was fine for our needs. We had only 1 outage in that 2 years that was rain-related.

I run a larger Lab out of a Makerspace in Somerville MA which will soon be moving into my new house :). Here I test and do a lot of different things.

    Testing out new technologies I can get my hands on
    GNS3 Lab
    Full VMware and ProxMox Setup
    Anything Docker related
    CICD (Jenkins or bla)
    Remote Coding
    Test AD Environment
    Game ServersEtc, the list goes on

With that out of the way let’s start down the road of the most bizarre issues I’ve ever had with an ISP.

1. DHCP For Static IPS?
   From the start, we had odd issues, and it was always around our static IP Block. After an entire month of working with RCN on what was happening, we found out that RCN provides your Static IP block over DHCP. This blows my mind a little and I asked them why. They said it was to help customers who were not “tech” savvy. I asked them to disable it for our block and was told no as it was harder on the techs to debug an issue if we leave as a customer, and they reassign the block. If that new customer requests static IPS, and it’s not auto-assigned for them, it will create a ticket for them.

When I asked how are these static IPs when it’s in a DHCP scope I was told it’s static to the modem only. I will always have these IPs on our modem. Several calls to RCN later I never got them to disable this it was an actual nightmare to debug issues.

2. Don’t Plug In Any Network Device Setup to DHCP Mode

Our setup was as basic as it gets. One cable modem connected to an edge switch with a single VLAN. From here all edge devices would connect. The problem? Most network devices come with DHCP mode enabled on the outside interface meaning it would get a DHCP IP address. The head office will hand out the first IP in the list. If something was assigned to .2 “staticly” it will be overridden by the head office and that new device’s mac address (The one on DHCP) will be on file for that IP. You cant reboot the cable modem to fix this. You need to call RCN, get to a level 2 tech who can log into that piece of equipment to release the DHCP request. Then you can reboot the cable modem to get your original device working. I made this mistake once, and it took about 2 hours working with RCN to get resolved.

To be fair, this is how DHCP works. The DHCP Server will not know about staticly set IP addresses, but RCN will not do reservations. I tried for my entire block down to single IPs with no luck. Our workaround in case this ever happened again? We skipped the first IP in the block making it unable for an opps scenario. RCN tells you that you should be using DHCP and not staticly setting up IPS. However, that is also terrible. The head office only keeps the address logged for 2 hours (I was told). If you had an issue where your devices were offline for 3-4 hours on DHCP their records would no longer be at the head office. If you had 2 devices .2 and .3 on DHCP device1 had.2 and device 2 had.3 if device 2 booted faster it would then be .2 and device1 would be.3 See the example Below.

3. Device Failover Won’t Work

On top of how static IPS work within RCN, we found a new issue. On a device failover, the cable modem caches the mac address of the old device. What I can see in Wireshark is the cable modem still saying that the old mac address had that IP. It wont work without a reboot. I’ve done this same setup on Comcast business, Xfinity, and different Cell Carriers. The crazy part is, if I switch my firewalls to DHCP mode on the external interface it works fine. When I call RCN, they only say Active/Active or Active/passive is not supported on cable.

4. Customer Name Change

This was the most annoying part of all of this. I decided to move my lab into my new house and need to change the names on the account over to my friend. We got the name change forum and I asked if “Anything else is needed or to worry about” RCN said no that the account would move over to him as is. That was not the case. On the account change, we lost our static IP block. It took over 4 hours for RCN to fix the issue. According to RCN, I should have told them we had a static IP block. Because they treated it as a new account. After talking to a supervisor I was told “It’s the customer’s responsibly to let us know about their static ranges” Below you can see the only questions I was ever asked.

This was a rollercoaster of a ride and at the end of the day, I can’t recommend RCN to anyone for business. They have both process issues and will bring technical challenges to the customer if they expect things to work as it does with other carriers.
