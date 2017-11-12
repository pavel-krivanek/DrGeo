Class {
	#name : #DrGLocusRotationItem,
	#superclass : #DrGLocusTranslationItem,
	#category : #DrGeoII-Core-Item
}

{ #category : #'xml writing' }
DrGLocusRotationItem >> nodeType [
	^#Rotation
]

{ #category : #updating }
DrGLocusRotationItem >> update [
	self doParentsExist ifTrue: [| locusPoints center angle|
		center := parents second point.
		angle := parents third valueItem.
		locusPoints := parents first points.
		sampleNumber := parents first samples.
		p := Array new: sampleNumber.
		1 to: sampleNumber do: [:i |
			p at: i put: ((locusPoints at: i) rotateBy: angle about: center)]]
]
