Class {
	#name : #DrGPointTranslationItem,
	#superclass : #DrGPointItem,
	#category : #DrGeoII-Core-Item
}

{ #category : #'*DrGeoII-Core-testing' }
DrGPointTranslationItem >> isConstrainedPointItem [
	^true
]

{ #category : #'xml writing' }
DrGPointTranslationItem >> nodeType [
	^#Translation
]

{ #category : #updating }
DrGPointTranslationItem >> update [
	self doParentsExist ifTrue:
		[self point: parents first point + parents second direction].

]
