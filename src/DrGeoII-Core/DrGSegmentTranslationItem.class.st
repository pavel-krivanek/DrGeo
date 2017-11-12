Class {
	#name : #DrGSegmentTranslationItem,
	#superclass : #DrGSegmentItem,
	#category : #DrGeoII-Core-Item
}

{ #category : #updating }
DrGSegmentTranslationItem >> moveParent: aPoint [
	^false
]

{ #category : #'xml writing' }
DrGSegmentTranslationItem >> nodeType [
	^#Translation
]

{ #category : #updating }
DrGSegmentTranslationItem >> update [
	self translationUpdate 
]
