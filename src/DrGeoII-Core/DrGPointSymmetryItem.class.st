Class {
	#name : #DrGPointSymmetryItem,
	#superclass : #DrGPointItem,
	#category : #DrGeoII-Core-Item
}

{ #category : #'*DrGeoII-Core-testing' }
DrGPointSymmetryItem >> isConstrainedPointItem [
	^true
]

{ #category : #'xml writing' }
DrGPointSymmetryItem >> nodeType [
	^#Symmetry
]

{ #category : #updating }
DrGPointSymmetryItem >> update [
	self doParentsExist ifTrue: 
		[self point: (2 * parents second point) - parents first point].

]
