Class {
	#name : #DrGLocusCostume,
	#superclass : #DrGCurveCostume,
	#category : #DrGeoII-Core-Item-View
}

{ #category : #testing }
DrGLocusCostume >> basicType [
	^ #locus
]

{ #category : #'as yet unclassified' }
DrGLocusCostume >> exist: aBoolean [
	super exist: aBoolean.
	exist ifTrue: [self updateToVisible] ifFalse: [self updateToInvisible]
	
]

{ #category : #initialize-release }
DrGLocusCostume >> instantiateMorph [
	morph := DrGLocusMorph new.
	morph color: Color red.
	morph borderColor: Color orange.
	morph width: 2
]

{ #category : #updating }
DrGLocusCostume >> redraw [
	morph free: mathItem freePoint constrained: mathItem constrainedPoint.
	super redraw ifFalse: [^ self].

]

{ #category : #style }
DrGLocusCostume >> styleClass [
	^ DrGLocusCostumeStyle
]
