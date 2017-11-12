"
A tool to edit the property of some object like free point, free point on curve,  free value and script
"
Class {
	#name : #DrGPropertyTool,
	#superclass : #DrGSelectTool,
	#category : #DrGeoII-Core-Tool
}

{ #category : #documentation }
DrGPropertyTool class >> description [
	^ 'Edit an item''s property' translated
]

{ #category : #documentation }
DrGPropertyTool class >> title [
	^ 'Property' translated
]

{ #category : #'as yet unclassified' }
DrGPropertyTool >> costume: aCostume [
	costume ifNotNil: [
		costume stopBlinking.
		costume releasePropertyWidget].
	costume := aCostume.
	costume ifNotNil: [costume startBlinking]
	
]

{ #category : #testing }
DrGPropertyTool >> isWanted: aMathItemCollection [
" only items whose property are editable "
	^ aMathItemCollection first isPropertyEditable
]

{ #category : #'as yet unclassified' }
DrGPropertyTool >> presenter: aPresenter [
	super presenter: aPresenter.
	self app forceVisible: false.
]

{ #category : #updating }
DrGPropertyTool >> reset [
	super reset.
	self switchState: DrGPropertyToolState
]
