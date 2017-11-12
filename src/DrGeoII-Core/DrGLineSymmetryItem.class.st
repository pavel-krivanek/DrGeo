Class {
	#name : #DrGLineSymmetryItem,
	#superclass : #DrGLineItem,
	#category : #DrGeoII-Core-Item
}

{ #category : #updating }
DrGLineSymmetryItem >> moveParent: aPoint [
	^false
]

{ #category : #'xml writing' }
DrGLineSymmetryItem >> nodeType [
	^#Symmetry
]

{ #category : #updating }
DrGLineSymmetryItem >> update [
	self symmetryUpdate 
]
