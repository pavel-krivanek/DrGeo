Class {
	#name : #DrGeoNode,
	#superclass : #MorphTreeNodeModel,
	#category : #DrGeoII-Core-UI
}

{ #category : #accessing }
DrGeoNode >> childNodeClassFromItem: anItem [
	^ DrGeoAttributeNode
]

{ #category : #accessing }
DrGeoNode >> childrenItems [
	| children |
	children := OrderedCollection with: self item nodeType.
	self item parents isEmptyOrNil ifFalse: [children addAll: self item parents].
	^ children 
]
