Class {
	#name : #DrGLocusSymmetryItem,
	#superclass : #DrGLocusTranslationItem,
	#category : #DrGeoII-Core-Item
}

{ #category : #'xml writing' }
DrGLocusSymmetryItem >> nodeType [
	^#Symmetry
]

{ #category : #updating }
DrGLocusSymmetryItem >> update [
	self doParentsExist ifTrue: [| locusPoints center|
		center := parents second point.
		locusPoints := parents first points.
		sampleNumber := parents first samples.
		p := Array new: sampleNumber.
		1 to: sampleNumber do: [:i |
			p at: i put: 2 * center - (locusPoints at: i)]]
]
