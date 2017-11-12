Class {
	#name : #DrGWrappedValue,
	#superclass : #DrGWrappedItem,
	#category : #DrGeoII-Core-Script
}

{ #category : #updating }
DrGWrappedValue >> moveTo: aPoint [
	self mathItem position: aPoint     
]

{ #category : #updating }
DrGWrappedValue >> name: aString [ 
	costume mathItem name: aString.
	costume redraw
]

{ #category : #updating }
DrGWrappedValue >> value: aNumber [
	(self mathItem respondsTo: #valueItem:) 
		ifTrue: [self mathItem valueItem: aNumber]
]
