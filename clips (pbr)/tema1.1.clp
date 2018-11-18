(deffacts fapte
	(pnp y)
	(rlf y)
	(piu y)
	)

(defrule r1
	(pnp y)
	(rlf y)
	(piu y)
	=>
	(printout t "Check the printer-computer cable.
	Ensure printer software is installed.
	Check/replace ink
	")
	)
	
(defrule r2
	(pnp y)
	(rlf y)
	(piu n)
	=>
	(printout t "Check/replace ink.
	Check for paper jam.
	")
	)
	
(defrule r3
	(pnp y)
	(rlf n)
	(piu y)
	=>
	(printout t "Check the power cable.
	Check the printer-computer cable.
	Ensure printer software is installed.
	")
	)
	
(defrule r4
	(pnp y)
	(rlf n )
	(piu n)
	=>
	(printout t "Check for paper jam.
	")
	)
	
(defrule r5
	(pnp n)
	(rlf y)
	(piu y)
	=>
	(printout t "Ensure printer software is installed.
	Check/replace ink.
	")
	)
	
(defrule r6
	(pnp n)
	(rlf y)
	(piu n)
	=>
	(printout t "Check/replace ink
	")
	)
	
(defrule r7
	(pnp n)
	(rlf n)
	(piu y)
	=>
	(printout t "Ensure printer software is installed.
	")
	)
	
(defrule r8
	(pnp n)
	(rlf n)
	(piu n)
	=>
	(printout t "God bless you!
	")
	)