Class {
	#name : #DrGLocusTranslationItem,
	#superclass : #DrGLocus2ptsItem,
	#category : #DrGeoII-Core-Item
}

{ #category : #accessing }
DrGLocusTranslationItem >> constrainedPoint [
	self shouldNotImplement 
]

{ #category : #accessing }
DrGLocusTranslationItem >> costumeClass [
	^ DrGLocusTransformedCostume 
]

{ #category : #accessing }
DrGLocusTranslationItem >> freePoint [
	self shouldNotImplement 
]

{ #category : #'xml writing' }
DrGLocusTranslationItem >> nodeType [
	^ #Translation
]

{ #category : #accessing }
DrGLocusTranslationItem >> points: aCollection [
	self shouldNotImplement 
]

{ #category : #accessing }
DrGLocusTranslationItem >> samples: anInteger [
	self shouldNotImplement 
]

{ #category : #updating }
DrGLocusTranslationItem >> update [
	self doParentsExist ifTrue: [| locusPoints direction|
		direction := parents second direction.
		locusPoints := parents first points.
		sampleNumber := parents first samples.
		p := Array new: sampleNumber.
		1 to: sampleNumber do: [:i |
			p at: i put: (locusPoints at: i) + direction]]
]
