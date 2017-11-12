Class {
	#name : #DrGComputedValueItem,
	#superclass : #DrGValueItem,
	#category : #DrGeoII-Core-Item
}

{ #category : #'xml writing' }
DrGComputedValueItem >> writeAsXmlTo: aNode [ 
	"return the newly created element"
	| node |
	node := super writeAsXmlTo: aNode.
	^ self writeAsXmlPositionTo: node.
]
