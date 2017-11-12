Class {
	#name : #DrGLineReflexionItem,
	#superclass : #DrGLineItem,
	#category : #DrGeoII-Core-Item
}

{ #category : #updating }
DrGLineReflexionItem >> moveParent: aPoint [
	^false
]

{ #category : #'xml writing' }
DrGLineReflexionItem >> nodeType [
	^#Reflexion
]

{ #category : #updating }
DrGLineReflexionItem >> update [
	self reflexionUpdate
]
