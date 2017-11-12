Class {
	#name : #DrGValueDistance2ptsItem,
	#superclass : #DrGComputedValueItem,
	#category : #DrGeoII-Core-Item
}

{ #category : #private }
DrGValueDistance2ptsItem >> adaptiveDescriptiveName [
	^ 'This distance between two points %1' translated
]

{ #category : #'xml writing' }
DrGValueDistance2ptsItem >> nodeType [
	^#'distance_2pts'
]

{ #category : #updating }
DrGValueDistance2ptsItem >> update [
	self doParentsExist ifTrue:
		[value := parents first point dist: parents second point].

]
