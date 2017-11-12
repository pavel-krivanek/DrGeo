Class {
	#name : #DrGLocusTransformedCostume,
	#superclass : #DrGCurveCostume,
	#category : #DrGeoII-Core-Item-View
}

{ #category : #testing }
DrGLocusTransformedCostume >> basicType [
	^ #locus
]

{ #category : #initialize-release }
DrGLocusTransformedCostume >> instantiateMorph [
	morph := DrGLocusMorph new
]

{ #category : #updating }
DrGLocusTransformedCostume >> redraw [
	| vertices |
	super redraw ifFalse: [^ self].
	vertices := Array new: mathItem samples.
	mathItem points doWithIndex: [:point :i| 
		vertices at: i put: (drawable worldToMorph: point)].
	morph setVertices: vertices
]

{ #category : #style }
DrGLocusTransformedCostume >> styleClass [
	^ DrGLocusCostumeStyle
]
