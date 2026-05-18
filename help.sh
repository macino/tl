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
  *    important / verified
  !    urgent

STRUCTURE
  @name   entity ref → entities/name.md
  #tag    type / label
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

EXAMPLES
  @server = -running !              server down, urgent
  >> {A | B}                        do A or B, your call
  [#bug @auth] >> investigate       fix bug in auth
  (q) ?? why memory growing?        question only
  -t @db crash <- migration         db was down because migration
  (@cache %done ? >> deploy : _)    if cache done deploy else block
EOF
