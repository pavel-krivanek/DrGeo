Class {
	#name : #DrGPolygonCostume,
	#superclass : #DrGCurveCostume,
	#category : #DrGeoII-Core-Item-View
}

{ #category : #testing }
DrGPolygonCostume >> basicType [
	^#polygon
]

{ #category : #layout }
DrGPolygonCostume >> constraintTextPosition: aPoint [
|center vector answer|
	answer := mathItem closestPointInfoTo: (drawable morphToWorld: aPoint).
	center := answer first.
	anchorAbscissa := answer second.
	center := drawable worldToMorph: center.
	vector := aPoint - center.
	^textPositionDelta := self computeTextPositionDelta: vector.

]

{ #category : #initialize-release }
DrGPolygonCostume >> instantiateMorph [
	morph := DrGPolygoneMorph new.
]

{ #category : #testing }
DrGPolygonCostume >> isCurveCostume [
	^ true
]

{ #category : #updating }
DrGPolygonCostume >> redraw [
	| vertices |
	super redraw 
		ifFalse: [^ self].
	vertices := OrderedCollection new.
	mathItem points do: [:point | 
		vertices add: (drawable worldToMorph: point)].
	morph setVertices: vertices
]

{ #category : #style }
DrGPolygonCostume >> styleClass [
	^DrGPolygonCostumeStyle 
]
