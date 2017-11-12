Class {
	#name : #DrGeoScriptRectangle,
	#superclass : #DrGeoUserScript,
	#category : #DrGeoII-User
}

{ #category : #public }
DrGeoScriptRectangle class >> description [
	^'Je vérifie si un quadrilatère est un rectangle.
Pour m''utiliser :
1. Clique sur un polygone ;
2. Clique quelque part sur le fond de la figure.
Je colorie en bleu le quadrilatère lorsque c''est un rectangle, sinon j''indique ce qui ne va pas.'
]

{ #category : #private }
DrGeoScriptRectangle class >> newArgumentsType [
	^{DrGPolygonItem}
]

{ #category : #public }
DrGeoScriptRectangle class >> scriptName [
	^'Est rectangle ?'
]

{ #category : #public }
DrGeoScriptRectangle >> compute [
	self paintRed.
	^ self isRectangle 
		ifTrue: [ 
			self paintBlue.
			'Bravo ! Je suis un rectangle.' ]
		ifFalse: [  | message |
			message := ReadWriteStream on: String new.
			message << 'Voyons, je ne suis pas un rectangle car :'.
			self isQuad 
				ifFalse: [ message crtab << '- je n''ai pas 4 sommets']
				ifTrue: [ 
					self isOppositeSideIsometric ifFalse: [message crtab << '- mes côtés opposés ne sont pas isométriques'].
					self isOppositeSideParallel ifFalse: [ message crtab << '- mes côtés opposés ne sont pas parallèles' ].
					self isRectangleAngle ifFalse: [message crtab << '- mes sommets ne sont pas droits']].
				message contents]

]

{ #category : #public }
DrGeoScriptRectangle >> isOppositeSideIsometric [
	| side1 side2 side3 side4 points|
	points := self arg1 points.
	side1 := points first - points second.
	side2 := points second - points third.
	side3 := points third - points fourth.
	side4 := points fourth - points first.

	^ side1 r = side3 r and: [side2 r = side4 r]  

]

{ #category : #public }
DrGeoScriptRectangle >> isOppositeSideParallel [
	| side1 side2 side3 side4 points|
	points := self arg1 points.
	side1 := points first - points second.
	side2 := points second - points third.
	side3 := points third - points fourth.
	side4 := points fourth - points first.

	^ ((side1 crossProduct: side3) closeTo: 0)  and: [(side2 crossProduct: side4) closeTo: 0]  

]

{ #category : #public }
DrGeoScriptRectangle >> isQuad [
	^ self arg1 points size = 4
]

{ #category : #public }
DrGeoScriptRectangle >> isRectangle [
	| diag1 diag2 points mid1 mid2|
		points := self arg1 points.
	diag1 := points first - points third.
	mid1 := points first + points third / 2.
	diag2 := points second - points fourth.
	mid2 := points second + points fourth / 2.
	^ self isQuad and: [diag1 r = diag2 r and: [mid1 = mid2]]

]

{ #category : #public }
DrGeoScriptRectangle >> isRectangleAngle [
	| summits sides |
	summits := self arg1 points.
	sides := summits withIndexCollect: [:p :i | p - (summits at: i + 1 ifAbsent: [summits first])].
	sides withIndexDo: [ :s :i |
		((s dotProduct: (sides at: i + 1 ifAbsent: [sides first])) closeTo: 0) 
			ifFalse: [ ^ false]].
	^ true
]

{ #category : #public }
DrGeoScriptRectangle >> paintBlue [
	self costume1 style color: Color blue
]

{ #category : #public }
DrGeoScriptRectangle >> paintRed [
	self costume1 style color: Color red
]
