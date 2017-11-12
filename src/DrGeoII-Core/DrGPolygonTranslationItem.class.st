Class {
	#name : #DrGPolygonTranslationItem,
	#superclass : #DrGPolygonItem,
	#category : #DrGeoII-Core-Item
}

{ #category : #updating }
DrGPolygonTranslationItem >> moveParent: aPoint [
	^false
]

{ #category : #'xml writing' }
DrGPolygonTranslationItem >> nodeType [
	^#Translation
]

{ #category : #updating }
DrGPolygonTranslationItem >> update [
|translation|
	self doParentsExist 	ifTrue:
		[translation := parents second direction.
		points := OrderedCollection new.
		parents first points do: [:point |
			points add: point + translation].
		self computeLength].

]
