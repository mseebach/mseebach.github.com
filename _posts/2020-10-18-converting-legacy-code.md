---
layout: post
title: "Converting legacy code"
image: /assets/vysoke_tatra_mountain_lake.jpg
description: How to convert millions of lines of code to a modern software project
---

A question [Sabine Hossenfelder](https://twitter.com/skdh) asked on
Twitter prompted this essay:

> If you had a ten million lines, decades-in-the-making fortran code,
> how'd you convert it to a modern language, how long would it take, and
> how much would it cost?
> [↪](https://twitter.com/skdh/status/1316570664103563265)

There are no short or easy answers to this question. Inevitably, it
depends on a lot of factors:

We need a perfectly clear understanding of what the program is, what
it’s used for, and by whom.

We need to know what we’re trying to achieve by changing it. If this
is not a clear and significant benefit, and not clearly articulated
and shared by the project team and sponsors, the project will flounder
and ultimately fail.

We need to know if the program still works after we’ve changed it.
This sounds basic, but is a surprisingly complex topic, especially for
large, old systems.

And finally we need to understand the organisational politics that
will govern our project.

Let’s try to unpack some of these questions.

### Domain
What is this thing even? 10 millions lines of code is a lot.

Some systems are figuratively speaking responsible for everything from
the moon landing to the cafeteria menu, an “everything but the kitchen
sink” system. This is especially common in older systems, conceived at
a time when the overhead of building and integrating new systems made
just adding an extra feature to an existing system a very tantalising
proposition, even when (modern) software architecture principles
suggest it should be separate.

> Some systems are figuratively speaking responsible for everything from
> the moon landing to the cafeteria menu, an “everything but the kitchen
> sink” system
> &nbsp;&nbsp;&nbsp; <a href="https://twitter.com/share?ref_src=twsrc%5Etfw" class="twitter-share-button" data-text="&ldquo;Some systems are figuratively speaking responsible for everything from the moon landing to the cafeteria menu, an “everything but the kitchen sink” system&rdquo;&#010;&#010;" data-via="mseebach" data-dnt="true" data-show-count="false">Tweet</a>

These systems are comparatively easy to reengineer, as we can often
peel off these features in an iterative manner. Indeed, this will
often have happened: We may find that the cafeteria menu module was
last used in 2002 when that particular usage was migrated to another,
new system.

At the other end of this scale, we find the single, contained model,
responsible for converting a tightly bounded set of inputs into a
similarly tightly bounded set of outputs. It is easier to reason about
a system like this, but the stakes are higher: This system likely
exists because what it does is very important to someone powerful.

### Conversion? Or The Big 2.0 Rewrite
Why is it important to convert this program? Fortran works fine, so
why not keep it in Fortran? Presumably, there are changes that need to
be made, and it’s easier to find programmers in more modern languages.
However, the hardest part of programming isn’t the language, it’s what
we’re trying to do with it. Next to the challenge of understanding
what those millions of lines are doing, learning Fortran will be a
rounding error.

> The hardest part of programming isn’t the language, it’s what we’re
> trying to do with it. Next to the challenge of understanding what
> those millions of lines are doing, learning Fortran will be a rounding
> error
> &nbsp;&nbsp;&nbsp; <a href="https://twitter.com/share?ref_src=twsrc%5Etfw" class="twitter-share-button" data-text="&ldquo;The hardest part of programming isn’t the language, it’s what we’re trying to do with it. Next to the challenge of understanding what those millions of lines are doing, learning Fortran will be a rounding error&rdquo;&#010;&#010;" data-via="mseebach" data-dnt="true" data-show-count="false">Tweet</a>

One could imagine that one of the reasons it’s difficult to make
changes to the existing codebase is that it’s poorly structured.
Getting the structure just right is difficult for the best
programmers, and especially under the pressure of deadlines and other
constraints, shortcuts are often taken. These shortcuts are known as
tech debt, which optimistically suggests the intention to pay it down
in the future. In reality, this is often neglected. These decisions
compound over the years, and in our case, the problem is quite likely
to be exacerbated by the code being written by people who are academic
domain specialists, not expert software engineers. Computers have a
nasty habit of not caring how well engineered software is, only
whether it runs, so “works” trumps “good”.

> These shortcuts are known as tech debt, which optimistically suggests
> the intention to pay it down in the future. In reality, this is often
> neglected
> &nbsp;&nbsp;&nbsp; <a href="https://twitter.com/share?ref_src=twsrc%5Etfw" class="twitter-share-button" data-text="&ldquo;These shortcuts are known as tech debt, which optimistically suggests the intention to pay it down in the future. In reality, this is often neglected&rdquo;&#010;&#010;" data-via="mseebach" data-dnt="true" data-show-count="false">Tweet</a>

This mess, much more than the language, is why making changes to the
codebase is so difficult. But untangling it will complicate any
rewriting effort to an even larger degree.

### Things you should never do
I would be remiss if I didn’t take the opportunity to link one of the
seminal software engineering blogs here: [Joel on Software: Things You
Should Never
Do](https://www.joelonsoftware.com/2000/04/06/things-you-should-never-do-part-i/).
Spoiler alert: Exactly this.

What we can do, however, is to progressively develop the program in a
certain direction that allows us to achieve some of the same outcomes.
A favourite text on this process is [Growing Object-Oriented Software,
Guided by
Tests](https://www.amazon.co.uk/Growing-Object-Oriented-Software-Guided-Signature/dp/0321503627/).
Your Fortran program probably isn’t object oriented, but many of the
principles still apply. The idea is to identify and carve out
independent pieces of code, iteratively change and improve the code,
continuously adding smaller and smaller tests as we work through it.
This requires a “ground truth”, which we will return to.

The reason we want to do this, as opposed to starting from a blank
slate, is to enjoy the disciplining constraint of running our code
against a realistic workload (ideally production, depending on the
exact situation) as soon as possible after writing it. Plenty of
issues big and small don’t become apparent until this happens, so
modern software engineering preaches this practice with rather some
zealotry.

### Ground truth: What does good look like?
In order to test, we need to know what correct looks like across a
wide range of inputs. Assuming the code isn’t well documented and
tested, the fall back plan is to have a substantial corpus of inputs
which we can run through the existing program to provide expected
results for an end-to-end test suite.

For each segment of the program we want to work on, we run the suite,
recording what goes into the segment and what comes out: This is now
our test suite for the segment, and we can set to work on it in
isolation.

However, this only works if we can be sure the test suite is fully
representative across the full input domain. Depending on the program,
this can be a very difficult exercise. It seems likely that a very
large part of this code was written to deal with various
idiosyncrasies in the input data -- of these, few will be easy to
understand: They will have unstated assumptions, and if we don’t have
input data exhibiting these idiosyncrasies, there are some deep rabbit
holes to crawl down here, trying to understand what’s going on, or if
its even needed anymore.  Remember, if we just blindly copy the
existing logic, we will just be carrying over the complexity, not
achieving the (presumed) goal of the project.

> A very large part of this code was written to deal with various
> idiosyncrasies in the input data -- of these, few will be easy to
> understand: They will have unstated assumptions, there are some deep
> rabbit holes to crawl down here
> &nbsp;&nbsp;&nbsp; <a href="https://twitter.com/share?ref_src=twsrc%5Etfw" class="twitter-share-button" data-text="&ldquo;A very large part of this code was written to deal with various idiosyncrasies in the input data -- of these, few will be easy to understand: They will have unstated assumptions, there are some deep rabbit holes to crawl down here&rdquo;&#010;&#010;" data-via="mseebach" data-dnt="true" data-show-count="false">Tweet</a>

### The Vetocracy
Last, but in many ways the most important issue: Assuming we get all
our technical ducks in a row, who will we need to convince to actually
undertake the project? One of the biggest and most underrated
challenges of large software projects in non-software organisations is
to get all the stakeholders aligned . For more sprawling systems, it
can be difficult to even identify these, much less convince them of
the value of the project.

> Assuming we get all our technical ducks in a row, who will we need to
> convince? One of the most underrated challenges of large software
> projects is to get all the stakeholders aligned
> &nbsp;&nbsp;&nbsp; <a href="https://twitter.com/share?ref_src=twsrc%5Etfw" class="twitter-share-button" data-text="&ldquo;Assuming we get all our technical ducks in a row, who will we need to convince? One of the most underrated challenges of large software projects is to get all the stakeholders aligned&rdquo;&#010;&#010;" data-via="mseebach" data-dnt="true" data-show-count="false">Tweet</a>

It’s easy enough to argue the benefits of a reengineered system, it’s
even comparatively easy to secure a budget for the project. What’s
almost impossible is to get through the vetocracy.

Our rewritten program almost certainly won’t produce the exact same
results, especially if it deals with numerical computation. There will
be minor variations on how floating point numbers are rounded or
truncated and how certain data types are represented. The idiomatic
way to do some things in the target language will be slightly
different from the Fortran way, with results being slightly off in
some decimal, or presented in a slightly different way. How many
people will we need to convince that this is actually OK?

Inevitably, we will find errors in the Fortran code and want to fix
them. Someone somewhere more powerful than us got their current job on
the basis of a report that (may have) included an incorrect figure due
to the error we found. They will be obliged to go back and report
this, but not before they sucked all the oxygen out of our team for
three months exhausting all possible theoretical reasons that the
error we found is not, in fact, an error.

That cafeteria menu subsystem? Because it hasn’t been used for 20
years, nobody knows who owns it. Signing off on its removal is a risk,
punting on the decision isn’t, so expect this decision to get punted.

And this is all before the lawyers get involved.

One of the reasons so many of the large and important organisations
running big, old systems don’t set out to do something like this, or
fail miserably if they try, is that they underestimate this dynamic.

> One of the reasons so many of the large and important organisations
> running big, old systems don’t set out to do something like this, or
> fail miserably if they try, is that they underestimate this dynamic
> &nbsp;&nbsp;&nbsp; <a href="https://twitter.com/share?ref_src=twsrc%5Etfw" class="twitter-share-button" data-text="&ldquo;One of the reasons so many of the large and important organisations running big, old systems don’t set out to do something like this, or fail miserably if they try, is that they underestimate this dynamic&rdquo;&#010;&#010;" data-via="mseebach" data-dnt="true" data-show-count="false">Tweet</a>

![Mountain lake](/assets/vysoke_tatra_mountain_lake.jpg)

### Conclusion
Doing this is literally possible, but just barely. In this essay, I’ve
set out some of the minimal groundwork required to even contemplate
such a project: We need clarity on what this program does, why we want
to change it, whether we can provide a compelling argument for the
correctness of our changes and whether the bureaucratic context even
allows us to.

> Doing this is literally possible, but just barely
> &nbsp;&nbsp;&nbsp; <a href="https://twitter.com/share?ref_src=twsrc%5Etfw" class="twitter-share-button" data-text="&ldquo;Doing this is literally possible, but just barely&rdquo;&#010;&#010;" data-via="mseebach" data-dnt="true" data-show-count="false">Tweet</a>

Good luck, you will need it.

&nbsp;

<a href="https://twitter.com/mseebach?ref_src=twsrc%5Etfw" class="twitter-follow-button" data-size="large" data-dnt="true" data-show-count="false">Follow @mseebach</a>
