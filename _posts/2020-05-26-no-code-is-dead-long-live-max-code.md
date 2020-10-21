---
layout: post
title: "No-Code is dead, long live Max-code"
image: /assets/oak-tree-field-chilterns.jpg
description: "No-code is a terrible
misunderstanding. The idea that Real Programming&trade; is hard, and that
non-programmers should be exposed to it through carefully procured
platforms and interfaces is almost as old as programming itself"
---

> A low-code development platform (LCDP) is software that provides a
> development environment used to create application software through
> graphical user interfaces and configuration instead of traditional
> hand-coded computer programming. A low-code model enables developers
> of varied experience levels to create applications using a visual
> user interface in combination with model-driven logic
> -- [Wikipedia](https://en.wikipedia.org/wiki/Low-code_development_platform)

The idea that Real Programming&trade; is hard, and that
non-programmers should be exposed to it through carefully procured
platforms and interfaces is almost as old as programming itself. COBOL, the
great-grandmother of modern programming languages was conceived as
such a system, the name short for 'Common Business-Oriented
Language'. While undoubtedly preferable over the alternative at the
time, it did not quite manage to pry programming from the hands of the
programmers.

In the age of the mouse and the graphical user interface, the idea
took a new shape that it still broadly embodies: Dragging boxes
around. I particularly recall the software that came with [LEGO
Mindstorms](https://en.wikipedia.org/wiki/Lego_Mindstorms), a
programmable controller for LEGO that enabled quite advanced
robotics projects. Of course, kids can't be trusted to operate
keyboards, so the programming interface was a canvas where the user
would drag and drop big, colourful blocks and snap them into each
other. The total irony of the situation was that the blocks were
literally `if` and `for` and you had to plug conditions and actions
into them. Of course, on the monitors of the late '90s, you would run
out of space pretty quickly as well, so anything more complicated than
a switch turning something on and off would overflow the screen, and
you'd have to scroll around, wreaking havoc to any notion of
overview. Luckily, and to LEGOs credit, they allowed multiple
programming environments, so I spend most of my time with Mindstorms
in Visual Studio.

Around the same time, XML entered the stage and was immediately
seized on by the no-code-crowd (who, of course, were not called that
yet). Especially in enterprise Java land (from which I hail),
everything was "configurable" in XML --
[Spring](https://docs.spring.io/spring/docs/4.2.x/spring-framework-reference/html/xsd-configuration.html)
was the biggest elephant in that particular china-shop. A Spring XML
configuration file would have you define _beans_ which are instances
of classes, complete with passing arguments to the constructor in the
form of other beans. This is infinitely flexible, and in theory sounds
pretty good: You can write a program that interacts with eg. a
database, and when running it, your Spring XML would simply
instantiate the particular driver appropriate for your database as a
bean. Now the program can run anywhere without being modified, and
without anticipating all the types of databases it might connect to --
_without any programming required_.

Two things happened: (1) No non-engineer ever edited a Spring XML file
-- the examples in the link above should make clear the reason for
this: They are completely incomprehensible to anyone who doesn't
understand exactly what's going on. (2) Programmers and architects
totally went to town on this, and configuration files in the thousands
of lines were completely normal. Breaking them was easy, and not being
code, they're lacking many of the features that would help us find out
where a problem is, such as stack traces and debuggers, and the tools
we would use to avoid the problem in the first place,
like source control and testing. In XML's defence, it must be said
that this was never the intended role for XML.

A pattern begins to emerge: These tools may remove _code_, but they
don't remove complexity. Rather, in their attempt to make something
fundamentally complex non-complex, they end up adding significant
amounts of additional complexity instead. The dynamic is similar to
Turing's insight on computability: Although Spring XML isn't
Turing-complete, at least not on its own, it is endlessly flexible in
a way that enables you to build incredibly diverse, essentially
unbounded, structures. Once you realise this, you can also begin to
treat your no-code code as code, put it in SCM and write tests around
it. But this, of course, robs no-code of it's very essence. In the case
of Spring, it is telling that XML configuration files are no longer
the default -- actual code is, and the result is often much, much
cleaner, easier to work with and easier to test.

No-code efforts can be understood in two very distinct categories:
Those that understand their inherent complexity and those that
don't. If the complexity is low enough, it can be reduced to simple,
[declarative](https://en.wikipedia.org/wiki/Declarative_programming)
configuration. Website creators like Wix are in this category --
you can build a website using a well-built palette of the kinds of
components users expect websites are made up off. But there are things
you can't do, and there is no way to work around it in a clever
configuration editor. If you _can_, it involves building a plugin
using real programming, and there are no apologies made for that.

In the other category, we find the fundamentally patronising idea that
your users can handle infinite, Turing-complete complexity, but is
unable to express this complexity
[imperatively](https://en.wikipedia.org/wiki/Imperative_programming) in text
and must have their hands tied by point-and-click interfaces and
"configuration". Some of them indeed can't do this, but that won't
keep them from trying, and sometimes succeeding, which is terrifying.

![Oak tree in field](/assets/oak-tree-field-chilterns.jpg)

I don't believe that the patronisation is necessary: While developers
and product managers fretted over how code would scare people, a
plausible candidate for the most widely used programming language in
the world evolved, hiding in plain sight: Excel. Millions of business
users who had no idea they couldn't code built software edifices of
awe-inspiring complexity. In the same vein, complex SQL thousands of
lines long are routinely written and edited by business analysts who are
similarly certain that they can't code.

Of course, neither Excel or SQL is a particularly nice language, and
leaving them for only the types of tasks they are designed for should
be strongly encouraged.

Which brings me to the conclusion: No-code is a terrible
misunderstanding. Instead, the genuine low-code movement should join
what we might call the max-code movement: modern high-level
programming languages. Python, Ruby, possibly Kotlin (I'm certain
there are other worthy candidates for this list), combined with
modern, wholesome software development practices, such as SCM, testing
and CI. And of course packages and modules: Let the more technically
confident users build components for other users to incorporate. The
success of coding boot camps suggests this is an eminently viable path.

Instead of hiding from the complex reality, we must embrace it and
unlock the amazing power of computing for all.

&nbsp;

<a href="https://twitter.com/mseebach?ref_src=twsrc%5Etfw" class="twitter-follow-button" data-size="large" data-dnt="true" data-show-count="false">Follow @mseebach</a>
