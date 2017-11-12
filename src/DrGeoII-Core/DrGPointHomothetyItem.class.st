Class {
	#name : #DrGPointHomothetyItem,
	#superclass : #DrGPointItem,
	#category : #DrGeoII-Core-Item
}

{ #category : #'*DrGeoII-Core-testing' }
DrGPointHomothetyItem >> isConstrainedPointItem [
	^true
]

{ #category : #'xml writing' }
DrGPointHomothetyItem >> nodeType [
	^#Scale
]

{ #category : #updating }
DrGPointHomothetyItem >> update [
|center|
	self doParentsExist ifTrue:
		[center := parents second point.
		point := center + 
			(parents third valueItem * (parents first point - center))].
]
