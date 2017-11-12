Class {
	#name : #DrGLineHomothetyItem,
	#superclass : #DrGLineItem,
	#category : #DrGeoII-Core-Item
}

{ #category : #updating }
DrGLineHomothetyItem >> moveParent: aPoint [
	^false
]

{ #category : #'xml writing' }
DrGLineHomothetyItem >> nodeType [
	^#Scale
]

{ #category : #updating }
DrGLineHomothetyItem >> update [
	self homothetyUpdate 
]
