Class {
	#name : #DrGeoScriptRhombus,
	#superclass : #DrGeoUserScript,
	#category : #DrGeoII-User
}

{ #category : #public }
DrGeoScriptRhombus class >> description [
	^'Je vérifie si un quadrilatère est un losange.
Pour m''utiliser :
1. Clique sur un polygone ;
2. Clique quelque part sur le fond de la figure.
Je colorie en bleu le quadrilatère lorsque c''est un losange, sinon j''indique ce qui ne va pas.'
]

{ #category : #private }
DrGeoScriptRhombus class >> newArgumentsType [
	^{DrGPolygonItem}
]

{ #category : #public }
DrGeoScriptRhombus class >> scriptName [
	^'Est losange ?'
]

{ #category : #public }
DrGeoScriptRhombus >> compute [
	self paintRed.
	^ self isRhombus
		ifTrue: [ 
			self paintBlue.
			'Bravo ! Je suis un losange.' ]
		ifFalse: [  | message |
			message := ReadWriteStream on: String new.
			message << 'Voyons, je ne suis pas un losange car :'.
			self isQuad 
				ifFalse: [ message crtab << '- je n''ai pas 4 sommets']
				ifTrue: [ 
					self isIsometric ifFalse: [message crtab << '- mes côtés ne sont pas isométriques'].
					self isOppositeSideParallel ifFalse: [ message crtab << '- mes côtés opposés ne sont pas parallèles' ]].
				message contents]

]

{ #category : #public }
DrGeoScriptRhombus >> isIsometric [
	| side1 |
	side1 := self arg1 sidesLength first.
	^ self arg1 sidesLength
		detect: [ :aSide| (aSide closeTo: side1) not ]
		ifFound: [ false ]
		ifNone: [ true ]
]

{ #category : #public }
DrGeoScriptRhombus >> isOppositeSideParallel [
	| side1 side2 side3 side4 points|
	points := self arg1 points.
	side1 := points first - points second.
	side2 := points second - points third.
	side3 := points third - points fourth.
	side4 := points fourth - points first.

	^ ((side1 crossProduct: side3) closeTo: 0)  and: [(side2 crossProduct: side4) closeTo: 0]  

]

{ #category : #public }
DrGeoScriptRhombus >> isQuad [
	^ self arg1 points size = 4
]

{ #category : #public }
DrGeoScriptRhombus >> isRhombus [
	|   points mid1 mid2 diag1 diag2 |
	points := self arg1 points.
	diag1 := points first - points third.
	diag2 := points second - points fourth.
	mid1 := points first + points third / 2.
	mid2 := points second + points fourth / 2.
	^ self isQuad and: [mid1 = mid2 and: [(diag1 dotProduct: diag2) closeTo: 0]]

]

{ #category : #public }
DrGeoScriptRhombus >> paintBlue [
	self costume1 style color: Color blue
]

{ #category : #public }
DrGeoScriptRhombus >> paintRed [
	self costume1 style color: Color red
]
