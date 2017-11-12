Class {
	#name : #DrGAngleItem,
	#superclass : #DrGValueItem,
	#instVars : [
		'radianValue',
		'degreeValue'
	],
	#category : #DrGeoII-Core-Item
}

{ #category : #accessing }
DrGAngleItem >> basicType [
	^#angle
]

{ #category : #accessing }
DrGAngleItem >> costumeClass [ 
	^ DrGAngleCostume
]

{ #category : #accessing }
DrGAngleItem >> degreeAngle [
"return the angle in degree"
	^degreeValue 
]

{ #category : #'*DrGeoII-Core-testing' }
DrGAngleItem >> isAngleItem [
	^true
]

{ #category : #'as yet unclassified' }
DrGAngleItem >> printOn: aStream [
	self printType: DrGAngleBuilder title on: aStream.
	aStream nextPut: Character space.
	self printInteger: self degreeAngle on: aStream.
	aStream nextPutAll: '°'.
]

{ #category : #accessing }
DrGAngleItem >> radianAngle [
"return the angle in radian"
	^radianValue 
]
