(deffacts meniu
	(1.Adauga un student
	2.Adauga note student
	3.Afisare informatii student
	4.Cautare student dupa note
	5.Iesire)
)
(deftemplate student
(slot nume)
(multislot note)
)
(defrule ceva
	?a<-(1.Adauga un student
	2.Adauga note student
	3.Afisare informatii student
	4.Cautare student dupa note
	5.Iesire)
	=>
	(printout t "Alegeti o optiune:
	1.Adauga un student
	2.Adauga note student
	3.Afisare informatii student
	4.Cautare student dupa note
	5.Iesire
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
	4.Cautare student dupa note
	5.Iesire))
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
	?b<-(student (nume ?x) (note $?z))
	(not(student (nume ?x) (note ?)))
	=>
	(retract ?a)
	(printout t "Alegeti materia studentului: ")
	(bind ?materia (read))
	(printout t "Dati notele studentului: ")
	(bind ?note(explode$ (readline)))
	(modify ?b(note $?z ?materia ?note))
	(assert(1.Adauga un student
	2.Adauga note student
	3.Afisare informatii student
	4.Cautare student dupa note
	5.Iesire))
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
	(student (nume ?x)(note $?y))
   =>
	(printout t "Studentul " ?x " are notele: " $?y crlf)
	(retract ?a)
	
	(assert(1.Adauga un student
	2.Adauga note student
	3.Afisare informatii student
	4.Cautare student dupa note
	5.Iesire))
)
(defrule r4
	?a<-(optiune 4)
	=>
	(retract ?a)
	(printout t "Introduceti materia studentului: ")
	(assert (Materia (read)))
	(printout t "Introduceti nota studentului: ")
	(assert (Nota (read)))
)

(defrule r44
	?a<-(Materia ?x)
	?b<-(Nota ?y)
	(not(student(nume ?)(note $? ?x $? ?y $?)))
	=>
	(retract ?a)
	(retract ?b)
	(printout t "Nu exista niciun student cu aceasta nota"crlf)
	(assert(1.Adauga un student
	2.Adauga note student
	3.Afisare informatii student
	4.Cautare student dupa note
	5.Iesire))
)

(defrule r45
	?a<-(Materia ?x)
	?b<-(Nota ?y)
	(student(nume ?z)(note $? ?x $? ?y $?))
	=>
	(retract ?a)
	(retract ?b)
	(printout t "Studentul cu aceasta nota este: " ?z crlf)
	(assert(1.Adauga un student
	2.Adauga note student
	3.Afisare informatii student
	4.Cautare student dupa note
	5.Iesire))
)
(defrule r46
	?a<-(Materia ?x)
	?b<-(Nota ?y)
	?c<-(student(nume ?z)(note $? ?x $? ?y $?))
	?d<-(student(nume ?w)(note $? ?x $? ?y $?))
	(test(neq ?z ?w))
	=>
	(retract ?b)
	(printout t "Dati inca o nota: ")
	(bind ?l (read))
	(assert (Nota ?l))
	
	
)

(defrule r5
	?a<-(optiune 5)
	=>
	(printout t "O zi buna!
	")
)