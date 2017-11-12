Extension { #name : #DrGeoWindow }

{ #category : #'*DrGeoII-Polymorph-Widgets' }
DrGeoWindow >> newTabGroupTool: labelsAndPages [
"Answer tab grouped tools with a the given tab labels associated with pages of tools"
	^(TabGroupToolMorph new
		font: self theme labelFont;
		cornerStyle: (self theme tabGroupCornerStyleIn: self);
		hResizing: #spaceFill;
		vResizing: #spaceFill;
		labelsAndPages: labelsAndPages)
		selectedPageIndex: (labelsAndPages isEmpty ifTrue: [0] ifFalse: [1])
]

{ #category : #'*DrGeoII-Polymorph-Widgets' }
DrGeoWindow >> newTable: controls [
"Answer a morph laid out with a table of controls, in row and wrapped in column."
	|answer|
	answer := PanelMorph new
		changeTableLayout;
		cellInset: 2;
		listDirection: #leftToRight;
		wrapDirection: #topToBottom;
		hResizing: #spaceFill;
		vResizing: #shrinkWrap;
		fillStyle: Color transparent; "non pane color tracking"
		cellPositioning: #topLeft.
	controls do: [:m | answer addMorphBack: m].
	^answer
			
]

{ #category : #'*DrGeoII-Polymorph-Widgets' }
DrGeoWindow >> openModal: aSystemWindow [
	DrGDefault ifTablet: [
		aSystemWindow 
			extent: aSystemWindow initialExtent;
			topCentered;
			activate].
	^ super openModal: aSystemWindow.
]
