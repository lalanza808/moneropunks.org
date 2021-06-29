+++
title = "2021 June Update"
date = 2021-06-29 14:52:01
description = "First update since the launch of the Monero Punks workgroup"
author = "lza_menace"
+++

The date of this posting is June 29th, 2021. I made the decision to make this workgroup 8 days ago, bought the domain and created the forum 8 days ago, and posted about it on Reddit/Twitter 7 days ago.

In that 7 days, there's been a small wave of initial support and contributors engaging in discussions in both IRC and the Forum; here's what we've got cooking from the Monero Punks crew:

# Ideas and Initiatives

## Light Wallets

_[Forum Discussion](https://forum.moneropunks.org/topic/8/light-wallets/)_

We don't talk about these enough. This could unlock a whole new world of UX for Monero. I'm not talking about a full local wallet with a remote node, I mean a wallet that talks to a server to retrieve updates about it's history on the chain. Rather than waiting for your local wallet to sync up with the chain when you open the app (or run in the background as a service) the premise is that a backend server maintains the wallet sync status and your wallet client just fetches it when you open it. It's much more lightweight and avoids much of the syncing involved with local full wallet implementations (Cake Wallet, Monerujo, Feather, Monero GUI, Monero CLI).

> The idea of a remote source being involved may cause concern for single point of failure, privacy, etc, but consider the possibility of a hybrid scenario in which your phone can do both; talk to a server for a periodic update, but also have the ability to switch to full node (no idea if this is possible with the current codebase, but spit-balling here). Also consider the fact that you could own and run your own backend server, no middle-men needed.

Sounds awesome, right?

Almost none of the wallets can do this natively as this capability is not in the current Monero codebase (`wallet2.cpp`) of which all the major wallets have used to transpile their mobile apps. There is one wallet that can do this which is [MyMonero](https://mymonero.com); that codebase has a bespoke implementation of the light wallet functionality. Unfortunately, the source code for the `mymonero.com` backend which does the syncing and interacting via REST API is not available, though there are alternatives.

Through trial and error we were able to get select versions of `MyMonero` working with an open source backend, [monero-lws](https://github.com/vtnerd/monero-lws). The author of this backend is a long-time Monero code contributor and C++ developer, `vtnerd`. They would like to merge this code into the official Monero project eventually.

In terms of this light wallet capability being utilized, it's just not ready enough for mass consumption yet, though power users will be able to set this up on their own with basic guidance. The `MyMonero` app has a lot of complexity which seems to manifest lots of bugs and inconsistencies between devices. A new wallet would feel better, but an existing one adding functionality would be nice, but it will take a while because the C++ Monero codebase would need this capability integrated into it; that is a whole other can of worms unfortunately.

The fastest path to a usable light wallet solution is trimming the burs on `MyMonero` and streamlining the package and distribution of `monero-lws`. Some additional code may be needed to better fit some integrations for `monero-lws`, but otherwise a light wallet solutions is mostly working.

> The Monero Punks workgroup will plan to document the setup of a light wallet for power users and work to develop more of a turnkey implementation. If prototypes show some success perhaps a broader push can be made to update the `wallet2.cpp` codebase to accomodate native light wallet support.

If this is something the larger community may find useful we will need a joint collaboration between wallet developers, backend developers, C++ developers, Monero cryptography subject matter experts, and generous funding from the community at large.


## Monero Patronage

_[Forum Discussion](https://forum.moneropunks.org/topic/5/patreon-clone/)_

Not sure what to call this without saying "Patreon". A website for creators to share their content to a privacy conscious audience. We basically need to facilitate a way for people to maintain an account and upload/store text, photos, and videos but gated to only allow other registered users who have confirmed payments to view it. Patrons can support their favorite artists, journalists, bloggers, photographers, etc and pay completely anonymously. On the outset this sounds like a fairly basic CRUD app that has a lot of bells and whistles. However, there are a lot of architecture decisions to make here which can have impacts on the system down the line.

> I've begun working on a prototype of this "Patreon clone" as it's being called, which I'm calling [XMR Backers](https://github.com/lalanza808/xmrbackers). I'm still in the process of thinking through potential workflows and schemas for managing funds, subscriptions, and validating payments, restricting access, etc.

It is extremely rudimentary and essentially still a blueprint for a Python web service utilizing Quart (async Flask). You'll have to stay tuned for updates by starring and watching the Git repo.

Regardless of what the implementation looks like, I think it needs to support various hosting options and ideally support non-custodial wallets as a default (if possible). While I would plan to register a domain and deploy this site, it's important that this can be self-hosted yet still support patrons and not become a centralized platform where everyone is sharing content; federation is nice, but not in scope right now. It would be need to be simple enough and turnkey to support DIY'ers to host on their own servers. I'd like to see an IPFS implementation with the ability for creators to host their own IPFS servers for redundant storage of content (optionally paying for services to maintain additional copies).

Would be interested in seeing other community implementations as well, let's all get developing.

## XMR Sweeper

_[Forum Discussion](https://forum.moneropunks.org/topic/14/xmr-sweeper/)_

The forum discussion very nicely packages the benefit of this tool, but the main takeaway here is that programmable wallets are a possibility today. Here is a nice summary:

`XMR Sweeper: An idea for a software program you could run on your home computer, paste in your private keys and receive details, then go about your business, all the while your funds are getting trickled out into various wallets you control. If you're on the go, your hot wallet is able to spend new funds, while cold storage nets some more picos.`

Power users are certainly able to script the process of restoring wallets and making transfers, but the capabilities are not easy for laymen/basic users to do so as well. A simple utility to do some amount of chain scanning/wallet syncing and transferring with some criteria/configuration around it sounds feasible enough to implement a solution for and provide easy onboarding for novices.

> Ideally we can distribute clickable binaries for OS flavors with native desktop UI and forms/clickable/changeable settings and the software can orchestrate wallet processes in the background. However, I think some prototypes should be done for more reference implementations, trial/error iterations, allows more power users to leverage tools that help them. I may begin working on a prototype for this, but depends on my schedule. I want the patronage service to take preference for now.

I currently have partial functionality on this with a Python (Flask) and Docker/docker-py web service. It utilizes a simple RESTful backend API to interact with the Docker service and pass context to new containers (running `monero-wallet-cli` and `monero-wallet-rpc`). Right now it's got a seed restoral web form, background wallet orchestration and scanning, and displaying balances/transfers in each restored wallet. With some additional logic, settings, and transfer functions this prototype could become a reality for power users.

Would love to see any community implementations of this for more samples.

## Gifting Monero

_[Forum Discussion](https://forum.moneropunks.org/topic/13/gifting-xmr-to-others)_

This idea came up in IRC and was pointed out as a common thing seen on other projects such as [Masari Giftcards](https://gc.masari.rocks) and [Lightning Gifts (Bitcoin)](https://lightning.gifts/). This could be a useful way to onboard new users somewhat quickly and easily. The easiest path to implementation would be a custodial solution, so a self-hosted option would be preferred, but I do think a custodial platform is feasible if users were aware of the risks.

In short, this idea is about how could we build a web service that we can generate and dispatch a unique URL and the recipient can follow instructions to install a wallet and provide the service with a wallet address. It might make it very easy to onboard friends and family without explaining all the specifics.

The Masari implementation might be able to be forked and tweaked for Monero specifically, but I'm not sure of the internals of the codebase and if it's worth maintaining that system; I haven't used it and don't have an opinion.

For you builders out there, here's another opportunity to build a solution of your own.


# Beyond

Obviously the things being laid out here are abstract. Some of these topics are really just ideas with no working or usable products, while some are diamonds in the rough with software projects that need to be packaged and polished up. Regardless, they are things which maybe the broader Monero community doesn't have insight into or understanding of, and in having these technical discussions and implementations we can garner support if some community crowdfunding (like [Monero CCS](https://ccs.getmonero.org/)) could support to get more talent working on Monero. Maybe people didn't know light wallet functionality was a feasible thing and it might address many UX problems with chain scanning which are common amongst new users who are unfamiliar opaque blockchains.

A lot of the current funding activity goes to the Monero C++ codebase (the contributors to it at least), which is extremely important, but I believe these initiatives have enough utility behind them to showcase more powerful features we can have with Monero; consider them L2 solutions building on the very strong Monero L1.

We're simultaneously uncovering hidden gem projects in Monero's ecosystem, polishing them for mass consumption (easy to use), while pushing new ideas, iterations, and improvements of the system. This small list is just a start. As we get more volunteers and leaders arising this will (hopefully) all begin to shape and take place. We essentially need code writers/programmers now to build things with these ideas in mind and collaborate so there's visibility on their work.

All of these ideas have potential to be monetized; entrepreneurs should hopefully see paths forward for building services around these tools and a potential to blaze trails here, even if just to build community perception and confidence.
