Class {
	#name : #DrGLineTranslationItem,
	#superclass : #DrGLineItem,
	#category : #DrGeoII-Core-Item
}

{ #category : #updating }
DrGLineTranslationItem >> moveParent: aPoint [
	^false
]

{ #category : #'xml writing' }
DrGLineTranslationItem >> nodeType [
	^#Translation
]

{ #category : #updating }
DrGLineTranslationItem >> update [
	self translationUpdate
]
