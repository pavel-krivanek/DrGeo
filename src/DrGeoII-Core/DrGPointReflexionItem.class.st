Class {
	#name : #DrGPointReflexionItem,
	#superclass : #DrGPointItem,
	#category : #DrGeoII-Core-Item
}

{ #category : #'*DrGeoII-Core-testing' }
DrGPointReflexionItem >> isConstrainedPointItem [
	^true
]

{ #category : #'xml writing' }
DrGPointReflexionItem >> nodeType [
	^#Reflexion
]

{ #category : #updating }
DrGPointReflexionItem >> update [
	self doParentsExist	ifTrue:
		[self point: (parents first point
					reflexionBy: parents second origin 
					direction: parents second direction)].

]
