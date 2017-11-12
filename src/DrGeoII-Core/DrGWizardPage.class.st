"
A DrGWizardPage is a page morph to add in a wizard dialog..
Content can be added with the #content: message
Alternatively, it can be subclassed this class, to do so
override intialiaze with super call and at the end of 
initialize use #content: message

Instance Variables
	buttons:		<Object>
	cancel:		<Object>
	content:		<Object>
	model:		<Object>
	nextOrApply:		<Object>
	previous:		<Object>

buttons
	- xxxxx

cancel
	- xxxxx

content
	- xxxxx

model
	- xxxxx

nextOrApply
	- xxxxx

previous
	- xxxxx

"
Class {
	#name : #DrGWizardPage,
	#superclass : #Morph,
	#traits : 'TEasilyThemed - {#theme}',
	#classTraits : 'TEasilyThemed classTrait',
	#instVars : [
		'cancel',
		'previous',
		'nextOrApply',
		'buttons',
		'model',
		'content',
		'title'
	],
	#category : #DrGeoII-Core-UI
}

{ #category : #'as yet unclassified' }
DrGWizardPage class >> applyPage [
	"page with cancel button, previous button, and apply button"
]

{ #category : #'as yet unclassified' }
DrGWizardPage class >> applyPage: title [
	"page with cancel button, previous button, and apply button"
		^ self new applyPage: title
]

{ #category : #'as yet unclassified' }
DrGWizardPage class >> firstPage: title [
	"page with cancel button, gray and locked previous button, and next button"
	^ self new firstPage: title
]

{ #category : #'as yet unclassified' }
DrGWizardPage class >> lastPage: title [
	"page with cancel button, previous button, and gray and locked next button"
	^self new lastPage: title
]

{ #category : #'instance creation' }
DrGWizardPage class >> standardPage: title [
	"page with cancel, previous, next buttons"
	^ self new standardPage: title.
]

{ #category : #button }
DrGWizardPage >> addButton: btn [
	buttons addMorphBack: btn
]

{ #category : #callback }
DrGWizardPage >> apply [
	model apply
]

{ #category : #button }
DrGWizardPage >> applyBtn [
	nextOrApply := self newButtonFor: self
		action: #apply 
		label:  'apply' translated
		help: nil.
	^nextOrApply 
]

{ #category : #initialization }
DrGWizardPage >> applyPage: title [
	self title: title.
	self 
		addButton: self cancelBtn;
		addButton:  self previousBtn;
		addButton: self applyBtn.
]

{ #category : #button }
DrGWizardPage >> buttons [
	buttons := Morph new.
	buttons color: Color transparent.
	buttons layoutPolicy: TableLayout new;
		listDirection: #leftToRight;
		vResizing: #shrinkWrap;
		hResizing: #spaceFill;
		layoutInset: 5;
		cellInset: 5;
		listCentering: #bottomRight.
	^ buttons
]

{ #category : #callback }
DrGWizardPage >> cancel [
	model cancel
]

{ #category : #button }
DrGWizardPage >> cancelBtn [
	cancel := self newCancelButtonFor: self.
 	^ cancel
]

{ #category : #accessing }
DrGWizardPage >> content: aMorph [
	aMorph 
		vResizing: #spaceFill;
		hResizing: #spaceFill.
	content 
		ifNotNil: [self replaceSubmorph: content by: aMorph]
		ifNil: [self addMorph: aMorph].
	content := aMorph.
	content isTextMorph ifTrue: 
		[content wrapFlag: true.]
]

{ #category : #accessing }
DrGWizardPage >> defaultContent [
	self content: (Morph new
		color:  (Color r: 0.85 g: 0.9 b: 1.0)).
]

{ #category : #submorphs-add/remove }
DrGWizardPage >> delete [
	super delete.
	model := nil.
	content release; delete
]

{ #category : #initialization }
DrGWizardPage >> firstPage: title [
	self title: title.
	self 
		addButton: self cancelBtn;
		addButton: (self previousBtn disable);
		addButton: self nextBtn
]

{ #category : #initialization }
DrGWizardPage >> initialize [
	super initialize.
	self color: Color transparent .
	self clipSubmorphs: true.
	self layoutPolicy: TableLayout new;
		listDirection: #topToBottom;
		hResizing: #spaceFill;
		vResizing:  #spaceFill;
		layoutInset: 3.
	self addMorph: self buttons.
	self defaultContent.
]

{ #category : #initialization }
DrGWizardPage >> lastPage: title [
	self title: title.
	self
		addButton: self cancelBtn;
		addButton: self previousBtn;
		addButton: (self nextBtn disable)
]

{ #category : #accessing }
DrGWizardPage >> model: aMacroMorph [ 
	model := aMacroMorph
]

{ #category : #callback }
DrGWizardPage >> next [
	model next
]

{ #category : #button }
DrGWizardPage >> nextBtn [
	nextOrApply := self newButtonFor: self
		action: #next 
		label:  'next' translated
		help: nil.
	^ nextOrApply
]

{ #category : #callback }
DrGWizardPage >> previous [
	model previous
]

{ #category : #button }
DrGWizardPage >> previousBtn [
	previous := self newButtonFor: self
		action: #previous 
		label:  'previous' translated
		help: nil.
	^ previous
]

{ #category : #initialization }
DrGWizardPage >> standardPage: title [
	self title: title.
	self 
		addButton: self cancelBtn;
		addButton: self previousBtn;
		addButton: self nextBtn
]

{ #category : #accessing }
DrGWizardPage >> title [
	^ title
]

{ #category : #accessing }
DrGWizardPage >> title: aTitle [
	title := aTitle
]
