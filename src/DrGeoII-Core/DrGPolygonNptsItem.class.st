Class {
	#name : #DrGPolygonNptsItem,
	#superclass : #DrGPolygonItem,
	#category : #DrGeoII-Core-Item
}

{ #category : #'xml writing' }
DrGPolygonNptsItem >> nodeType [
	^ #npts
]

{ #category : #comparing }
DrGPolygonNptsItem >> parentsEqual: aPolygon [
	|shiftedCollection|
	self parents size = aPolygon parents size ifFalse: [^false].
	shiftedCollection := self parents.
	shiftedCollection size timesRepeat: [
		shiftedCollection = aPolygon parents ifTrue: [^true].
		shiftedCollection := shiftedCollection shiftRight].
	shiftedCollection := self parents reverse.
	shiftedCollection size timesRepeat: [
		shiftedCollection = aPolygon parents ifTrue: [^true].
		shiftedCollection := shiftedCollection shiftRight].
	^ false
]

{ #category : #updating }
DrGPolygonNptsItem >> update [
	self doParentsExist ifTrue:
		[points := OrderedCollection new.
		parents do: [:pointItem |
			points add: pointItem point].
		self computeLength].

]
