---
layout: post
title: JAXB isn't half bad
---

This week I had to implement a small Java program that would provide a
UI to manipulate an XML file. My heart sank a bit at the promise of a
trip to the Java/XML enterprise heartland.

My original plan was to just implement a minimal, viable subset of the
XML as a proof of concept -- and since this is, it self, for a proof
of concept, I might well have gotten away with it. But still, anything
that worth doing is worth doing well, so I did some research (which is
a nice way of saying that I dithered for a while, trying to make up my
mind) and happened to notice that
[JAXB](https://jaxb.java.net/tutorial/section_1_3-Hello-World.html)
was already on the classpath of the project. 

JAXB -- Java Architecture for XML Binding -- works by taking a XSD
schema and generating bindings for it. I recalled the similar approach
used in JAX-WS and cringed, but resolved to give it a shot. I have
some previous experience building XSDs and find it a reasonably sane
and helpful exercise: it forces you to consider your XML format
separately. It has some counter-intuitive constraints (an element
can't contain a mix of element types and children in any order, they
must come in a certain order) but nothing too outrageous.

Having build the XSD, I fed it to the 'xjc' command line util,
helpfully included in the JDK, and got a nicely generated set of
classes with binding to my XML format. The link above is to a "Hello
World" sample, and I don't think I can improve much on that -- thus,
no sample code in this post.

It worked almost as expected --
after battling a bit with the interface to the JAXB unmarshaller, I
discovered that about half the problems I was facing was due to my XSD
not defining a root element. This has the effect of declaring a
universe in which the element can exist, not telling JAXB explicitly
to expect a certain element in my XML file. 

With that fixed, I had a nice and clean typesafe interface to my XML
format that turned out to work exactly as expected. Dynamic languages
have a lot going for them in this domain, but I really like that I
have autocompletion directly into my XML format and if I change the
format, I can re-generate the bindings and get a nice list of compiler
errors to work from.