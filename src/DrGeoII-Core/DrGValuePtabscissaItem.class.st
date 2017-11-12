Class {
	#name : #DrGValuePtabscissaItem,
	#superclass : #DrGComputedValueItem,
	#category : #DrGeoII-Core-Item
}

{ #category : #private }
DrGValuePtabscissaItem >> adaptiveDescriptiveName [
	^ 'This point abscissa %1' translated
]

{ #category : #'xml writing' }
DrGValuePtabscissaItem >> nodeType [ 
	^#'pt_abscissa'
]

{ #category : #updating }
DrGValuePtabscissaItem >> update [
	self doParentsExist ifTrue: [
		value := parents first point x]
]
