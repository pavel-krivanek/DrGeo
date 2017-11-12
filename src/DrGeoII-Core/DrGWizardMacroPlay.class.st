Class {
	#name : #DrGWizardMacroPlay,
	#superclass : #DrGWizard,
	#instVars : [
		'builder',
		'macroFactories'
	],
	#category : #DrGeoII-Core-UI
}

{ #category : #'instance creation' }
DrGWizardMacroPlay class >> builder: aBuilder [ 
	^ self basicNew
		builder: aBuilder;
		initialize 
]

{ #category : #accessing }
DrGWizardMacroPlay >> builder: aBuilder [
	builder := aBuilder
]

{ #category : #meta-actions }
DrGWizardMacroPlay >> delete [
	super delete.
	builder := nil.
]

{ #category : #initialization }
DrGWizardMacroPlay >> firstPage [
	^ (DrGWizardPage firstPage: 'Execute a macro-construction' translated) 
				model: self;
				content: 'To execute a macro-construction,

 1. First select a macro-construction from the list,
 2. Select items on the figure. Only items relevant
 to the selected macro-construction are selectable.
 Once enough items are selected, the macro is
 automaticly executed.
 To start press the ''next'' button.' translated asTextMorph lock
]

{ #category : #initialization }
DrGWizardMacroPlay >> initialize [
	super initialize.
	macroFactories := DrGMacroFactory new.
	self
		addPage: self firstPage;
		addPage: self secondPage.
]

{ #category : #testing }
DrGWizardMacroPlay >> isSelectPage [
	^ currentPage = 2
]

{ #category : #accessing }
DrGWizardMacroPlay >> macroList [
	^ macroFactories titles
]

{ #category : #initialization }
DrGWizardMacroPlay >> secondPage [
	|list page morph |
	page := Morph new color: Color transparent.
	page
		layoutPolicy: TableLayout new;
		listDirection: #bottomToTop;
		cellPositioning: #topLeft;
		layoutInset: 0@3;
		cellInset: 0@5.
	page addMorph: 'Title:' translated asStringMorph.
	list := PluggableListMorph
		on: self
		list: #macroList
		selected: #selectedMacro
		changeSelected: #selectedMacro:.
	list hResizing: #spaceFill;
		height: 50;
		color: Color white.
	page addMorph: list.
	page addMorph: 'Description:' translated asStringMorph.
	morph := PluggableTextMorph 
		on: builder text: #description accept: #description:.
	morph
		hResizing: #spaceFill;
		vResizing: #spaceFill;
		color: Color white.
	page addMorph: morph.
	morph acceptTextInModel.
	^(DrGWizardPage lastPage: 'Select a macro-construction then the figure items' translated) 
		model: self;
		content: page
]

{ #category : #accessing }
DrGWizardMacroPlay >> selectedMacro [
	^ macroFactories indexOf: builder selectedMacro
]

{ #category : #accessing }
DrGWizardMacroPlay >> selectedMacro: anIndex [
	builder selectedMacro: (macroFactories at: anIndex).
	self changed: #selectedMacro.
	builder changed: #description.
]
