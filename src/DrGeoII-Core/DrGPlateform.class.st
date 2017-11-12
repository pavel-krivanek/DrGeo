"
I am an abstract class to modelise access to plateform preferences and information.
Pattern: strategy
"
Class {
	#name : #DrGPlateform,
	#superclass : #Object,
	#instVars : [
		'toolbarIconSize',
		'canWeDisplayLoader',
		'premium',
		'release'
	],
	#category : #DrGeoII-Core-Resources
}

{ #category : #accessing }
DrGPlateform >> canWeDisplayLoader [
	^ canWeDisplayLoader
]

{ #category : #'user interface' }
DrGPlateform >> canvasFontSize [
	^ 9
]

{ #category : #initialize-release }
DrGPlateform >> checkForPaths [
	self mySketchesPath ensureCreateDirectory 
]

{ #category : #path }
DrGPlateform >> examplesPath [
	^ self rootPath / 'examples'
]

{ #category : #path }
DrGPlateform >> fontPath [
	^  self rootPath
]

{ #category : #'user interface' }
DrGPlateform >> fontSize [
	^ 15
]

{ #category : #initialize-release }
DrGPlateform >> installFont [
	| font |
	FreeTypeFontProvider unload.
	font := self fontPath / DrGDefault fontFile.
	FreeTypeFontProvider current updateFromFile: font.
	FreeTypeFontProvider current buildFamilies.
]

{ #category : #testing }
DrGPlateform >> isAndroid [
	^ false
]

{ #category : #testing }
DrGPlateform >> isEtoys [
	^ false
]

{ #category : #testing }
DrGPlateform >> isPremium [
	^ premium ifNil: [premium := true]
]

{ #category : #testing }
DrGPlateform >> isRelease [
	^ release ifNil: [release := false]
]

{ #category : #testing }
DrGPlateform >> isSugar [
	^ false
]

{ #category : #testing }
DrGPlateform >> isWorkstation [
	^ false
]

{ #category : #testing }
DrGPlateform >> isiPad [
	^ false
]

{ #category : #path }
DrGPlateform >> myExportsPath [
	^ self shouldNotImplement
]

{ #category : #path }
DrGPlateform >> mySketchesPath [
	^self rootPath / 'MySketches'
]

{ #category : #'as yet unclassified' }
DrGPlateform >> openURI: string [
]

{ #category : #accessing }
DrGPlateform >> premium: boolean [
	premium := boolean 
]

{ #category : #accessing }
DrGPlateform >> release: boolean [
	release := boolean 
]

{ #category : #initialize-release }
DrGPlateform >> reset [
	toolbarIconSize := nil
]

{ #category : #path }
DrGPlateform >> rootPath [
	^ FileSystem disk workingDirectory parent parent
]

{ #category : #'user interface' }
DrGPlateform >> screenHeight [
	^ Display height
]

{ #category : #'user interface' }
DrGPlateform >> screenWidth [
	^ Display width
]

{ #category : #'user interface' }
DrGPlateform >> setFontPreferences [ 
]

{ #category : #'user interface' }
DrGPlateform >> showVirtualKeyboard: boolean [

]

{ #category : #'user interface' }
DrGPlateform >> smallFontSize [
	^ 13
]

{ #category : #initialize-release }
DrGPlateform >> splash [
 | splash copy  background position splashMorph |
	canWeDisplayLoader := false.
	[splash := ImageReadWriter formFromFileNamed: (self rootPath / 'splash.bmp') pathString.
	position := DrGDefault screenCenter - (splash extent // 2).
	background := Form fromDisplay: (position extent: splash extent).
	0.0 to: 1.0 by: 0.2 do: [:t |
		copy := background deepCopy.
		copy copyBits: splash at: 0@0 translucent: t.
		copy displayAt:  position.
		(Delay forMilliseconds: 100) wait].
	splashMorph := splash asMorph.
	splashMorph
		position: position;
		openInWorld.
	(Delay forSeconds: 2) wait.
	splashMorph delete.
	canWeDisplayLoader := true] fork.
]

{ #category : #initialize-release }
DrGPlateform >> startUp [
	Author fullName: 'DrGeoUser'.
	"self installFont.
	self setFontPreferences.
	self checkForPaths."

]

{ #category : #'user interface' }
DrGPlateform >> toolbarIconSize [
	toolbarIconSize ifNil: [
		"toolbarIconSize := (self screenHeight - 32 / 14.4) truncateTo: 8."
		toolbarIconSize := (self screenHeight - 110 / 12) truncateTo: 4.
		toolbarIconSize < 12 ifTrue: [toolbarIconSize := 12].
		toolbarIconSize > 48 ifTrue: [toolbarIconSize := 48]].
	^ toolbarIconSize 
]

{ #category : #'user interface' }
DrGPlateform >> wheelHeight [
	^ 150
]

{ #category : #'user interface' }
DrGPlateform >> wheelWidth [
	^ 45
]

{ #category : #'user interface' }
DrGPlateform >> wizardExtent [
	^550@350
]
