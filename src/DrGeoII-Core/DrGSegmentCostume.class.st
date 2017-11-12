Class {
	#name : #DrGSegmentCostume,
	#superclass : #DrGCurveCostume,
	#category : #DrGeoII-Core-Item-View
}

{ #category : #testing }
DrGSegmentCostume >> basicType [
	^#segment
]

{ #category : #initialize-release }
DrGSegmentCostume >> instantiateMorph [
	morph := DrGSegmentMarkMorph new
]

{ #category : #updating }
DrGSegmentCostume >> redraw [
	super redraw 
		ifFalse: [^ self].
	morph
		from: (drawable worldToMorph: mathItem origin)
		to: (drawable worldToMorph: mathItem origin + mathItem direction)
]

{ #category : #style }
DrGSegmentCostume >> styleClass [
	^DrGSegmentCostumeStyle
]
