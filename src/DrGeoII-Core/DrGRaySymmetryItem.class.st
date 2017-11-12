Class {
	#name : #DrGRaySymmetryItem,
	#superclass : #DrGRayItem,
	#category : #DrGeoII-Core-Item
}

{ #category : #updating }
DrGRaySymmetryItem >> moveParent: aPoint [
	^false
]

{ #category : #'xml writing' }
DrGRaySymmetryItem >> nodeType [
	^#Symmetry
]

{ #category : #updating }
DrGRaySymmetryItem >> update [
	self symmetryUpdate 
]
