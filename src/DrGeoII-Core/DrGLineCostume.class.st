Class {
	#name : #DrGLineCostume,
	#superclass : #DrGCurveCostume,
	#category : #DrGeoII-Core-Item-View
}

{ #category : #testing }
DrGLineCostume >> basicType [
	^#line
]

{ #category : #initialize-release }
DrGLineCostume >> instantiateMorph [
	morph := DrGLineMorph new
]

{ #category : #updating }
DrGLineCostume >> redraw [
	super redraw ifFalse: [^ self].
	morph
		from: (drawable worldToMorph: mathItem origin)
		direction: (drawable vectorToMorph: mathItem direction).
]

{ #category : #style }
DrGLineCostume >> styleClass [
	^DrGLineCostumeStyle
]
