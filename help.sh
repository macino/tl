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
EOF
