Class {
	#name : #DrGRayCostume,
	#superclass : #DrGCurveCostume,
	#category : #DrGeoII-Core-Item-View
}

{ #category : #testing }
DrGRayCostume >> basicType [
	^#ray
]

{ #category : #initialize-release }
DrGRayCostume >> instantiateMorph [
	morph := DrGRayMorph new
]

{ #category : #updating }
DrGRayCostume >> redraw [
	super redraw 
		ifFalse: [^ self].
	morph
		from: (drawable worldToMorph: mathItem origin)
		direction: (drawable vectorToMorph: mathItem direction)
]

{ #category : #style }
DrGRayCostume >> styleClass [
	^DrGRayCostumeStyle
]
