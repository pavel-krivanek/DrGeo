Class {
	#name : #DrGRayTranslationItem,
	#superclass : #DrGRayItem,
	#category : #DrGeoII-Core-Item
}

{ #category : #updating }
DrGRayTranslationItem >> moveParent: aPoint [
	^false
]

{ #category : #'xml writing' }
DrGRayTranslationItem >> nodeType [
	^#Translation
]

{ #category : #updating }
DrGRayTranslationItem >> update [
	self translationUpdate 
]
