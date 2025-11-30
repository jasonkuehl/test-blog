---
title: How I Found An S3 Vulnerability
description: How I Found An S3 Vulnerability
slug: How-I-Found-An-S3-Vulnerability
date: 2020-10-13
image: cover.jpg
categories:
    - AWS
tags:
    - S3
weight: 1       # You can add weight to some posts to override the default sorting (date descending)
---
It all started back in 2018 with the below email:

I selected the link within the email it brought me to the following URL.

Notice it’s a straight S3 link to a public S3 URL, with PII in it. (Take my word on that) :). So I sent this email:

To which they responded:

Now, remember, this is 2018: right at the height of the S3 bucket madness. You couldn’t go a single month without seeing a new S3 Leak in the headlines. To name a few examples.

* Booz Allen Hamilton The U.S. defense contractor
* U.S. Voter Records A Republican-party backed big data firm
* Dow Jones & Co Personally identifiable information for 2.2 million people
* WWE Personally identifiable information about over 3 million wrestling fans
* Verizon Wireless Personally identifiable information about 6 million people
* Time Warner Cable Personally identifiable information about 4 million customers
* Pentagon Exposures Terabytes of information from spying archive, resume for intelligence positions–including security clearance and operations history, credentials and metadata from an intra-agency
* intelligence sharing platform.
* National Credit Federation  111GB of detailed financial information

Luckily, the Org I’m talking about here knew about the issues and was trying to fix it! Great! I sent this follow up:

The job was done, right? End of post? You’d be incorrect. Fast-forward to 2020. COVID-19 hit, and I needed to reactivate my membership to get access to this software again.

Once again, I got an invoice but this time there is no special link, like the one above. The link is just s3.amazonaws.com/JKLOL/HASH/INVOICE.PDF

I remembered that I emailed them about this earlier and was able to find that same email. I also found out later that the ticket I opened in 2018 was never closed. I start to fire off emails:

Their response:

In my next email I gave them some more details on the issue the same in 2018:

To which they responded:

Amazon.com: Challenge Accepted MEME Vinyl Decal Sticker- 12" Wide ...

“Working As Designed” by leaving PII data in a public S3 path. I didn’t buy what they were selling. I took him up on their offer of providing links/evidence.

As I started digging, I began where anyone would. Could I get to the data from the root of the URL? The answer was yes. When I went to the roof of the bucket name, I almost filled my pants when I saw a full XML list of hashes and links to files.

(Part of the email I sent with my evidence)

It was FILLED with PII. I started digging even more:

Credit card and checking data. Not full numbers or accounts (thank Tux). But now I’m really starting to wonder if there is any more data in here?

I decided that instead of building a fancy script that would parse the XML and look pretty, I would make it as nasty as possible to pull all the data in the bucket. This was more or less to prove a point that you don’t need a nice script to get access to critical data. With a combination of wget, cat, cut, awk, and sed I was able to do this.

I got a complete list of all objects in the open folder. From here I used pdftotext to mass convert all PDF’s into text.  I then did searches for all my contact information and found nothing (which made me extremely happy). Then I deleted the rest of the data. However, I did find things like this telling me this company does a lot of other processing for other companies.

I took at this data, everything I learned and sent it off to my vendor. This is what I got back 🙂

With that, I wait. Working in the same field I do know that these things take time to fix.

However, what is the fix? Well, if you don’t use IAC (Infra As Code) it’s 3 clicks to turn off listing objects (Instructions) and just uncheck that button.

If applying a policy is more your style here is the basics for a public bucket.
This will allow for only a get on objects and you need the entire path.

```
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "PublicReadGetObject",
            "Effect": "Allow",
            "Principal": "",
            "Action": [
                "s3:GetObject"
            ],
            "Resource": [
                "arn:aws:s3:::canihavepumpkinspiceyet/"
            ]
        }
    ]
}
```

With the entire path being required you can hash the locations to your objects like the vendors in the real world example did do. But they made one fatal mistake by leaving that option enabled and thus exposed PII to the internet.

I waited one week before asking if they clicked that button.

Well. I can see I’m going to have to look at other options and disclose to others I trusted with what I had found. I talked to a few friends of mine in the security world to get some advice. They suggested the following:

1. Look over the entire site for any kind of company contact or email address.
2. Start looking at LinkedIn and see what you can find about who works at the company to contact them directly

After some googling, I found a 3rd option: trying the “basic” email address. Abuse@, Security@, admin@, webmaster@, postmaster@, and privacy@.

I did just that. The company had zero contact information on their site which I didn’t really expect. I turned my sights to LinkedIn! From what I learned, this a vendor of the company from whom I’m getting this product. I started looking deeper and I saw that they have a very active security department. I began to mass spam and I got a response! He was able to get me the email of a person that I can send the issue over to, including all the other emails and proof I came up with.  Here is my interaction with them:

I went to town!

Within 2 hours I got this message back from someone else, not a support person (Better…..) and they stated that there will be an update “soon”. Around 6pm I hear the vendor will be deploying a fix by Friday.

Oh, the engineers must love me by now. But apparently, cage-rattling seems to have worked.

So I waited, and I was happy to find it was ultimately fixed.

The moral of the story is if you see a major problem don’t give up until that problem is fixed!

I will be writing another post about what I learned and what you need to know if you find something like this or any type of security issue. {link post here}
