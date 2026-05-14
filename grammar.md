# TL (Terse Language) Grammar

## Relations

```
>    flows-to / acts-on / causes
=    is / state / equals
!=   is-not / contradiction / wrong
->   results-in
??   explain / why / how
?=   what is value of
?    yes/no question
>>   directive — do this (strong)
>?   suggestion / soft directive
```

## Modifiers

```
~    uncertain / maybe
~~   very uncertain
*    important / verified
!    urgent
```

## Structure

```
[]   context frame       [#bug @auth] ...
()   metadata / not a task   (think) ...
{}   set / options        >> {A | B}
|    or / alternative
+    add / increase
-    remove / negate
@    entity ref           @server, @tomas
#    type / tag           #bug, #low, #task
::   means / defined-as   X :: Y
```

## Mode prefixes (outside-task signals)

```
(q)      question — no task, no artifact
(think)  thinking out loud — no response needed
(ctx)    context update — no action
(meta)   discussing our interaction
(idea)   half-baked — not a directive
```

## Entity resolution

`@name` resolves to `entities/name.md` in the ai-wkf repo.
File contains entity properties, context, and notes.
I load entity content automatically when TL is active.

## Examples

```
@server = -running !                      server down, urgent
@memory + ??                              why is memory increasing?
[#low] @auth >> +feature-x               low-prio: add feature-x to auth
~~ bug = @auth                            uncertain: bug maybe in auth
>> {A | B}                                do A or B, your call
@config ?= timeout                        what is config.timeout?
[#bug @auth] >> investigate ^ @server = -running
(q) ?? TL good for team use?
(think) maybe split auth into two services
(ctx) @project = paused until friday
(meta) last answer too long
```
