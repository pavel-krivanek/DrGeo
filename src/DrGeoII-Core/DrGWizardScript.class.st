Class {
	#name : #DrGWizardScript,
	#superclass : #DrGWizard,
	#instVars : [
		'builder',
		'scripts'
	],
	#category : #DrGeoII-Core-UI
}

{ #category : #'instance creation' }
DrGWizardScript class >> builder: aBuilder [ 
	^ self basicNew
		builder: aBuilder;
		initialize 
]

{ #category : #accessing }
DrGWizardScript >> argumentsName [
	| labels |
	builder scriptClass ifNil: [^ #()].
	labels := DrGScriptDesignerDialog typeToLabel.
	^ builder scriptClass argumentsType collect: [ :type | labels at: type ]
]

{ #category : #accessing }
DrGWizardScript >> builder: anObject [
	builder := anObject 
]

{ #category : #meta-actions }
DrGWizardScript >> delete [
	super delete.
	builder := nil
]

{ #category : #initialization }
DrGWizardScript >> firstPage [
	^ (DrGWizardPage firstPage: 'Use a script in the sketch' translated) 
				model: self;
				content: 'To use a script,

 1. First select a script from the list,
 2. Select items in the sketch,
 3. Click somewhere in the background. 
 Once enough items are selected, the script is
 inserted in the sketch, at the user selected position.
 To start press the ''next'' button.' translated asTextMorph lock
]

{ #category : #accessing }
DrGWizardScript >> goPage: integer [
	super goPage: integer.
	self changed: #scriptsName
]

{ #category : #initialization }
DrGWizardScript >> initialize [
	super initialize.
	self 
		addPage: self firstPage;
		addPage: self secondPage.
]

{ #category : #testing }
DrGWizardScript >> isSelectPage [
	^ currentPage = 2
]

{ #category : #accessing }
DrGWizardScript >> scripts [
	^ scripts	ifNil: [
			scripts := DrGeoUserScript subclasses 
				sorted: [:script1 :script2 | script1 scriptName asLowercase < script2 scriptName asLowercase]]
]

{ #category : #accessing }
DrGWizardScript >> scriptsName [
	^ self scripts collect: [:class | class scriptName]
]

{ #category : #initialization }
DrGWizardScript >> secondPage [
	| list argumentList page textMorph |
	list := self newListFor: self
		list: #scriptsName 
		selected: #selectedScript
		changeSelected: #selectedScript:
		help: nil.	
	argumentList := self newListFor: self
		list: #argumentsName
		selected: nil 
		changeSelected: nil
		help: 'The arguments accepted by this script.'.
	textMorph := (self newTextEditorFor: builder
		getText: #description
		setText: #description:) acceptTextInModel; yourself.

	page := self newLabelGroup: { 
		'Script name' translated -> list.
		'Description' translated -> textMorph.
		'Arguments' translated -> argumentList}.
	
	^ (DrGWizardPage lastPage: 'Select a script then items in the sketch' translated) model: self;
		 content: page
]

{ #category : #accessing }
DrGWizardScript >> selectedScript [
	^ builder scriptClass
		ifNil: [0]
		ifNotNil: [self scripts indexOf: builder scriptClass]
]

{ #category : #accessing }
DrGWizardScript >> selectedScript: anIndex [ 
	builder scriptClass: 
		(self scripts	at: anIndex ifAbsent: []).
	self changed: #selectedScript.
	self changed: #argumentsName.
	builder changed: #description
]
