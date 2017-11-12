Class {
	#name : #DrGeoScriptSquare,
	#superclass : #DrGeoUserScript,
	#category : #DrGeoII-User
}

{ #category : #public }
DrGeoScriptSquare class >> description [
	^'Je vérifie si un quadrilatère est un carré.
Pour m''utiliser :
1. Clique sur un polygone ;
2. Clique quelque part sur le fond de la figure.
Je colorie en bleu le quadrilatère lorsque c''est un carré, sinon j''indique ce qui ne va pas.'
]

{ #category : #private }
DrGeoScriptSquare class >> newArgumentsType [
	^{DrGPolygonItem}
]

{ #category : #public }
DrGeoScriptSquare class >> scriptName [
	^'Est carré ?'
]

{ #category : #public }
DrGeoScriptSquare >> compute [
	self paintRed.
	^ self isSquare 
		ifTrue:  [ 
			self paintBlue.
			'Bravo ! Je suis un carré.' ]
		ifFalse: [ | message |
			message := ReadWriteStream on: String new.
			message << 'Voyons, je ne suis pas un carré car :'.
			self isQuad 
				ifFalse: [ message crtab << '- je n''ai pas 4 sommets']
				ifTrue: [
					self isIsometric ifFalse: [message crtab << '- mes côtés ne sont pas isométriques'].
					self isRectangleAngle ifFalse: [message crtab << '- mes sommets ne sont pas droits']].
			message contents].
	 
]

{ #category : #public }
DrGeoScriptSquare >> isIsometric [
	| side1 |
	side1 := self arg1 sidesLength first.
	^ self arg1 sidesLength
		detect: [ :aSide| (aSide closeTo: side1) not ]
		ifFound: [ false ]
		ifNone: [ true ]
]

{ #category : #public }
DrGeoScriptSquare >> isQuad [
	^ self arg1 points size = 4
]

{ #category : #public }
DrGeoScriptSquare >> isRectangleAngle [
	| summits sides |
	summits := self arg1 points.
	sides := summits withIndexCollect: [:p :i | p - (summits at: i + 1 ifAbsent: [summits first])].
	sides withIndexDo: [ :s :i |
		((s dotProduct: (sides at: i + 1 ifAbsent: [sides first])) closeTo: 0) 
			ifFalse: [ ^ false]].
	^ true
]

{ #category : #public }
DrGeoScriptSquare >> isSquare [
	| diag1 diag2 points mid1 mid2 |
	points := self arg1 points.
	diag1 := points first - points third.
	mid1 := points first + points third / 2.
	diag2 := points second - points fourth.
	mid2 := points second + points fourth / 2.
	^ self isQuad and: [(diag1 r closeTo: diag2 r)  and: [(mid1 closeTo: mid2) and: [(diag1 dotProduct: diag2) closeTo: 0]]]

]

{ #category : #public }
DrGeoScriptSquare >> paintBlue [
	self costume1 style color: Color blue
]

{ #category : #public }
DrGeoScriptSquare >> paintRed [
	self costume1 style color: Color red
]
