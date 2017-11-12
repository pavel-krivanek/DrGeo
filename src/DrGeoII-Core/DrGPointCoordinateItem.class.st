Class {
	#name : #DrGPointCoordinateItem,
	#superclass : #DrGPointItem,
	#category : #DrGeoII-Core-Item
}

{ #category : #'*DrGeoII-Core-testing' }
DrGPointCoordinateItem >> isConstrainedPointItem [
	^true
]

{ #category : #'xml writing' }
DrGPointCoordinateItem >> nodeType [
	^#Coordinate
]

{ #category : #updating }
DrGPointCoordinateItem >> update [
	self doParentsExist ifTrue:
		[self point: parents first valueItem @ parents second valueItem]. 

]
