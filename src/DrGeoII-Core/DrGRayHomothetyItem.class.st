Class {
	#name : #DrGRayHomothetyItem,
	#superclass : #DrGRayItem,
	#category : #DrGeoII-Core-Item
}

{ #category : #updating }
DrGRayHomothetyItem >> moveParent: aPoint [
	^false
]

{ #category : #'xml writing' }
DrGRayHomothetyItem >> nodeType [
	^#Scale
]

{ #category : #updating }
DrGRayHomothetyItem >> update [
	self homothetyUpdate
]
