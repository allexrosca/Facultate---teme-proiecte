(deffacts meniu
	(1.Adauga un student
	2.Adauga note student
	3.Afisare informatii student
	4.Iesire)
)

(defrule ceva
	?a<-(1.Adauga un student
	2.Adauga note student
	3.Afisare informatii student
	4.Iesire)
	=>
	(printout t "Alegeti o optiune:
	1.Adauga un student
	2.Adauga note student
	3.Afisare informatii student
	4.Iesire
	Optiunea aleasa: ")
	(assert(optiune(read)))
	(retract ?a)
)

(defrule r1
	?a<-(optiune 1)
	=>
	(printout t "Numele studentului: ")
	(assert(Studentul (read) are notele:))
	(retract ?a)
	(assert(1.Adauga un student
	2.Adauga note student
	3.Afisare informatii student
	4.Iesire))
)

(defrule r2
	?a<-(optiune 2)
	=>
	(retract ?a)
	(printout t "Introduceti numele studentului: ")
	(assert (Std(read)))
)

(defrule r22
	?a<-(Std ?x)
	?b<-(Studentul ?x are notele: $?y)
	(not(Studentul ?x ?))
	=>
	(retract ?a)
	(retract ?b)
	(printout t "Alegeti materia studentului: ")
	(bind ?materia (read))
	(printout t "Dati notele studentului: ")
	(bind ?note(explode$ (readline)))
	(assert(Studentul ?x are notele: ?note la materia ?materia / $?y))
	(assert(1.Adauga un student
	2.Adauga note student
	3.Afisare informatii student
	4.Iesire))
)


(defrule r3
	?a<-(optiune 3)
	=>
	(retract ?a)
	(printout t "Introduceti numele studentului: ")
	(assert (Stdu(read)))
)

(defrule r33
	?a<-(Stdu ?x)
	
	(Studentul ?x are notele: $?y)
   =>
   (printout t "Studentul " ?x " are notele: " $?y crlf)
	
	(retract ?a)
	
	(assert(1.Adauga un student
	2.Adauga note student
	3.Afisare informatii student
	4.Iesire))
)

(defrule r4
	?a<-(optiune 4)
	=>
	(printout t "O zi buna!
	")
)