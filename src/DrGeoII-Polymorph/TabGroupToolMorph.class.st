"
I am tab group to host tools populated in tabs. Each tools is a button, covered in several lines.
"
Class {
	#name : #TabGroupToolMorph,
	#superclass : #TabGroupMorph,
	#category : #DrGeoII-Polymorph
}

{ #category : #'as yet unclassified' }
TabGroupToolMorph >> addPage: aMorph label: aStringOrMorph [
	"Add a page and its tab."
	aMorph
		hResizing: #spaceFill;
		vResizing: #shrinkWrap.
	self pages add: aMorph.
	self tabSelectorMorph addTab: aStringOrMorph.
	aMorph submorphsDo: [:aButton |
		aButton model when: #selectedToolFromTab send: #hideTools to: self]
]

{ #category : #'as yet unclassified' }
TabGroupToolMorph >> hideTools [
	self contentMorph hide.
]

{ #category : #'as yet unclassified' }
TabGroupToolMorph >> layoutChanged [
	super layoutChanged.
	self comeToFront.
	self pageMorph
		ifNotNil:
			[ :pm | self owner ifNotNil: [ pm width: (pm width min: self owner width) ] ]
]

{ #category : #'as yet unclassified' }
TabGroupToolMorph >> minExtent [
	"Calculate the min extent of the receiver based only on the tabSelector."
	^ self tabSelectorMorph minExtent
]

{ #category : #'as yet unclassified' }
TabGroupToolMorph >> newTabSelectorMorph [
	"Answer a new tab selector morph"

	^TabToolSelectorMorph new
		vResizing: #shrinkWrap;
		hResizing: #spaceFill
]

{ #category : #updating }
TabGroupToolMorph >> update: aSymbol with: oldIndex [
	"Handle tab changes."
	aSymbol == #selectedIndex
		ifTrue: [self updatePageIndex: self selectedPageIndex oldIndex: oldIndex]
]

{ #category : #'as yet unclassified' }
TabGroupToolMorph >> updatePageIndex: index [
	"Change to the given page index."

	self pageMorph ifNotNil: [:p | self contentMorph removeMorph: p].
	index > 0 ifTrue: [self contentMorph addMorph: (self pages at: index)].
	self pageMorph ifNotNil: [:pm | 
		self owner ifNotNil: 
			[pm width: (pm width min: self owner width).
			pm layoutChanged]].
	self adoptPaneColor: self paneColor
]

{ #category : #'as yet unclassified' }
TabGroupToolMorph >> updatePageIndex: index oldIndex: oldIndex [
	index == oldIndex
		ifTrue:  [self contentMorph toggleVisible]
		ifFalse: [self contentMorph show].
	self updatePageIndex: index.
]
