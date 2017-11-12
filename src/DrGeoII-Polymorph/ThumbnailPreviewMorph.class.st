Class {
	#name : #ThumbnailPreviewMorph,
	#superclass : #ImagePreviewMorph,
	#instVars : [
		'filename'
	],
	#category : #DrGeoII-Polymorph
}

{ #category : #'event handling' }
ThumbnailPreviewMorph >> doubleClick: evt [
	self wantsKeyboardFocus ifTrue: [self takeKeyboardFocus].
	self triggerEvent: #selectedSktech
]

{ #category : #drawing }
ThumbnailPreviewMorph >> drawSubmorphsOn: aCanvas [
"Display submorphs back to front.
Draw the focus here since we are using inset bounds
for the focus rectangle."
	super drawSubmorphsOn: aCanvas.
	self hasKeyboardFocus ifTrue: [self drawKeyboardFocusOn: aCanvas]

]

{ #category : #accessing }
ThumbnailPreviewMorph >> filename [
	^ filename
]

{ #category : #accessing }
ThumbnailPreviewMorph >> filename: string [
	filename := string 
]

{ #category : #'event handling' }
ThumbnailPreviewMorph >> handlesKeyboard: event [
	^ true
]

{ #category : #'event handling' }
ThumbnailPreviewMorph >> handlesMouseDown: event [
	^ true
]

{ #category : #'event handling' }
ThumbnailPreviewMorph >> hasFocus [
	^ true
]

{ #category : #'as yet unclassified' }
ThumbnailPreviewMorph >> image: form size: imageSize [
	"Set the image and update the description."
	form
		ifNil: [self imageMorph
			image: (self defaultImageFormOfSize: imageSize)]
		ifNotNil: [self imageMorph
			image: form
			size: imageSize]
	
]

{ #category : #initialize }
ThumbnailPreviewMorph >> initialize [ 
	super initialize.
	self cellInset: 4.
	self cornerStyle: #rounded.
	self hasDropShadow: true.
	self shadowOffset: 1@1.
	self shadowColor: (Color black alpha: 0.2).
	self layoutChanged.
]

{ #category : #'event handling' }
ThumbnailPreviewMorph >> keyStroke: event [
"Process keys navigation and space to toggle."
	(self navigationKey: event) ifTrue: [^self]. 
]

{ #category : #'event handling' }
ThumbnailPreviewMorph >> keyboardFocusChange: aBoolean [
	self focusChanged.
	aBoolean ifTrue: [self triggerEvent: #gotFocus with: self]

]

{ #category : #'event handling' }
ThumbnailPreviewMorph >> mouseDown: event [
	super mouseDown: event.
	event hand waitForClicksOrDrag: self event: event.
	self wantsKeyboardFocus ifTrue: [self takeKeyboardFocus]
]

{ #category : #'event handling' }
ThumbnailPreviewMorph >> mouseMove: evt [
"hugly, pass the move event to the GeneralScrollPane"
	self owner owner owner mouseMove: evt
]

{ #category : #initialize }
ThumbnailPreviewMorph >> newImageMorph [
	"Answer a new image morph."

	^AlphaImageMorph new
		borderStyle: (BorderStyle raised width: 1);
		color: Color white;
		alpha: 1.0
]

{ #category : #initialize }
ThumbnailPreviewMorph >> newTextMorph [ 
	^ super newTextMorph
		hasDropShadow: true;
		shadowOffset: 1@1;
		color: Color white.
		
]

{ #category : #'*DrGeoII-Polymorph-Widgets' }
ThumbnailPreviewMorph >> takesKeyboardFocus [ 
	^ true
]
