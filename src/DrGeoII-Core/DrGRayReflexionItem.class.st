Class {
	#name : #DrGRayReflexionItem,
	#superclass : #DrGRayItem,
	#category : #DrGeoII-Core-Item
}

{ #category : #updating }
DrGRayReflexionItem >> moveParent: aPoint [
	^false
]

{ #category : #'xml writing' }
DrGRayReflexionItem >> nodeType [
	^#Reflexion
]

{ #category : #updating }
DrGRayReflexionItem >> update [
	self reflexionUpdate 
]
