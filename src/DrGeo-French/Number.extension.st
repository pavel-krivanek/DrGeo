Extension { #name : #Number }

{ #category : #'*DrGeo-French' }
Number >> a: UnNombre [

	^self to: UnNombre.
]

{ #category : #'*DrGeo-French' }
Number >> a: UnNombre faire: UnBloc [
	"boucle à condition de sortie"

	^self to: UnNombre do: UnBloc.
]

{ #category : #'*DrGeo-French' }
Number >> a: UnNombre par: UnPas [
"répond un intervalle avec un pas"
	^self to: UnNombre by: UnPas.
]

{ #category : #'*DrGeo-French' }
Number >> a: UnNombre par: UnPas faire: UnBloc [

	^self to: UnNombre by: UnPas do: UnBloc.
]

{ #category : #'*DrGeo-French-printing' }
Number >> affiche [

	^self printString.
]

{ #category : #'*DrGeo-French-printing' }
Number >> afficheEnBase: UneBase [

	^self printStringBase: UneBase.
]

{ #category : #'*DrGeo-French-truncation' }
Number >> arrondir [
"répond l'arrondi à l'entier le plus proche"
	^self rounded
]

{ #category : #'*DrGeo-French-truncation' }
Number >> arrondirA: UnNombre [
"répond l'arrondi à UnNombre près.
Par exemple 2 racine arrondirA:  0.01 répond 1.41"

	^self roundTo: UnNombre .
]

{ #category : #'*DrGeo-French-truncation' }
Number >> arrondirParDefautA: UnNombre [
"répond l'arrondi par défaut;
par exemple, 2 racine arrondirExcesA: 0.01 répond 1.41"
	
	^self roundDownTo: UnNombre
]

{ #category : #'*DrGeo-French-truncation' }
Number >> arrondirParExcesA: UnNombre [
"répond l'arrondi à l'excès;
par exemple, 2 racine arrondirExcesA: 0.01 répond 1.42"
	^self roundUpTo: UnNombre
]

{ #category : #'*DrGeo-French' }
Number >> auCarre [

	^self squared.
]

{ #category : #'*DrGeo-French' }
Number >> auCube [

	^self puissance: 3.
]

{ #category : #'*DrGeo-French' }
Number >> augmenteDe1 [

	^(self + 1).
]

{ #category : #'*DrGeo-French' }
Number >> augmenteDe: unNombre [
	"augmente d'un nombre."

	^(self + unNombre).
]

{ #category : #'*DrGeo-French' }
Number >> augmenteDePourcents: unPourcentage [
	"augmente d'un pourcentage.
	Par exemple 200 augmenteDePourcents: 6 répond 212"

	^self * (1 + (unPourcentage / 100)).
]

{ #category : #'*DrGeo-French' }
Number >> avecLeSigneDe: UnNombre [

	^UnNombre copySignTo: self.
]

{ #category : #'*DrGeo-French-conversion' }
Number >> commeDecimal [

	^self asFloat.
]

{ #category : #'*DrGeo-French-conversion' }
Number >> commeDuree [

	^self asDuration.
]

{ #category : #'*DrGeo-French-conversion' }
Number >> commeEntier [

	^self asInteger.
]

{ #category : #'*DrGeo-French-conversion' }
Number >> commeNombre [

	^self asNumber.
]

{ #category : #'*DrGeo-French' }
Number >> cosinus [
	"cosinus en degrés"
	
	^self degreeCos.
]

{ #category : #'*DrGeo-French' }
Number >> degres [

	^self radiansToDegrees.
]

{ #category : #'*DrGeo-French' }
Number >> devientCombienSachantQue: unNombre devient: unAutreNombre [
	"règle de trois"

	^(self * unAutreNombre / unNombre).
]

{ #category : #'*DrGeo-French' }
Number >> diminueDe1 [

	^(self - 1).
]

{ #category : #'*DrGeo-French' }
Number >> diminueDe: unNombre [
	"diminue d'un nombre."

	^(self - unNombre).
]

{ #category : #'*DrGeo-French' }
Number >> diminueDePourcents: unPourcentage [
	"diminue d'un pourcentage.
	Par exemple 200 diminuéDePourcents: 6 répond 188"

	^self * (1 - (unPourcentage / 100)).
]

{ #category : #'*DrGeo-French-printing' }
Number >> enPourcents [
	^ String streamContents: [ :str | 
			(self * 100) storeOn: str.
			str nextPutAll: ' %'].
]

{ #category : #'*DrGeo-French-testing' }
Number >> estDecimal [

	^(self isFloat).
]

{ #category : #'*DrGeo-French-testing' }
Number >> estDivisiblePar: UnNombre [

	^self isDivisibleBy: UnNombre.
]

{ #category : #'*DrGeo-French-testing' }
Number >> estEntier [

	^(self isInteger).
]

{ #category : #'*DrGeo-French-testing' }
Number >> estInfini [

	^self isInfinite.
]

{ #category : #'*DrGeo-French-testing' }
Number >> estNombre [

	^self isNumber.
]

{ #category : #'*DrGeo-French-testing' }
Number >> estNul [

	^self isZero.
]

{ #category : #'*DrGeo-French-testing' }
Number >> estPasNombre [

	^self isNaN.
]

{ #category : #'*DrGeo-French-conversion' }
Number >> heures [

	^self hours.
]

{ #category : #'*DrGeo-French' }
Number >> impair [
	
	^self odd.
]

{ #category : #'*DrGeo-French' }
Number >> inverse [

	^self reciprocal.
]

{ #category : #'*DrGeo-French-conversion' }
Number >> jours [

	^self days.
]

{ #category : #'*DrGeo-French-conversion' }
Number >> millisecondes [

	^self milliSeconds.
]

{ #category : #'*DrGeo-French' }
Number >> moyenneAvec: unNombre [
	
	^((self + unNombre)/2).
]

{ #category : #'*DrGeo-French-conversion' }
Number >> nanosecondes [

	^self nanoSeconds.
]

{ #category : #'*DrGeo-French' }
Number >> negatif [
	
	^self negative.
]

{ #category : #'*DrGeo-French' }
Number >> oppose [

	^self negated.
]

{ #category : #'*DrGeo-French' }
Number >> pair [
	
	^self even.
]

{ #category : #'*DrGeo-French-truncation' }
Number >> partieDécimale [
	^self fractionPart
]

{ #category : #'*DrGeo-French-truncation' }
Number >> partieEntiere [
	^self integerPart
]

{ #category : #'*DrGeo-French' }
Number >> positif [
	
	^self positive.
]

{ #category : #'*DrGeo-French' }
Number >> pourcentsDe: UnNombre [
	"répond un pourcentage.
	Par exemple 6 pourcentsDe: 200 répond 12"

	^self * UnNombre / 100.
]

{ #category : #'*DrGeo-French' }
Number >> procheDe: UnNombre [

	^self closeTo: UnNombre.
]

{ #category : #'*DrGeo-French' }
Number >> puissance: UnNombre [

	^self raisedTo: UnNombre.
]

{ #category : #'*DrGeo-French' }
Number >> racine [

	^self sqrt.
]

{ #category : #'*DrGeo-French' }
Number >> racineCubique [
	^self nthRoot: 3
]

{ #category : #'*DrGeo-French' }
Number >> racineNieme: unEntier [
	^self nthRoot: unEntier.
]

{ #category : #'*DrGeo-French-conversion' }
Number >> radians [
	
	^self degreesToRadians.
]

{ #category : #'*DrGeo-French' }
Number >> reste: UnNombre [
	^self rem: UnNombre
]

{ #category : #'*DrGeo-French-conversion' }
Number >> secondes [

	^self seconds.
]

{ #category : #'*DrGeo-French-conversion' }
Number >> semaines [

	^self weeks.
]

{ #category : #'*DrGeo-French' }
Number >> signe [
	
	^self sign.
]

{ #category : #'*DrGeo-French' }
Number >> sinus [
	"sinus en degrés"
	
	^self degreeSin.
]

{ #category : #'*DrGeo-French' }
Number >> strictementPositif [

	^self strictlyPositive.
]

{ #category : #'*DrGeo-French' }
Number >> tangente [
	"tangente en degrés"
	
	^(self sinus / (self cosinus)).
]

{ #category : #'*DrGeo-French-truncation' }
Number >> tronquer [
	^self floor
]

{ #category : #'*DrGeo-French-truncation' }
Number >> tronquerA: UnNombre [
"affiche le nombre tronqué à UnNombre près.
Par exemple, 2 racine tronquerA: 0.01 renvoie 1.41"
	^ self truncateTo: UnNombre
]
