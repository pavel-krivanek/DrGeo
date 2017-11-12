Class {
	#name : #DrGSegmentReflexionItem,
	#superclass : #DrGSegmentItem,
	#category : #DrGeoII-Core-Item
}

{ #category : #updating }
DrGSegmentReflexionItem >> moveParent: aPoint [
	^false
]

{ #category : #'xml writing' }
DrGSegmentReflexionItem >> nodeType [
	^#Reflexion
]

{ #category : #updating }
DrGSegmentReflexionItem >> update [
	self reflexionUpdate 
]
