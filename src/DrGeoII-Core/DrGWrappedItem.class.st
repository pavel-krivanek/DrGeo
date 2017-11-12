"
A class to encapsulate costume for user friendly use when doing Smalltalk figure
"
Class {
	#name : #DrGWrappedItem,
	#superclass : #Object,
	#instVars : [
		'costume'
	],
	#category : #DrGeoII-Core-Script
}

{ #category : #'as yet unclassified' }
DrGWrappedItem class >> wrap: aCostume [ 
	^ self new costume: aCostume
]

{ #category : #updating }
DrGWrappedItem >> color: aColor [
	costume style color: aColor
]

{ #category : #accessing }
DrGWrappedItem >> costume: aCostume [
	costume := aCostume 
]

{ #category : #updating }
DrGWrappedItem >> hide [
	costume style hidden: true.
	costume forceVisible: false.
]

{ #category : #updating }
DrGWrappedItem >> lock [
	costume locked: true
]

{ #category : #accessing }
DrGWrappedItem >> mathItem [
	^ costume mathItem 
]

{ #category : #updating }
DrGWrappedItem >> moveTo: aPoint [
]

{ #category : #updating }
DrGWrappedItem >> name: aString [
	costume  textMorph: aString asString
]

{ #category : #updating }
DrGWrappedItem >> rename: anObject [
	costume textMorph contents:  anObject asString 
]

{ #category : #updating }
DrGWrappedItem >> show [
	costume forceVisible: true.
	costume style hidden: false
]

{ #category : #accessing }
DrGWrappedItem >> style [
	^ costume style
]

{ #category : #updating }
DrGWrappedItem >> unhide [
	costume style hidden: false.
	costume forceVisible: false.
]

{ #category : #updating }
DrGWrappedItem >> unlock [
	costume locked: false
]
