Class {
	#name : #DrGArcCostume,
	#superclass : #DrGCurveCostume,
	#category : #DrGeoII-Core-Item-View
}

{ #category : #testing }
DrGArcCostume >> basicType [
	^#arc
]

{ #category : #accessing }
DrGArcCostume >> borderColor: aColor [
	morph borderColor: (aColor alpha: 1)
]

{ #category : #initialize-release }
DrGArcCostume >> instantiateMorph [
	morph := DrGArcMorph new
]

{ #category : #updating }
DrGArcCostume >> redraw [
	super redraw ifFalse: [^ self].
	mathItem center
		ifNil: [morph class = DrGSegmentMorph
				ifTrue: [self redrawAsSegmentOrRay]
			"mutate the morph to DrGSegment and draw it"]
		ifNotNil: [morph class = DrGArcMorph
				ifTrue: [self redrawAsArc]
			"mutate the morph to an DrGArcMorph and draw it"]
]

{ #category : #updating }
DrGArcCostume >> redrawAsArc [
	morph 
		center: (drawable worldToMorph: mathItem center)
		radius: (drawable worldToPixel: mathItem radius)
		origin: mathItem origin negated
		length: mathItem length negated

]

{ #category : #updating }
DrGArcCostume >> redrawAsSegmentOrRay [
]

{ #category : #style }
DrGArcCostume >> styleClass [
	^DrGArcCostumeStyle
]
