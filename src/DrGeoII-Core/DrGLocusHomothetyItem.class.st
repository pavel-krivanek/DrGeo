Class {
	#name : #DrGLocusHomothetyItem,
	#superclass : #DrGLocusTranslationItem,
	#category : #DrGeoII-Core-Item
}

{ #category : #'xml writing' }
DrGLocusHomothetyItem >> nodeType [
	^#Scale
]

{ #category : #updating }
DrGLocusHomothetyItem >> update [
	self doParentsExist ifTrue: [| locusPoints center factor|
		center := parents second point.
		factor := parents third valueItem.
		locusPoints := parents first points.
		sampleNumber := parents first samples.
		p := Array new: sampleNumber.
		1 to: sampleNumber do: [:i |
			p at: i put: center + (factor * ((locusPoints at: i) - center))]]
]
