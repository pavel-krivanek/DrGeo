Class {
	#name : #ToolbarDropListMorph,
	#superclass : #MorphDropListMorph,
	#category : #DrGeoII-Polymorph
}

{ #category : #'list management' }
ToolbarDropListMorph >> hideList [
	^ self hideListSilently 
]

{ #category : #'list management' }
ToolbarDropListMorph >> hideListSilently [
	"Hide the list without any update notificiation. "
	self listMorph ifNil: [^self].
	self listVisible ifFalse: [^self].
	self listMorph delete.
	self roundedCorners: #(1 2 3 4).
	(self buttonMorph ifNil: [^self]) roundedCorners: (self roundedCorners copyWithoutAll: #(1 2)).
	self changed.
	self wantsKeyboardFocus
		ifTrue: [self takeKeyboardFocus]
]

{ #category : #accessing }
ToolbarDropListMorph >> list: aCollection [
	"Set the list contents."
	| maxExtent |
	maxExtent := 0@0.
	list := aCollection.
	list do: [:aMorph | aMorph lock.
		maxExtent := maxExtent max: aMorph extent].
	self contentMorph;
		minWidth: maxExtent x;
		minHeight: maxExtent y.
	self changed: #list.
	self listSelectionIndex: 1
]

{ #category : #accessing }
ToolbarDropListMorph >> listHeight [
	"Answer the height for the list."
	^self listMorph listMorph height + 19
]

{ #category : #'list management' }
ToolbarDropListMorph >> listMorphClass [
	"Answer the class for a new list morph"

	^PluggableToolbarMorph
]

{ #category : #'list management' }
ToolbarDropListMorph >> listMouseDown: evt [
	"Click outside the list."

	(self listMorph fullContainsPoint: evt position)
		ifTrue: [self listMorph selectionIndex: (self listMorph rowAtLocation: evt position)]
		ifFalse: [self hideListSilently]
]

{ #category : #initialize-release }
ToolbarDropListMorph >> listSelectionIndexSilently: anInteger [
	"Set the list selection."
	self hideList.
	anInteger = 0 ifTrue: [^self].
	listSelectionIndex := anInteger.
	self
		changed: #listSelectionIndex;
		updateContentsGraphic;
		triggerEvent: #selectionIndex with: anInteger.
	self model ifNotNil: [:m | 
		self setIndexSelector ifNotNil: [:s |
			self useSelectionIndex
				ifTrue: [m perform: s with: anInteger]
				ifFalse: [m perform: s with: self selectedItem]]]
]

{ #category : #initialize-release }
ToolbarDropListMorph >> listSilently: aCollection [
	"Set the list contents."
	| maxExtent |
	maxExtent := 0@0.
	list := aCollection.
	list do: [:aMorph | aMorph lock.
		maxExtent := maxExtent max: aMorph extent].
	self contentMorph;
		minWidth: maxExtent x;
		minHeight: maxExtent y.
	self changed: #list.
	self listSelectionIndexSilently: 1.
]

{ #category : #'user interface' }
ToolbarDropListMorph >> newContentMorph [
	 "answer a new content morph"
	^Morph new
		changeTableLayout;
		listDirection: #leftToRight;
		wrapCentering: #center;
		vResizing: #spaceFill;
		hResizing: #spaceFill;
		layoutInset: 0;
		color: Color transparent;
		borderWidth: 0;
		clipSubmorphs: true
]

{ #category : #initialize-release }
ToolbarDropListMorph >> on: anObject list: getListSel selected: getSelectionSel changeSelected: setSelectionSel [
	"Set the receiver to the given model parameterized by the given message selectors."

	getListSel isSymbol
		ifTrue: [self  getListSelector: getListSel]
		ifFalse: [self list: getListSel]. "allow direct list"
	self
		model: anObject;
		getIndexSelector: getSelectionSel;
		setIndexSelector: setSelectionSel;
		updateListSilently;
		updateListSelectionIndex;
		updateContentsGraphic 
]

{ #category : #initialize-release }
ToolbarDropListMorph >> showListAfterLongClick [
	self contentMorph firstSubmorph
		showSelectionFeedback: false;
		changed.
	self showList.

	
]

{ #category : #initialize-release }
ToolbarDropListMorph >> updateContents [
	"Update the contents (graphic + execute callback)."

	|item| 
	item := self updateContentsGraphic.
	item ifNotNil: [item performAction]
]

{ #category : #initialize-release }
ToolbarDropListMorph >> updateContentsGraphic [
	"Update the graphic contents."
	^ self updateContentsGraphic: self listSelectionIndex
]

{ #category : #initialize-release }
ToolbarDropListMorph >> updateContentsGraphic: integer [
	"Update the graphic contents with the integer nth element of the list."

	|item| 
	self contentMorph removeAllMorphs.
	^ integer > 0
		ifTrue: [
			item := (self list at: integer) copy unlock;
				hResizing: #spaceFill;
				vResizing: #spaceFill.
			self contentMorph
				addMorph: item.
			item on: #mouseStillDown send: #showListAfterLongClick to: self.
			item]
		ifFalse: [nil]
]

{ #category : #'as yet unclassified' }
ToolbarDropListMorph >> updateListSelectionIndex [
	"Update the list selection."

	|i|
	self useSelectionIndex
		ifTrue: [i := self getCurrentSelectionIndex.
				listSelectionIndex == i ifTrue: [^self].
				listSelectionIndex := i]
		ifFalse: [i := self getCurrentSelection.
				listSelectionIndex := i isNil
					ifTrue: [0]
					ifFalse: [self list indexOf: i]].
	self
		changed: #listSelectionIndex;
		updateContentsGraphic;
		triggerEvent: #selectionIndex with: i
]

{ #category : #initialize-release }
ToolbarDropListMorph >> updateListSilently [
	"Refresh the list."

	self getListSelector isSymbol ifTrue: [
		self listSilently: (self model perform: self getListSelector).
		listSelectionIndex := 0]
]
