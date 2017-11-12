Class {
	#name : #DrGSegmentRotationItem,
	#superclass : #DrGSegmentItem,
	#category : #DrGeoII-Core-Item
}

{ #category : #updating }
DrGSegmentRotationItem >> moveParent: aPoint [
	^false
]

{ #category : #'xml writing' }
DrGSegmentRotationItem >> nodeType [
	^#Rotation
]

{ #category : #updating }
DrGSegmentRotationItem >> update [
	self rotationUpdate 
]
