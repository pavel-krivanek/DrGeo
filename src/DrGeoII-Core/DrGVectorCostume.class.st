Class {
	#name : #DrGVectorCostume,
	#superclass : #DrGSegmentCostume,
	#category : #DrGeoII-Core-Item-View
}

{ #category : #testing }
DrGVectorCostume >> basicType [
	^#vector
]

{ #category : #initialize-release }
DrGVectorCostume >> instantiateMorph [
	morph := DrGVectorMorph new
]

{ #category : #style }
DrGVectorCostume >> styleClass [
	^DrGVectorCostumeStyle
]
