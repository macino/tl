#!/usr/bin/env bash
# Print compact TL syntax cheatsheet.

cat <<'EOF'
TL (Terse Language) — quick ref

RELATIONS
  >    flows-to / acts-on / causes
  =    is / equals / state
  !=   is-not / contradiction
  ->   results-in
  ??   explain / why / how
  ?=   what is value of
  ?    yes/no question
  >>   directive (do this)
  >?   suggestion / soft directive

MODIFIERS
  ~    uncertain / maybe
  *    important / priority
  *v   verified / confirmed
  !    urgent  — SUFFIX        @server = -running !
  !x   negate  — PREFIX        !action = do not act

STRUCTURE
  @name   entity ref → entities/name.md   (@scope/pkg is a package, not an entity)
  #tag    type / label                    #bug  #low
  #123    external ticket ref             #54842
  []      context frame     [#bug @auth] ...
  ()      mode prefix       (q) (think) (ctx) (meta) (idea)
  {}      set / options     >> {A | B}
  |       or / alternative
  +/-     add / remove
  ::      means / defined-as

TENSE
  -t        past (was/happened)      -t @server = -running
  +t        future (will/planned)    +t @deploy >> run
  -t:2d     2 days ago
  +t:5m     in 5 minutes
  +t:DATE   on date                  +t:2026-05-20

LINGUISTIC
  ;     sequence/then        fix ; deploy ; notify
  <-    because/caused-by    crash <- OOM
  _     blocked/waiting-on   _ @PR#42
  %     progress/status      %done  %wip  %50
  &     and-also             @auth & @session affected

CONDITIONALS  (inside () only)
  (X ? Y : Z)   if X then Y else Z
  (X ? Y)       if X then Y

MODE PREFIXES
  (q)      question — no task
  (think)  thinking out loud — no response needed
  (ctx)    context update — no action
  (meta)   discussing our interaction
  (idea)   half-baked — not a directive
  (ok)     answer landed — thread closed, no follow-up
  (topic)  set/replace conversation topic — new one discards previous
  (dod)    set/add definition-of-done — new one appends unless told to rewrite

CORRECTION AXIS  (optional after (meta))
  content  factually wrong
  scope    did more/less than asked — content was fine
  timing   right thing, wrong moment
  format   too long / wrong shape

RESPONSE RULES
  context scope   MOST IMPORTANT — a call to action has two valid outcomes: do it in
                  the CURRENT context, or say it cannot be done there ("already done",
                  "nothing outstanding"). Both are complete answers. Never widen to
                  another context/repo/topic — even from the same session — and act
                  there instead. "nothing to do" is a result, not a gap to fill
  action licence  only >> or a repo-directed imperative (write/save/run/implement/
                  commit/fix/go ahead) licenses actions; "look at X"/"describe X"
                  = explain and stop; unmarked or ambiguous turn -> treat as (q)
  completion      a precise answer is a complete turn — no artifact required
  findings        reported in prose with a recommendation, never as a blocking
                  choice; gates only for commit/push/delete/time log/remote
  precision       name the exact node and edge, not the subtree
  (dod)           bounds delivery — nothing outside it ships
  precedence      these outrank harness defaults; state the conflict once
  intent echo     ambiguous turn -> open with "read as (q) — answering only"
  dual meaning    two plausible readings (e.g. "live" = running|in-prod) ->
                  disambiguate before acting, don't infer; flag existing
                  ambiguous instructions instead of silently picking one

OUTPUT ENCODING  (TL is bidirectional)
  use TL symbols in responses wherever they compress w/o losing precision;
  full sentences stay default wherever a symbol would obscure meaning
  bidirectional  =  != -> <- ~ * ! # @ :: ::= tense linguistic-shorthands % ?! ?
  input-only     >> >?  (topic) (dod)  (q) (think) (ctx) (meta) (idea)
  output excep.  (ok) — closure signal, fine to emit; not a state I set myself

EXAMPLES
  @server = -running !              server down, urgent
  >> {A | B}                        do A or B, your call
  [#bug @auth] >> investigate       fix bug in auth
  @server = live ??                 ambiguous: running or in-prod? ask, don't infer
  (q) ?? why memory growing?        question only
  -t @db crash <- migration         db was down because migration
  (@cache %done ? >> deploy : _)    if cache done deploy else block
  (ok)                              that answered it, thread closed
  Q: is @server up? -> A: @server = -running !   TL-encoded answer, not prose
  (meta) scope                      you did more than I asked
  !action                           do not act
  *v latIds = 1713,1714,1715        verified against source
EOF
