Extension { #name : #TEasilyThemed }

{ #category : #'*DrGeoII-Polymorph-controls' }
TEasilyThemed >> newToolbarDropListFor: aModel list: listSel getSelected: getSel setSelected: setSel getEnabled: enabledSel help: helpText [
	"Answer a toolbar drop list for the given model."

	^self 
		newToolbarDropListFor: aModel
		list: listSel
		getSelected: getSel
		setSelected: setSel
		getEnabled: enabledSel
		useIndex: true
		help: helpText
]

{ #category : #'*DrGeoII-Polymorph-controls' }
TEasilyThemed >> newToolbarDropListFor: aModel list: listSel getSelected: getSel setSelected: setSel getEnabled: enabledSel useIndex: useIndex help: helpText [
	"Answer a toolbar drop list for the given model."

	^self theme
		newToolbarDropListIn: self
		for: aModel
		list: listSel
		getSelected: getSel
		setSelected: setSel
		getEnabled: enabledSel
		useIndex: useIndex
		help: helpText
]

{ #category : #'*DrGeoII-Polymorph-controls' }
TEasilyThemed >> newToolbarDropListFor: aModel list: listSel getSelected: getSel setSelected: setSel help: helpText [
	"Answer a toolbar drop list for the given model."

	^self 
		newToolbarDropListFor: aModel
		list: listSel
		getSelected: getSel
		setSelected: setSel
		getEnabled: nil
		useIndex: true
		help: helpText
]
