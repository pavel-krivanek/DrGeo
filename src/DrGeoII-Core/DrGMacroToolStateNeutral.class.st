"
When user switch to info pages (info and description pages), we unselect all selected costumes. In this state the user can't select any items.
"
Class {
	#name : #DrGMacroToolStateNeutral,
	#superclass : #DrGDynamicToolState,
	#category : #DrGeoII-Core-Tool
}

{ #category : #accessing }
DrGMacroToolStateNeutral >> context: aContext [
	super context: aContext.
	self context selectNoCostume
]

{ #category : #'as yet unclassified' }
DrGMacroToolStateNeutral >> handleMouseAt: aPoint [
	^false
]
