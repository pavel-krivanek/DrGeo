Class {
	#name : #DrGSegmentHomothetyItem,
	#superclass : #DrGSegmentItem,
	#category : #DrGeoII-Core-Item
}

{ #category : #updating }
DrGSegmentHomothetyItem >> moveParent: aPoint [
	^false
]

{ #category : #'xml writing' }
DrGSegmentHomothetyItem >> nodeType [
	^#Scale
]

{ #category : #updating }
DrGSegmentHomothetyItem >> update [
	self homothetyUpdate 
]
