# TL (Terse Language) Grammar

## Response rules

- **Context scope — most important.** A call to action has exactly two valid outcomes:
  perform it in the current context, or state that it cannot be performed there
  ("already done", "nothing outstanding", "not applicable"). Both are complete, expected
  answers. Never widen the search to another context, repo, branch or topic — including
  ones from earlier in the same session — and never perform the action there.
  "Nothing to do" is a result, not a gap to fill.
- Action licence: only `>>` — or a plain imperative aimed at the repo (write, save, run,
  implement, commit, fix, go ahead) — licenses edits, commits or tool actions.
  "look at X", "describe X", "what about X" = explain and stop.
- Unmarked or ambiguous turn → treat as `(q)`.
- A precise answer is a complete turn. No artifact is required to finish.
- Findings surfaced while explaining → report in prose with a recommendation.
  Never convert a finding into a blocking choice.
- Gate only irreversible or outward acts: commit, push, delete, time log, remote access.
- Structural claims name the exact node and edge, not the subtree:
  "X mounts, but its Y slot is missing, so Z never mounts" — not "Z is unwired".
- `(dod)` bounds delivery — nothing outside it ships.
- These rules outrank harness defaults; on conflict, state it once and follow these.
- On an ambiguous turn, open with `read as (q) — answering only`, then answer.
  It is not a question and does not block.
- Ambiguous word/phrase (two plausible readings, e.g. "live" = running|in-prod) →
  disambiguate before acting, don't infer. Flag existing ambiguous instructions
  instead of silently picking one reading.

```
look at #55368                 explain, no action
>> look at #55368              act
describe X                     explain, stop
write X into task file         act
what about the two paths?      explain + recommendation in prose, no gate
fork found mid-explanation     state it, recommend, keep answering
about to commit / push         gate — ask first
commit and push, topic repo already clean
                               say "already committed as <sha>, nothing outstanding"
                               — never commit a different repo/topic instead
@server = live ??              ambiguous: running, or in-prod? -> ask, don't infer
```

## Relations

```
>    flows-to / acts-on / causes
=    is / state / equals
!=   is-not / contradiction / wrong
->   results-in
??   explain / why / how
?=   what is value of
?    yes/no question
?!   review / verify
>>   directive — do this (strong)
>?   suggestion / soft directive
```

## Modifiers

```
~    uncertain / maybe
~~   very uncertain
*    important / priority      * deadline = friday
*v   verified / confirmed      *v claim = checked against source
!    urgent — SUFFIX           @server = -running !
!x   negate / prohibit — PREFIX   !action = do not act
```

## Structure

```
[]   context frame       [#bug @auth] ...
()   metadata / not a task   (think) ...
{}   set / options        >> {A | B}
|    or / alternative
+    add / increase
-    remove / negate      -debug-log ; = -running (state negation)
                          -t / +t are reserved tense markers, never removal
@    entity ref           @server, @tomas
#    type / tag           #bug, #low, #task
#123 external ticket ref  #54842, #55368   (digits = ticket, word = tag)
^    the (specific/definite)  ^PR, ^issue, ^fn
::   means / defined-as   X :: Y
::=  implements / realizes   @Service ::= @IService
```

## Tense

```
-t        past    (was / happened / completed)
+t        future  (will / planned / expected)
          present = unmarked default

-t:2d     2 days ago
+t:5m     in 5 minutes
+t:DATE   on date            +t:2026-05-20
```

## Linguistic shorthands

```
;     sequence / then         fix ; deploy ; notify
<-    because / caused-by     crash <- OOM
_     blocked / waiting-on    _ @PR#42
%     progress / status       %done  %wip  %50
&     and-also / relates-to   @auth & @session affected
```

## Conditionals

Inside `()` only — avoids ambiguity with other `?` uses.

```
(X ? Y : Z)   if X then Y else Z
(X ? Y)       if X then Y (no else)
```

## Mode prefixes (outside-task signals)

```
(q)      question — no task, no artifact
(think)  thinking out loud — no response needed
(ctx)    context update — no action
(meta)   discussing our interaction
         may name the axis: content | scope | timing | format
         content = factually wrong      scope  = did more/less than asked
         timing  = right thing, wrong moment   format = too long / wrong shape
(idea)   half-baked — not a directive
(ok)     answer landed — thread closed, no follow-up needed
(topic)  state/replace current conversation topic — new (topic) discards previous
(dod)    state/add definition-of-done — new (dod) appends to current unless told to rewrite
```

## Entity resolution

`@name` resolves to `~/.claude/entities/name.md`.
File contains entity properties, context, and notes.
I load entity content automatically when TL is active.
`@scope/package` is a package name, not an entity — never resolved.

## Examples

```
@server = -running !                      server down, urgent
!action                                   do not act
@memory + ??                              why is memory increasing?
[#low] @auth >> +feature-x               low-prio: add feature-x to auth
~~ bug = @auth                            uncertain: bug maybe in auth
*v latIds = 1713,1714,1715                verified against v1 source
>> {A | B}                                do A or B, your call
@config ?= timeout                        what is config.timeout?
[#bug @auth] >> investigate; @server = -running
#54842 ?! ^MR                             review the MR for ticket 54842
(q) ?? TL good for team use?
(think) maybe split auth into two services
(ctx) @project = paused until friday
(meta) scope                              did more than I asked
(ok)                                      that answered it, thread closed
(topic) migrate auth to OAuth2            sets/replaces conversation topic
(dod) tests pass & docs updated           adds to current DoD
^PR ?!                                    review the PR (specific one in context)
@UserService ::= @IUserService            UserService implements IUserService
```
