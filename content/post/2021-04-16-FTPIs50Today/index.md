---
title: FTP Is 50 Today
description: FTP Is 50 Today
slug: FTP-Is-50-Today
date: 2021-04-16
image: cover.jpg
categories:
    - obsolete
tags:
    - FTP
weight: 1       # You can add weight to some posts to override the default sorting (date descending)
---
April 16th, 1971 RFC959 (you may know it as FTP) was born, making it 50 years old today. Even though it is that old and there are serious security concerns, there are still numerous FTP servers running. For example (Pulled from Shodan):

    United States 736,721
    Japan 285,691
    China 284,550
    Germany 280,699
    Russian Federation 151,815

Let’s look just into the United States numbers on top products:

    Microsoft ftpd 496,113
    Pure-FTPd 122,447
    Serv-U ftpd 34,093
    Multicraft ftpd 32,531
    D-Link DLS-2750U13,543

## FTP Lacks Security


FTP is inherently a non-secure way to transfer data. When a file is sent using this protocol the data, username, and password are all shared in plain text, which means a hacker can access this information with little to no effort.

Most of the FTP services I looked at didn’t allow anonymous login but did have usernames and passwords attached. Which you think would be a good security protocol. However, all these servers (since they’re running Microsoft ftpd) could be exploited by CVE-2009-3023.  There are 2 known public bash-like exploits that anyone can run just off GitHub, and the 3rd is a very easy-to-use Metasploit module:

```
‘show options’ or ‘show advanced’:  
msf > use exploit/multi/ftp/pureftpd_bash_env_exec msf  
exploit(pureftpd_bash_env_exec) > show targets …targets… msf  
exploit(pureftpd_bash_env_exec) > set TARGET < target-id > msf  
exploit(pureftpd_bash_env_exec) > show options …show and set  
options… msf exploit(pureftpd_bash_env_exec) > exploit

```

## Data.

Plus the data is transmitted unencrypted. Need I say more…

## Nat.

A dynamic, secondary port, is needed for the data channels, which makes firewall and port forwarding more complex and beyond the abilities of most home network administrators. This is required to achieve the fantastic transfer speeds that many FTP proponents crow about.

## Conclusion.

Today, FTP should only be used on extreme legacy systems and for public access anonymous FTP. Even for anonymous public access, HTTPS and web servers have largely replaced FTP. Since FTP is unencrypted, man-in-the-middle attacks can and have been used to inject malware into software downloaded using FTP.

Yet, there are so many still online. Basic things you buy today come with FTP enabled (like printers).

If you really need external file transfer, you should already be used SFTP at the very least or HTTPS for public files.

Lord stop using FTP already. #StopUsingFTP
