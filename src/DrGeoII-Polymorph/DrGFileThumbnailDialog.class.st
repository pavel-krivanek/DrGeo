"
I am a dialog to browse sketches. I present a sketch preview the user can select.
Sketches are locale or remote.
	- resource is the way to access these sketches, it is a DrGDirectory instance.
"
Class {
	#name : #DrGFileThumbnailDialog,
	#superclass : #DialogWindow,
	#instVars : [
		'resource',
		'isExamples',
		'previewsPanel',
		'finalSelectedFile'
	],
	#category : #DrGeoII-Polymorph
}

{ #category : #accessing }
DrGFileThumbnailDialog >> beDelete [
	^ self isExamples not & self selectedFile notNil
]

{ #category : #accessing }
DrGFileThumbnailDialog >> beExamples [
	^ true
]

{ #category : #accessing }
DrGFileThumbnailDialog >> beMySketches [ 
	^ true
]

{ #category : #accessing }
DrGFileThumbnailDialog >> beNetwork [
	^ true
]

{ #category : #'preview cache' }
DrGFileThumbnailDialog >> cachePreviewFilename: filename [
	"the name of the cahed preview if it exist"
	^ ((filename allButLast: 4), 'png')
]

{ #category : #'preview cache' }
DrGFileThumbnailDialog >> cachedFormFor: filename [
	^ PNGReadWriter formFromStream:  (resource getFile: (self cachePreviewFilename: filename))
]

{ #category : #accessing }
DrGFileThumbnailDialog >> cancelButton [
|btns|
	btns := self buttons.
	^ btns at: btns size - 1
]

{ #category : #open/close }
DrGFileThumbnailDialog >> closeResource [
	resource ifNotNil: [resource close]
]

{ #category : #'preview cache' }
DrGFileThumbnailDialog >> computeFormFor: filename [
	|stream drgeo form|
	stream := resource getTextFile: filename.
	[[drgeo := (DrGeoXml new loadOnlyFigureFrom: stream for: #service) first.
	drgeo view openInWorld; delete]
		on: Error do: []] 
		ensure: [stream close].
	drgeo 
		ifNil: [form := Form extent: 1@1] 
		ifNotNil: [form := (Form extent: drgeo area extent depth: 32) fillWhite.
			drgeo area owner fullDrawOn: form getCanvas.
			form := form scaledToSize: DrGeo previewSize].
	[stream := ByteArray new writeStream.
	PNGReadWriter putForm: form onStream: stream.
	resource put: stream into: (self cachePreviewFilename: filename)] ensure:
		[stream close].
	^ form
]

{ #category : #actions }
DrGFileThumbnailDialog >> defaultLabel [
	^ 'Open a sketch' translated
]

{ #category : #actions }
DrGFileThumbnailDialog >> deleteFile [
|answer|
		answer := UIManager default 
			confirm: ('Delete the sketch: {1}?' translated format: {(self selectedFile allButLast: 5) capitalized}).
		answer ifTrue: [
			resource deleteFile: self selectedFile.
			resource deleteFile: (self selectedFile allButLast: 4), 'png'.
			previewsPanel removeMorph: self rememberedKeyboardFocus.
			self focusCancelButton.
			self changed: #beDelete]
]

{ #category : #accessing }
DrGFileThumbnailDialog >> finalSelectedFile [
	^ finalSelectedFile 
]

{ #category : #actions }
DrGFileThumbnailDialog >> focusCancelButton [
	self cancelButton takeKeyboardFocus.
	self rememberKeyboardFocus: self cancelButton.

]

{ #category : #'preview cache' }
DrGFileThumbnailDialog >> formFor: filename [
	^ (self isCachedForm: filename) 
		ifTrue: [self cachedFormFor: filename] 
		ifFalse: [self computeFormFor: filename]
]

{ #category : #actions }
DrGFileThumbnailDialog >> gotFocusOn: previewMorph [
	self rememberKeyboardFocus: previewMorph.
	self changed: #beDelete.

]

{ #category : #events-processing }
DrGFileThumbnailDialog >> handleFocusEvent: anEvent [
    (anEvent isMouse and: [ anEvent isMouseWheel ])
        ifTrue: [ self activeHand releaseMouseFocus: self ].
    ^ super handleFocusEvent: anEvent
]

{ #category : #open/close }
DrGFileThumbnailDialog >> initialExtent [
	^ 1016@ 400
]

{ #category : #initialization }
DrGFileThumbnailDialog >> initialize [
	resource := DrGDefault mySketchResources.
	super initialize.

]

{ #category : #'preview cache' }
DrGFileThumbnailDialog >> isCachedForm: filename [
	^ resource fileExists: (self cachePreviewFilename: filename)
]

{ #category : #testing }
DrGFileThumbnailDialog >> isExamples [
	^ resource isLocal and: [resource directory includesSubstring: 'examples']
]

{ #category : #testing }
DrGFileThumbnailDialog >> isMySketches [
	^ resource isLocal and: [resource directory includesSubstring: 'MySketches']
]

{ #category : #testing }
DrGFileThumbnailDialog >> isNetwork [
	"are we browsing the networked sketch"
	^ resource isRemote 
]

{ #category : #update }
DrGFileThumbnailDialog >> loadPreviews [
	DrGLoader start.
	[previewsPanel removeAllMorphs.
	resource fgeoFiles reverse
		do: [:file | previewsPanel addMorph: (self previewFor: file)]
	] 
	ensure: [
		DrGLoader stop].
]

{ #category : #actions }
DrGFileThumbnailDialog >> network [
	^ self isNetwork
]

{ #category : #accessing }
DrGFileThumbnailDialog >> networkShare [
	^ DrGDefault networkShare
]

{ #category : #accessing }
DrGFileThumbnailDialog >> networkShare: aString [
"Before browsing this network share, we test it does exsit"
	DrGDefault networkShare: aString.
	self switchToNetwork.
]

{ #category : #actions }
DrGFileThumbnailDialog >> newButtons [
	|buttons|
	buttons := OrderedCollection withAll: {self newMySketchesButton. self newExamplesButton}.
	DrGDefault useNetwork ifTrue: [
		buttons 
			add: self newNetworkButton;
			add: self newNetworkShareMorph].
	buttons addAll: {
		Morph new color: Color transparent; hResizing: #spaceFill; height: 10.
		self newOpenButton. self newCancelButton isDefault: true. self newDeleteButton}.
	^ buttons
]

{ #category : #actions }
DrGFileThumbnailDialog >> newContentMorph [
| scroll|
	previewsPanel := PanelMorph new color: Color white.
	previewsPanel hResizing: #spaceFill;
		vResizing: #spaceFill;
		changeTableLayout;
		listDirection: #leftToRight;
		wrapDirection: #topToBottom;
		cellInset: 8.
	self loadPreviews.
	scroll := GeneralScrollPane new
		changeScrollerTableLayout;
		scrollTarget: previewsPanel.
	^ scroll vResizing: #spaceFill;
		hResizing: #spaceFill
]

{ #category : #actions }
DrGFileThumbnailDialog >> newDeleteButton [
	^ (self 
		newButtonFor: self
		getState: nil
		action: #deleteFile
		arguments: nil
		getEnabled: #beDelete
		labelForm: Smalltalk ui icons smallDeleteIcon
		help: 'Delete the selected sketch' translated) hResizing: #shrinkWrap
		
	 
]

{ #category : #actions }
DrGFileThumbnailDialog >> newExamplesButton [
	^ self newButtonFor: self
		getState: #isExamples
		action: #switchToExamples 
		arguments: nil
		getEnabled: #beExamples 
		label: 'Examples' translated 
		help: 'View sketch examples' translated
]

{ #category : #actions }
DrGFileThumbnailDialog >> newMySketchesButton [
	^ self newButtonFor: self
		getState: #isMySketches
		action: #switchToSketches 
		arguments: nil
		getEnabled: #beMySketches 
		label: 'MySketches' translated 
		help: 'View my sketches' translated
]

{ #category : #actions }
DrGFileThumbnailDialog >> newNetworkButton [
	^ self newButtonFor: self
		getState: #isNetwork
		action: #switchToNetwork
		arguments: nil
		getEnabled: #beNetwork 
		label: 'Network' translated 
		help: 'View shared sketches' translated
]

{ #category : #actions }
DrGFileThumbnailDialog >> newNetworkShareMorph [
	^ (self 
		newTextEntryFor: self 
		getText: #networkShare
		setText: #networkShare:
		getEnabled: #isNetwork
		help: 'The network share to browse.' translated)
		alwaysAccept: false;
		acceptOnFocusChange: false;
		autoAccept: false


]

{ #category : #actions }
DrGFileThumbnailDialog >> newOpenButton [
	^ self 
		newButtonFor: self
		action: #ok 
		label: 'Open' translated 
		help: 'Open the selected sketch' translated
]

{ #category : #actions }
DrGFileThumbnailDialog >> ok [
	finalSelectedFile := self selectedFile.
	self
		cancelled: false;
		delete
]

{ #category : #'preview cache' }
DrGFileThumbnailDialog >> previewFor: filename [
	| morph|
	morph := ThumbnailPreviewMorph new
		filename: filename;
		image: (self formFor: filename)
		size: DrGeo previewSize.
	morph textMorph contents: (filename allButLast: 5) capitalized.
	morph when: #selectedSktech send: #selectAndClose to: self.
	morph when: #gotFocus send: #gotFocusOn: to: self.
	^ morph
]

{ #category : #accessing }
DrGFileThumbnailDialog >> previewSize [ 
	^ 320@240
]

{ #category : #actions }
DrGFileThumbnailDialog >> selectAndClose [
	self ok.
]

{ #category : #accessing }
DrGFileThumbnailDialog >> selectedFile [
	"a DirectoryEntryFile item"
	| focusedMorph |
	focusedMorph := self rememberedKeyboardFocus.
	^ (focusedMorph respondsTo: #filename) 
		ifTrue: [focusedMorph filename]
		ifFalse: [nil]
	
]

{ #category : #accessing }
DrGFileThumbnailDialog >> selectedFileStream [
	^ resource getTextFile: finalSelectedFile
]

{ #category : #accessing }
DrGFileThumbnailDialog >> shareTextEntry [
|btns|
	btns := self buttons.
	^ btns at: btns size - 3
]

{ #category : #actions }
DrGFileThumbnailDialog >> switchToExamples [
	self focusCancelButton.
	self closeResource.
	resource :=DrGDefault exampleResources.
	self updateBtnAndPreview 
]

{ #category : #actions }
DrGFileThumbnailDialog >> switchToNetwork [
	self focusCancelButton.
	self closeResource.
	DrGLoader start.
	(DrGDefault networkResources: self) ifNotNil: [:anwer | 
		resource := anwer.
		self updateBtnAndPreview].
	DrGLoader stop.
]

{ #category : #actions }
DrGFileThumbnailDialog >> switchToSketches [
	self focusCancelButton.
	self closeResource.
	resource :=DrGDefault mySketchResources.
	self updateBtnAndPreview
]

{ #category : #actions }
DrGFileThumbnailDialog >> updateBtnAndPreview [
	self changed: #isMySketches.
	self changed: #isExamples.
	self changed: #isNetwork.
	self changed: #beDelete.
	self loadPreviews 
]
