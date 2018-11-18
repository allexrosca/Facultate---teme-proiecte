(deffacts beginnings
	(^)

)

(deftemplate cell
	(slot x)
	(slot y)
	(slot life)
	(slot neigh)
	(slot check)
)

(defrule linCol
	?a<-(^)
	=>
	(retract ?a)
	(printout t "Dati numarul de linii: ")
	(bind ?n (read))
	(printout t "Dati numarul de coloane: ")
	(bind ?m (read))
	(assert (linii ?n coloane ?m))
	(assert (@))
)

(defrule celVii
	?a<-(@)
	=>
	(retract ?a)
	(printout t "Dati numarul de celule vii: ")
	(bind ?n (read))
	(assert (cv ?n))
)

(defrule celVii2
	?a<-(cv ?v)
	(test (> ?v 0))
	=>
	(retract ?a)
	(assert (cv (- ?v 1)))
	(printout t "Dati coordonata x a celulei vii: ")
	(bind ?x (read))
	(printout t "Dati coordonata y a celulei vii: ")
	(bind ?y (read))
	(assert (cell (x ?x)(y ?y)(life 1)(neigh 0)(check 1)))
)

(defrule celViiStergere
	?a<-(cv 0)
	=>
	(retract ?a)
	(assert (x 1 y 1))
)

(defrule incrementare1
	(linii ?n coloane ?m)
	?a<-(x ?x y ?y)
	(test(< ?y ?m))
	=>
	(retract ?a)
	(assert (x ?x y (+ ?y 1)))	
)

(defrule incrementare2
	(linii ?n coloane ?m)
	?a<-(x ?x y ?y)
	(test(< ?x ?n))
	(test(eq ?y ?m))
	=>
	(retract ?a)
	(assert (x (+ ?x 1) y 1))
)


(defrule genMatrice
	(declare (salience 10))
	(x ?x y ?y)
	(not (cell (x ?x)(y ?y)(life ?)(neigh ?)(check ?)))
	=>
	(assert (cell (x ?x)(y ?y)(life 0)(neigh 0)(check 1)))
)

(defrule incrementareStergere
	(linii ?n coloane ?m)
	?a<-(x ?x y ?y)
	(test (eq ?x ?n))
	(test (eq ?y ?m))
	=>
	(retract ?a)
)