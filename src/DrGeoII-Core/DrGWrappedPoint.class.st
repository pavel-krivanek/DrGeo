Class {
	#name : #DrGWrappedPoint,
	#superclass : #DrGWrappedItem,
	#category : #DrGeoII-Core-Script
}

{ #category : #accessing }
DrGWrappedPoint >> coordinates [
	^ self mathItem point
]

{ #category : #updating }
DrGWrappedPoint >> cross [
	costume style shape: #cross
]

{ #category : #updating }
DrGWrappedPoint >> large [
	costume style pointSize: #large
]

{ #category : #updating }
DrGWrappedPoint >> medium [
	costume style pointSize: #medium
]

{ #category : #updating }
DrGWrappedPoint >> moveTo: aPoint [
	self mathItem moveTo: aPoint    
]

{ #category : #updating }
DrGWrappedPoint >> round [
	costume style shape: #round
]

{ #category : #updating }
DrGWrappedPoint >> small [
	costume style pointSize: #small
]

{ #category : #updating }
DrGWrappedPoint >> square [
	costume style shape: #square
]
