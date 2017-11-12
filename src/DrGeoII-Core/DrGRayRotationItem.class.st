Class {
	#name : #DrGRayRotationItem,
	#superclass : #DrGRayItem,
	#category : #DrGeoII-Core-Item
}

{ #category : #updating }
DrGRayRotationItem >> moveParent: aPoint [
	^false
]

{ #category : #'xml writing' }
DrGRayRotationItem >> nodeType [
	^#Rotation
]

{ #category : #updating }
DrGRayRotationItem >> update [
	self rotationUpdate 
]
