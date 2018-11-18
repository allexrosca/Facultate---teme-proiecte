
(defrule r1
	(piu y)	
	=>
	(printout t "Ensure printer software is installed.
	")
	)
	
(defrule r2
	(rlf y)
	=>
	(printout t "Check/replace ink.
	")
	)
	
(defrule r3
	(pnp y)
	(piu y)
	=>
	(printout t "Check the printer-computer cable.
	")
	)
	
(defrule r4
	(pnp y)
	(piu n)
	=>
	(printout t "Check for paper jam.
	")
	)
	
(defrule r5
	(pnp y)
	(rlf n)
	(piu y)
	=>
	(printout t "Check the power cable.
	")
	)
	
	
(defrule r6
	(pnp n)
	(rlf n)
	(piu n)
	=>
	(printout t "God bless you!
	")
	)