Class {
	#name : #DrGLineBuilder,
	#superclass : #DrGSegmentBuilder,
	#category : #DrGeoII-Core-Builder
}

{ #category : #documentation }
DrGLineBuilder class >> description [ 
	^ 'Line defined by two points' translated
]

{ #category : #documentation }
DrGLineBuilder class >> title [
	^ 'Line' translated
]

{ #category : #'flying costume' }
DrGLineBuilder >> flyingCostumeClass [
	^ DrGLineCostume
]

{ #category : #constant }
DrGLineBuilder >> mathItemClass [
	^DrGLine2ptsItem
]
