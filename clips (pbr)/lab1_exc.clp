(deffacts fapte
	(minge rosie)
	(minge mare)
	)
	
(defrule prima
	(minge rosie)
	(minge mare)
	=>
	(assert(minge frumoasa)))

(defrule adoua
	(minge rosie)
	=>
	(printout t "bine")
	)
	