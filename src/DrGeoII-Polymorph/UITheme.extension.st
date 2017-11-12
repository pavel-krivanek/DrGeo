Extension { #name : #UITheme }

{ #category : #'*DrGeoII-Polymorph-morph creation' }
UITheme >> newToolbarDropListIn: aThemedMorph for: aModel list: listSel getSelected: getSel setSelected: setSel getEnabled: enabledSel help: helpText [
	"Answer a toolbar drop list for the given model."

	^self
		newToolbarDropListIn: aThemedMorph
		for: aModel
		list: listSel
		getSelected: getSel
		setSelected: setSel
		getEnabled: enabledSel
		useIndex: true
		help: helpText
]

{ #category : #'*DrGeoII-Polymorph-morph creation' }
UITheme >> newToolbarDropListIn: aThemedMorph for: aModel list: listSel getSelected: getSel setSelected: setSel getEnabled: enabledSel useIndex: useIndex help: helpText [
	"Answer a toolbar drop list for the given model."

	^(ToolbarDropListMorph
			on: aModel
			list: listSel
			selected: getSel
			changeSelected: setSel
			useIndex: useIndex)
		selectionColor: self selectionColor;
		getEnabledSelector: enabledSel;
		cornerStyle: aThemedMorph preferredCornerStyle;
		hResizing: #spaceFill;
		vResizing: #shrinkWrap;
		setBalloonText: helpText
]
