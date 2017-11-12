Class {
	#name : #DrGWizardMacroBuild,
	#superclass : #DrGWizard,
	#instVars : [
		'builder'
	],
	#category : #DrGeoII-Core-UI
}

{ #category : #'instance creation' }
DrGWizardMacroBuild class >> builder: aBuilder [ 
	^ self basicNew
		builder: aBuilder;
		initialize 
]

{ #category : #accessing }
DrGWizardMacroBuild >> builder: aBuilder [
	builder := aBuilder 
]

{ #category : #meta-actions }
DrGWizardMacroBuild >> delete [
	super delete.
	builder := nil.
]

{ #category : #initialization }
DrGWizardMacroBuild >> firstPage [
	^ (DrGWizardPage firstPage: 'Build a macro-construction' translated) 
				model: self;
				content: 'To build a macro-construction,

 1. First select the input paramaters,
 2. Next select the output parameters,
 3. Next chose a name and a description,
 4. Last apply the selection.' translated asTextMorph lock
]

{ #category : #initialization }
DrGWizardMacroBuild >> fourthPage [
	| page morph |
	page := self pageModel.
	
	page addMorph: 'Title:' translated asStringMorph.
	morph := PluggableTextMorph 
		on: builder text: #title accept: #title:.
	morph acceptTextInModel.
	morph
		color: Color white;
		autoAccept: true;
		hResizing: #spaceFill;
		height: 16;
		hideScrollBarsIndefinitely.
	page addMorph: morph.
	page addMorph: 'Description:' translated asStringMorph.
	morph := PluggableTextMorph 
		on: builder text: #description accept: #description:.
	morph
		color: Color white;
		autoAccept: true;
		hResizing: #spaceFill;
		vResizing: #spaceFill.
	page addMorph: morph.
	morph acceptTextInModel.
	^(DrGWizardPage applyPage: 'Give a name and a description' translated) 
				model: self;
				content: page
]

{ #category : #initialization }
DrGWizardMacroBuild >> initialize [
	super initialize.
	self 
		addPage: self firstPage;
		addPage: self secondPage;
		addPage: self thirdPage;
		addPage: self fourthPage.
		
]

{ #category : #testing }
DrGWizardMacroBuild >> isInputPage [
	^ currentPage  = 2
]

{ #category : #testing }
DrGWizardMacroBuild >> isOutputPage [
	^ currentPage  = 3
]

{ #category : #initialization }
DrGWizardMacroBuild >> secondPage [
	| list page |
	page := self pageModel.
	list := PluggableListMorph 
		on: builder
		list: #inputName 
		selected: nil 
		changeSelected: nil.
	list color: Color white;
		hResizing: #spaceFill;
		vResizing: #spaceFill.
	page addMorph: list.
	^ (DrGWizardPage new standardPage: 'Select input parameters' translated) 
		model: self;
		content: page
]

{ #category : #initialization }
DrGWizardMacroBuild >> thirdPage [
	| list page |
	page := self pageModel.
	list := PluggableListMorph 
		on: builder 
		list: #outputName
		selected: nil 
		changeSelected: nil.
	list color: Color white;
		hResizing: #spaceFill;
		vResizing: #spaceFill.
	page addMorph: list .
	^ (DrGWizardPage new standardPage: 'Select output parameters' translated) 
		model: self;
		content: page
]
