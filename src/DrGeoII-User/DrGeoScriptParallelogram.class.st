Class {
	#name : #DrGeoScriptParallelogram,
	#superclass : #DrGeoUserScript,
	#category : #DrGeoII-User
}

{ #category : #public }
DrGeoScriptParallelogram class >> description [
	^'Je vérifie si un quadrilatère est un parallélogramme.
Pour m''utiliser :
1. Clique sur un polygone ;
2. Clique quelque part sur le fond de la figure.
Je colorie en bleu le quadrilatère lorsque c''est un parallélogramme, sinon j''indique ce qui ne va pas.'
]

{ #category : #private }
DrGeoScriptParallelogram class >> newArgumentsType [
	^{DrGPolygonItem}
]

{ #category : #public }
DrGeoScriptParallelogram class >> scriptName [
	^'Est parallélogramme ?'
]

{ #category : #public }
DrGeoScriptParallelogram >> compute [
	self paintRed.
	^ self isParallelogram
		ifTrue: [ 
			self paintBlue.
			'Bravo ! Je suis un parallélogramme.' ]
		ifFalse: [  | message |
			message := ReadWriteStream on: String new.
			message << 'Voyons, je ne suis pas un parallélogramme car :'.
			self isQuad 
				ifFalse: [ message crtab << '- je n''ai pas 4 sommets']
				ifTrue: [ 
					self isOppositeSideIsometric ifFalse: [message crtab << '- mes côtés opposés ne sont pas isométriques'].
					self isOppositeSideParallel ifFalse: [ message crtab << '- mes côtés opposés ne sont pas parallèles' ]].
				message contents]

]

{ #category : #public }
DrGeoScriptParallelogram >> isOppositeSideIsometric [
	| side1 side2 side3 side4 points|
	points := self arg1 points.
	side1 := points first - points second.
	side2 := points second - points third.
	side3 := points third - points fourth.
	side4 := points fourth - points first.

	^ side1 r = side3 r and: [side2 r = side4 r]  

]

{ #category : #public }
DrGeoScriptParallelogram >> isOppositeSideParallel [
	| side1 side2 side3 side4 points|
	points := self arg1 points.
	side1 := points first - points second.
	side2 := points second - points third.
	side3 := points third - points fourth.
	side4 := points fourth - points first.

	^ ((side1 crossProduct: side3) closeTo: 0)  and: [(side2 crossProduct: side4) closeTo: 0]  

]

{ #category : #public }
DrGeoScriptParallelogram >> isParallelogram [
	|   points mid1 mid2|
	points := self arg1 points.
	mid1 := points first + points third / 2.
	mid2 := points second + points fourth / 2.
	^ self isQuad and: [mid1 = mid2]

]

{ #category : #public }
DrGeoScriptParallelogram >> isQuad [
	^ self arg1 points size = 4
]

{ #category : #public }
DrGeoScriptParallelogram >> paintBlue [
	self costume1 style color: Color blue
]

{ #category : #public }
DrGeoScriptParallelogram >> paintRed [
	self costume1 style color: Color red
]
