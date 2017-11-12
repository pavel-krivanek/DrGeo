"
A Costume for angle
"
Class {
	#name : #DrGAngleCostume,
	#superclass : #DrGValueCostume,
	#category : #DrGeoII-Core-Item-View
}

{ #category : #testing }
DrGAngleCostume >> basicType [
	^#angle
]

{ #category : #'as yet unclassified' }
DrGAngleCostume >> roundedValueString [
	^ mathItem degreeAngle rounded asString, '°'.
]

{ #category : #'as yet unclassified' }
DrGAngleCostume >> textMorph: string [
	"we don't have label"
	mathItem name: string
]
