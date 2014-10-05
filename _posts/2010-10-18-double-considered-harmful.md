---
layout: post
title: Double considered harmful
---

_ or: How the number 1.2 cramped my style.._

So, everybody who paid attention in college CS knows this. Heck, I didn’t always pay attention, and I knew it, but it still caught me by surprise when I hit my head on this issue in the real world.

Recapping the background: The double (as we know it in Java) is short for “double precision binary floating-point format”, and they are the floats more precise big brother. Floats and doubles are a trade-offs where precision is traded for the ability to store them in a fixed amount of space and to perform very fast arithmetic on them. Basically it’s two seperate numbers, called a significant and an exponent, and they are then subjected to some mathemagic to yield any of a very wide range of numbers.&nbsp;

If you don’t need the floating point, which most people often don’t, you’re better off storing your numbers as fixed-point (e.g. the DECIMAL columntype in most databases). Unfortunately Java (and many other not-so-modern languages) doesn’t have such a type natively.

So doubles aren’t perfectly precise, we know that, but that’s only for large and weird numbers, right? No. For one, a double can’t be 1.2. You wouldn’t know that if you didn’t look for it, because when you print doubles, Java rounds them off for you. And rightly so, the error is exceedingly small: had this been 1.2 meters, the error would amount to a fraction of the size of an atom. Obviously, this is perfectly fine - right up until the point when it’s not.

Our application dabbles quite a bit in arbitrary precision. We (among other things) deal in sequences of daily return ratios and foreign exchange - numbers that are notoriously unwilling to just be nice and round. By the time we get around to adding up your daily FX-adjusted returns for the past year, the error on a simple double-value starts to add up to real money, so we implement these numbers as BigDecimals (specifically our own wrapper for it that adds some useful fuctionality, including the ability to do fractions).

This is all very well - until someone decides to stick something like 1.2 into BigDecimal. Recalling how printing 1.2 is fine, you’d be excused in assuming that using the double-constructor of BigDecimal is fine. But no, and with potentially disastrous consequences.

Consider this simple method:

{% highlight java %} 
public BigDecimal iterate_multiplication(
                                   int iterations,
                                   BigDecimal multiplicand) {
        BigDecimal bd_out = BigDecimal.ONE;
        for (int i=0; i<iterations; i++) 
                  bd_out = bd_out
                           .add(BigDecimal.ONE)
                           .multiply(multiplicand);
        return bd_out;
    }
{% endhighlight %}

And these two invocations – on the surface they are equivalent:

{% highlight java %} 
iterate_multiplication(1000, new BigDecimal(1.2));
iterate_multiplication(1000, new BigDecimal("1.2"));
{% endhighlight %}

(BigDecimal will parse a decimal number from a string - IMHO the easiest way to get an exact value into a BigDecimal)

The latter invocation returns well over 1000 times faster. Three full orders of magnitude. 15 milliseconds in place of 20 seconds. This is because the former is called with an argument that, behind the scene, has 51 decimal places, which, obviously, is significantly more complicated to multiply.

The two methods returns rather different numbers, but that is due to iterating the multiplication, which amplifies the error of the double. Both numbers have 81 digits before the decimal point, and share the first 13. The really interesting - but at this point, hardly surprising - difference is after the decimal point: The former has 52,000 decimals, the latter just 1,000.

Even though fortune-cookie conclusions are often over-generalizing, I will venture into that territory: Don’t ever construct a BigDecimal with a double. It doesn’t do what you think it does.

---

Written for &amp; posted on [the TIM Group blog][1].

   [1]: https://devblog.timgroup.com/2010/10/18/double_considered_harmful/
  