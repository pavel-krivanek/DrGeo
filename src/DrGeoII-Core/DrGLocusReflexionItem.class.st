Class {
	#name : #DrGLocusReflexionItem,
	#superclass : #DrGLocusTranslationItem,
	#category : #DrGeoII-Core-Item
}

{ #category : #'xml writing' }
DrGLocusReflexionItem >> nodeType [
	^#Reflexion
]

{ #category : #updating }
DrGLocusReflexionItem >> update [
	self doParentsExist ifTrue: [| locusPoints axe|
		axe := parents second.
		locusPoints := parents first points.
		sampleNumber := parents first samples.
		p := Array new: sampleNumber.
		1 to: sampleNumber do: [:i |
			p at: i put: ((locusPoints at: i) reflexionBy: axe origin direction: axe direction)]]
]
