;; votekick e ban
on *:text:!vote*:#cdzforever,#starhill: {
  if ($strip($1) == !voteban) {
    op.check
    if (%vote.running == on) { noticen j� existe uma vota��o | halt }
    ;msgc # !voteban iniciado para09 $replace($2,$me,$nick)
    msgn !voteban iniciado para09 $upper($nick) $+ ! TU MESMO SAFADO!
    set %vote.min $int($calc(($nick(#,0) / 3) + 2))
    msgn votos necessarios para banir 09 %vote.min 15- tempo09 90 15segs
    set %vote.nick $nick
    ;set %vote.nick $replace($2,$me,$nick)
    set %vote.running on | set %vote.sim 0 | set %vote.n�o 0
    .timervotecancel 1 90 unset %vote.*
    .timervotecancel2 1 90 msgto $chan !voteban falhou - time out
  }
  if ($strip($1) == !vote) {
    if (%vote.running != on) { noticen n�o existe uma vota��o | halt }
    if (!$istok($nick,%vote.whovoted,32)) {
      set %vote.whovoted %vote.whovoted $nick
      if ($strip($2) == sim) {
        inc %vote.sim
        noticen votado...
        if (%vote.sim >= %vote.min) { ban -u900 # %vote.nick 4 | msgn !voteban finalizado | unset %vote.* | .timervote* off }
      }
      if ($strip($2) == n�o) {
        inc %vote.n�o
        noticen votado...
        if (%vote.n�o >= %vote.min) { msgn !voteban falhou | unset %vote.* }
      }
    }
    else {
      noticen Voc� j� votou
    }
  }
  if ($strip($1) == !votepreview) {
    if (%vote.running != on) { noticen n�o existe uma vota��o | halt }
    msgn sim -09 %vote.sim votos 15/ n�o -09 %vote.n�o votos
    msgn votos necessarios:09 %vote.min 15- tempo restante:09 $timer(votecancel).secs $+ s
  }
  if ($strip($1) == !votecancel) {
    op.check
    if (%vote.running != on) { noticen n�o existe uma vota��o | halt }
    .timervote* off
    unset %vote.*
    msgn !voteban cancelado...
  }
}
;; to do list
;; tratar mudan�a de nicks tanto do alvo quanto de quem votou
on *:text:!num->ext*:#cdzforever: {
  msgto #cdzforever 09 $+ $2 14->08 $num->ext($remove($2,.))
}
on *:text:!sou*mulher:#cdzforever: { kick # $nick Volte para cozinha! }
