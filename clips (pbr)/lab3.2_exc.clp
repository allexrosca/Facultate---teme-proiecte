(deffacts meniu
	(1.Adauga un student
	2.Adauga note student
	3.Afisare informatii student
	4.Iesire)
)

(deftemplate student
	(slot nume)
	(multislot note)
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
	(assert(student(nume(read))))
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
	?b<-(student (nume ?x) (note $?y))
	(not(student (nume ?x) (note ?)))
	=>
	(retract ?a)
	(retract ?b)
	(printout t "Alegeti materia studentului: ")
	(bind ?materia (read))
	(printout t "Dati notele studentului: ")
	(bind ?note(explode$ (readline)))
	(modify ?b(note ?materia ?note $?y))
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
	(studentul ?x $?y)
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