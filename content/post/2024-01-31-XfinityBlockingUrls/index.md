---
title: Xfinity Blocking URLs For No Reason
description:  Xfinity blocks URLs on all customer devices for no reason when using Advacnded Secuirty (thats on my default)
slug: Xfinity Blocking-URLs-For-No-Reason
date: 2024-01-31
image: cover.jpg
categories:
    - ISP
tags:
    - Xfinity
weight: 1       # You can add weight to some posts to override the default sorting (date descending)
---
There have been a few instances in which Xfinity has blocked my company’s VPN URL. Xfinity needs a better process for unblocking that URL, but that is a different rant. You can not open tickets with them if you’re not an Xfinity customer. This makes no sense, and it’s infuriating. Xfinity will not tell us why or how the block was triggered. We were told on the 1st and 2nd time it happened it was “a known issue,” and it was resolved, but we’ve had other issues.

Suppose you find yourself googling and end up here. Here is what we did to fix this and what to look for.

It all started when some users couldn’t connect to the VPN. After some troubleshooting, we discovered that it was only affecting Xfinity users. Upon further investigation, we found that all Xfinity users had Xfinity advanced security enabled, blocking our VPN URL under the “blocked” tab. Even when a user removed the block, it would reappear in the block list after an hour. We had to request users to remove the block and disable Xfinity advanced security entirely to resolve the issue.

The next time we happened, Xfinity pushed an update that re-enabled Xfinity’s advanced security; however, users didn’t see our URL blocked. Xfinity told our users it was blocked. You’ll need to use this site https://spa.xfinity.com/advanced-security?faq=advanced-security to request the URL block is removed. It says 3-4 business days. It won’t matter how much you call, complain, or reps you talk to. The process is terrible, and Xfinity will not allow you to speak with an engineer. You’re stuck with tech support Tier 1 and 2 only. Who can only update the tickets on the SPA side.

Xfinity will not tell us why this happened, so we took measures and made backup plans.

    The Xfinity block blocked the entire TLD, not just the subdomain we found in some instances. We made a backup VPN URL under a different TLD to allow our users to connect. If we used a VPN.jasonkuehl.com, we made vpn.jasonkuehl.blah. This was a massive solution for us, allowing all blocked Xfinity users to connect.
    We made documentation to show users how to unblock our URL from the Xfinity app and how to turn off Xfinity’s advanced security.
    We request that users open tickets with Xfinity and provide them to us.
    I sent in a SPA request to unblock the URL.

If you found this frustrating and wanted to smash things, I did, too. The problem is this is 100% out of your control. If you were ever affected by Xfinity, create the backup VPN URL. It will allow all your users to connect and work.

Technical details.

If you try to hit the URL, you’ll see this. It makes you think that your SSL might be messed up or broken. But if you check on other ISPs, fine.

It works fine if you hit your VPN without the cert and do it directly to the IP. But using the URL will fail, not connect, and can’t hit the destination.
