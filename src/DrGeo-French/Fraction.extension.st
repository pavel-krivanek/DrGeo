Extension { #name : #Fraction }

{ #category : #'*DrGeo-French-printing' }
Fraction >> aLancienne [
	"répond la fraction à l'ancienne, avec partie entière"

	| a b |
	a := self partieEntiere.
	b := self partieDécimale.
	^(a asString),'+',(b asString).
]

{ #category : #'*DrGeo-French-printing' }
Fraction >> aLegyptienne [
	"répond la fraction comme somme de fractions égyptiennes
	soit de numérateurs 1;
	algorithme de Fibonacci-Sylvester"

	| liste b c chaine |
	liste := #() commeCollectionOrdonnee.
	liste ajouter: self partieEntiere.
	b := self partieDécimale.
	[b numerateur > 1] tantQueVrai: [
		c := (b inverse partieEntiere + 1) inverse.
		b := b-c.
		liste ajouter: c.
	].
	liste ajouter: b.
	chaine := (liste commeTableau a: 1) asString.
	liste := liste retirerTousLorsque: [ :n | n isInteger].
	liste := liste commeTableau.
	liste faire: [ :elt | chaine := chaine,' + ',(elt asString)].
	
	^chaine.
]

{ #category : #'*DrGeo-French-printing' }
Fraction >> avecDesMots [

	| t q |
	q := #('unième' 'demi' 'tiers' 'quart').
	t := self numerateur avecDesMots.
	(self deepCopy denominateur > 1) siVrai: [
		t := t,' '.
		(self denominateur < 5) siVrai: [
			t := t,(q a: self denominateur).
			]
		siFaux: [
			t := t,(self denominateur avecDesMotsDen),'ième'.
			].
		(self numerateur > 1 et: (self denominateur =3) contraire) siVrai: [
			t := t,'s'.
			]
		].
	^t.
]

{ #category : #'*DrGeo-French-printing' }
Fraction >> commePari [
	"répond la fraction comme probabilité"

	| c |
	c := self numerateur asString.
	(self numerateur < 2) siVrai: [
		c := c,' chance contre '.
		] siFaux:[
		c := c,' chances contre '.
		].
	c := c,(self denominateur - self numerateur) asString.
	^c
]

{ #category : #'*DrGeo-French-printing' }
Fraction >> commeProba [
	"répond la fraction comme probabilité"

	| c |
	c := self numerateur asString.
	(self numerateur < 2) siVrai: [
		c := c,' chance sur '.
		] siFaux:[
		c := c,' chances sur '.
		].
	c := c,self denominateur asString.
	^c
]

{ #category : #'*DrGeo-French' }
Fraction >> de: unNombre [

	^self * unNombre.
]

{ #category : #'*DrGeo-French' }
Fraction >> denominateur [

	^self denominator.
]

{ #category : #'*DrGeo-French' }
Fraction >> estUnePuissanceDe2 [

	^self isPowerOfTwo.
]

{ #category : #'*DrGeo-French' }
Fraction >> numerateur [

	^self numerator.
]

{ #category : #'*DrGeo-French' }
Fraction >> reduite [

	^self reduced.
]
