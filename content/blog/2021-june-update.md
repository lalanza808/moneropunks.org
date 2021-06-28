+++
title = "2021 June Update"
date = 2021-06-28 14:52:01
description = "First update since the launch of the Monero Punks workgroup"
author = "lza_menace"
+++

I made the decision to make this workgroup 6 days ago, bought the domain and created the forum 6 days ago, and posted about it on Reddit/Twitter 5 days ago.

In that 5 days, here's what we've got cooking from the Monero Punks crew:

# Light Wallets

We don't talk about these enough. This could unlock a whole new world of UX for Monero. I'm not talking about a full local wallet with a remote node, I mean a wallet that talks to a server to retrieve updates about it's history on the chain. Rather than waiting for your local wallet to sync up with the chain when you open the app (or run in the background as a service) the premise is that a backend server maintains the wallet sync status and your wallet client just fetches it when you open it. It's much more lightweight and avoids much of the syncing involved with local full wallet implementations (Cake Wallet, Monerujo, Feather, Monero GUI, Monero CLI).

The idea of a remote source being involved may cause concern for single point of failure, privacy, etc, but consider the possibility of a hybrid scenario in which your phone can do both; talk to a server for a periodic update, but also have the ability to switch to full node (no idea if this is possible with the cryptography, but spit-balling here). Also consider the fact that you could own and run your own backend server, no middle-men needed.

Sounds awesome, right?

Almost none of the wallets can do this natively as this capability is not in the current Monero codebase (`wallet2.cpp`) of which all the major wallets have used to transpile their mobile apps. There is one wallet that can do this which is [MyMonero](https://mymonero.com); that codebase has a bespoke implementation of the light wallet functionality. Unfortunately, the source code for the `mymonero.com` backend which does the syncing and interacting via REST API is not available, though there are alternatives.

Through trial and error we were able to get select versions of `MyMonero` working with an open source backend, [monero-lws](https://github.com/vtnerd/monero-lws). The author of this backend is a long-time Monero code contributor and C++ developer, `vtnerd`. They would like to merge this code into the official Monero project eventually.

In terms of this light wallet capability being utilized, it's just not ready enough for mass consumption yet, though power users will be able to set this up on their own with basic guidance. The `MyMonero` app has a lot of complexity which seems to manifest lots of bugs and inconsistencies between devices. A new wallet would feel better, but an existing one adding functionality would be nice, but it will take a while because the C++ Monero codebase would need this capability integrated into it; that is a whole other can of worms unfortunately.

The fastest path to a usable light wallet solution is trimming the burs on `MyMonero` and streamlining the package and distribution of `monero-lws`. Some additional code may be needed to better fit some integrations for `monero-lws`, but otherwise a light wallet solutions is mostly working.

If this is something the larger community may find useful we will need a joint collaboration between wallet developers, backend developers, C++ developers, and Monero cryptography subject matter experts.

> The Monero Punks workgroup will plan to document the setup of a light wallet for power users and work to develop more of a turnkey implementation. If prototypes show some success perhaps a broader push can be mode to update the `wallet2.cpp` codebase to accomodate native light wallet support.


# XMR Patronage

Not sure what to call this without saying "Patreon". A website for creators to share their content to a privacy conscious audience. We basically need to facilitate a way for people to maintain an account and upload/store text, photos, and videos but gated to only allow other registered users who have confirmed payments to view it. Patrons can support their favorite artists, journalists, bloggers, photographers, etc and pay completely anonymously.

On the outset this sounds like a fairly basic CRUD app that has a lot of bells and whistles. However, there are a lot of architecture decisions to make here which can have impacts on the system down the line. Regardless, I've begun working on a prototype which I'm calling [XMR Backers](https://github.com/lalanza808/xmrbackers). I'm still in the process of thinking through potential workflows and schemas for managing funds, subscriptions, and validating payments, restricting access, etc.

It is extremely rudimentary and essentially still a blueprint for a Python web service utilizing Quart (async Flask).
