Extension { #name : #Integer }

{ #category : #'*DrGeo-French' }
Integer >> auHasard [

	^self atRandom.
]

{ #category : #'*DrGeo-French-printing' }
Integer >> avecDesMots [
	"SmallInteger maxVal asWords"
	| mils minus three num answer milCount pluriel |
	self = 0 ifTrue: [^'zero'].
	mils := #('' ' mille' ' million' ' milliard' ' billion' ' billiard' ' trillion' ' trilliard' ' quadrillion' ' quadrilliard' ' quintillion' ' quintilliard' ' sextillion' ' sextilliard' ' septillion' ' septilliard' ' octillion' ' octilliard' ' nonillion' ' nonilliard' ' décillion' ' décilliard').
	num := self.
	minus := ''.
	self < 0 ifTrue: [
		minus := 'moins '.
		num := num negated.
	].
	answer := String new.
	milCount := 1.
	[num > 0] whileTrue: [
		three := (num \\ 1000) troisChiffresEnNom. 
		pluriel := ((num \\ 1000)>1).
		num := num // 1000.
		three isEmpty ifFalse: [
			answer isEmpty ifFalse: [
				answer := ' ',answer
			].
		(pluriel and: [milCount>2]) ifTrue: [
			answer := three,(mils at: milCount),'s',answer.
			] ifFalse: [
			((pluriel not) and: [milCount=2]) ifTrue: [
				answer := (mils at: milCount),answer.
				] ifFalse: [
				answer := three,(mils at: milCount),answer.
				]
			].
		].
		milCount := milCount + 1.
	].
	^minus,answer
]

{ #category : #'*DrGeo-French-printing' }
Integer >> avecDesMotsDen [
	"SmallInteger maxVal asWords"
	| mils minus three num answer milCount |
	self = 0 ifTrue: [^'zero'].
	mils := #('' ' mille' ' millions' ' milliards' ' billions' ' billiards' ' trillions' ' trilliards' ' quadrillions' ' quadrilliards' ' quintillions' ' quintilliards' ' sextillions' ' sextilliards' ' septillions' ' septilliards' ' octillions' ' octilliards' ' nonillions' ' nonilliards' ' décillions' ' décilliards').
	num := self.
	minus := ''.
	self < 0 ifTrue: [
		minus := 'moins '.
		num := num negated.
	].
	answer := String new.
	milCount := 1.
	[num > 0] whileTrue: [
		three := (num \\ 1000) troisChiffresDenominateur.
		num := num // 1000.
		three isEmpty ifFalse: [
			answer isEmpty ifFalse: [
				answer := ' ',answer
			].
			answer := three,(mils at: milCount),answer.
		].
		milCount := milCount + 1.
	].
	^minus,answer
]

{ #category : #'*DrGeo-French' }
Integer >> commeFraction [

	^self asFraction.
]

{ #category : #'*DrGeo-French' }
Integer >> decompositionFacteursPremiers [
	| facteurs str tabs n|
	facteurs := self primeFactors.
	tabs := (self numberOfDigits + 1) // 3 + 1.
	str := WriteStream on: (String new: 20).
	str cr.
	n := self.
	facteurs do: [ :facteur |
		str << n ; tab: (tabs - (n numberOfDigits // 3)) ; << '| ' ; << facteur; cr.
		n := n // facteur].
	str << 1 ; tab: tabs ; << '|'; cr; cr.
	str << self << ' = '.
	facteurs do: [ :facteur | str << facteur] separatedBy: [str << ' × '].
	^ str contents
]

{ #category : #'*DrGeo-French' }
Integer >> denominateur [
	
	^self denominator.
]

{ #category : #'*DrGeo-French' }
Integer >> diviseurs [
"diviseurs du nombre placés dans une collection" 
	^ (Array streamContents: [:str |
		1 to: self sqrtFloor do: [ :i | 
			(self rem: i) = 0 ifTrue: [ str nextPut: i; nextPut: self // i ]]]) asSet sorted
]

{ #category : #'*DrGeo-French-printing' }
Integer >> enChiffresRomains [

	^self printStringRoman.
]

{ #category : #'*DrGeo-French-testing' }
Integer >> estDivisiblePar: unEntier [

	^(self \\ unEntier) =0.
]

{ #category : #'*DrGeo-French-testing' }
Integer >> estPremier [

	^self isPrime.
]

{ #category : #'*DrGeo-French-testing' }
Integer >> estPremierAvec: unEntier [

	^(self pgdc: unEntier) = 1.
]

{ #category : #'*DrGeo-French-testing' }
Integer >> estProbablementPremier [

	^self isProbablyPrime.
]

{ #category : #'*DrGeo-French-testing' }
Integer >> estUnCarre [
	
	^(self auCarre estEntier).
]

{ #category : #'*DrGeo-French' }
Integer >> facteursPremiers [
	^ self primeFactors 
]

{ #category : #'*DrGeo-French' }
Integer >> factorielle [

	^self factorial.
]

{ #category : #'*DrGeo-French' }
Integer >> foisRepete: unBloc [

	^self timesRepeat: unBloc.
]

{ #category : #'*DrGeo-French' }
Integer >> multiples: n [
"Answer my first n multiple"
	^ Array streamContents: [:str |
		1 to: n do: [ :i | str nextPut: i * self ]]
]

{ #category : #'*DrGeo-French' }
Integer >> nombreDeChiffres [

	^self numberOfDigits.
]

{ #category : #'*DrGeo-French' }
Integer >> nombreDeChiffresEnBase: uneBase [

	^self numberOfDigitsInBase: uneBase.
]

{ #category : #'*DrGeo-French' }
Integer >> numerateur [
	
	^self numerator.
]

{ #category : #'*DrGeo-French' }
Integer >> pgdc: unEntier [

	^self gcd: unEntier.
]

{ #category : #'*DrGeo-French' }
Integer >> ppmc: unEntier [

	^self lcm: unEntier.
]

{ #category : #'*DrGeo-French' }
Integer >> precedent [
	"décrémente un entier"

	^self - 1.
]

{ #category : #'*DrGeo-French' }
Integer >> suivant [
	"incrémente un entier"

	^self + 1.
]
