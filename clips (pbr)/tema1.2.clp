(deffacts fapte
	(pnp y)
	(rlf y)
	(piu y)
	)


(defrule r1
	(pnp y)
	(rlf n)
	(piu y)
	=> 
	(printout t "Check the power cable.
	")
	)
	
(defrule r2
	(or
		(and (pnp y)(rlf y)(piu y) )
		(and (pnp y)(rlf n)(piu y) )
	)
	=>
	(printout t "Check the printer-computer cable.
	")
	)
	
(defrule r3
	(or
		(and (pnp y)(rlf y)(piu y) ) 
		(and (pnp y)(rlf n)(piu y) ) 
		(and (pnp n)(rlf y)(piu y) ) 
		(and (pnp n)(rlf n)(piu y) )
	)
	=>
	(printout t "Ensure printer software is installed.
	") 
	)
	
(defrule r4
	(or
		(and (pnp y)(rlf y)(piu y) )
		(and (pnp y)(rlf y)(piu n) )
		(and (pnp n)(rlf y)(piu y) )
		(and (pnp n)(rlf y)(piu n) )
	)
	=>
	(printout t "Check/replace ink.
	")
	)
	
(defrule r5
	(or
		(and (pnp y)(rlf y)(piu n) )
		(and (pnp y)(rlf n)(piu n) )
	)
	=>
	(printout t "Check for paper jam.
	")
	)