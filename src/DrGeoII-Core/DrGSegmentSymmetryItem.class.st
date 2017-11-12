Class {
	#name : #DrGSegmentSymmetryItem,
	#superclass : #DrGSegmentItem,
	#category : #DrGeoII-Core-Item
}

{ #category : #updating }
DrGSegmentSymmetryItem >> moveParent: aPoint [
	^false
]

{ #category : #'xml writing' }
DrGSegmentSymmetryItem >> nodeType [
	^#Symmetry
]

{ #category : #updating }
DrGSegmentSymmetryItem >> update [
	self symmetryUpdate 
]
