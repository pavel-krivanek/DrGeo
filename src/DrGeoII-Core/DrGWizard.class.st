"
A DrGMacroMorph is an abstractact dialog to build and play macro.
It emits event when 
 - the user changes the page with the next and previous buttons
 - the user press apply and cancel

Instance Variables
	pages:		dictionary of pages Morph

pages
	- xxxxx

"
Class {
	#name : #DrGWizard,
	#superclass : #DialogWindow,
	#instVars : [
		'pages',
		'currentPage',
		'panel'
	],
	#category : #DrGeoII-Core-UI
}

{ #category : #'as yet unclassified' }
DrGWizard class >> example [
	"DrGWizard example openInWorld"
	| wizard |
	wizard := self new.
	wizard
		addPage: ((DrGWizardPage firstPage: 'Step 1/3') model: wizard);
		addPage: ((DrGWizardPage standardPage: 'Step 2/3') model: wizard;
			content: 'We can change content :
	1. One
	2. Two
	3. Three' asTextMorph);
		addPage: ((DrGWizardPage applyPage: 'Step 3/3') model: wizard).
	^ wizard
]

{ #category : #accessing }
DrGWizard >> addPage: aPage [
	pages add: aPage.
	currentPage ifNil: 
		[self panel addMorph: aPage.
		self title: aPage title.
		currentPage := 1]
]

{ #category : #callback }
DrGWizard >> apply [
	self triggerEvent: #apply
]

{ #category : #callback }
DrGWizard >> cancel [
	self triggerEvent: #cancel
]

{ #category : #meta-actions }
DrGWizard >> delete [
	super delete.
	pages do: [:page | page delete].
]

{ #category : #accessing }
DrGWizard >> goPage: integer [
"	(contentMorph findA: DrGWizardPage) ifNotNilDo: 
		[:page | self removeMorph: page]."
	self panel removeAllMorphs.
	self panel addMorph: (self pageAt: integer).
	self title: (self pageAt: integer) title.
	self triggerEvent: #page with: integer.
]

{ #category : #initialization }
DrGWizard >> initialExtent [
	^DrGDefault wizardExtent
]

{ #category : #initialization }
DrGWizard >> initialize [
	super initialize.
	pages := OrderedCollection new.
]

{ #category : #testing }
DrGWizard >> isResizeable [ 
	^ true
]

{ #category : #actions }
DrGWizard >> newMainPanel [
	^ self panel
]

{ #category : #callback }
DrGWizard >> next [
	currentPage < pages size ifFalse: [^ self].
	self goPage: (currentPage := currentPage + 1)
]

{ #category : #accessing }
DrGWizard >> pageAt: integer [
	^ pages at: integer 
]

{ #category : #initialization }
DrGWizard >> pageModel [
	|page|
	page := Morph new color: Color transparent .
	page
		layoutPolicy: TableLayout new;
		listDirection: #bottomToTop;
		cellPositioning: #topLeft;
		layoutInset: 0@3;
		cellInset: 0@5.
	^ page
]

{ #category : #actions }
DrGWizard >> panel [
	^ panel ifNil: [ panel := self newDialogPanel]
]

{ #category : #callback }
DrGWizard >> previous [
	currentPage > 1 ifFalse: [^self].
	self goPage: (currentPage := currentPage - 1)
]
