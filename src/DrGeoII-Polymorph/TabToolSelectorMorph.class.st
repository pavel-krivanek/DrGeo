Class {
	#name : #TabToolSelectorMorph,
	#superclass : #TabSelectorMorph,
	#category : #DrGeoII-Polymorph
}

{ #category : #accessing }
TabToolSelectorMorph >> selectedIndex: index [
	
	"Set the value of selectedIndex"

	|oldIndex|
	oldIndex := selectedIndex.
	selectedIndex == index ifTrue: [	^ self changed: #selectedIndex with: oldIndex].
	selectedIndex := (index min: self tabs size).
	self visibleTabRange first > index
		ifTrue: [self visibleTabRange: ((index max: 1) to: 0)]
		ifFalse: [self visibleTabRange last < index
				ifTrue: [self visibleTabRange: (0 to: index)]].
	self updateTabs.
	self changed: #selectedIndex with: oldIndex
]
