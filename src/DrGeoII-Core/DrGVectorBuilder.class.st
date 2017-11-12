Class {
	#name : #DrGVectorBuilder,
	#superclass : #DrGSegmentBuilder,
	#category : #DrGeoII-Core-Builder
}

{ #category : #documentation }
DrGVectorBuilder class >> description [ 
	^'Vector defined by two points.' translated
]

{ #category : #documentation }
DrGVectorBuilder class >> title [
	^'Vector' translated 
]

{ #category : #'flying costume' }
DrGVectorBuilder >> flyingCostumeClass [
	^ DrGVectorCostume
]

{ #category : #constant }
DrGVectorBuilder >> mathItemClass [
	^DrGVector2ptsItem
]
