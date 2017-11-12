"
Preferences for iPad tablet
"
Class {
	#name : #DrGiPad,
	#superclass : #DrGTablet,
	#category : #DrGeoII-Core-Resources
}

{ #category : #accessing }
DrGiPad class >> applicationName [ 
	^ DrGDefault isPremium
		ifTrue: [ 'DrGeometry.app'] 
		ifFalse: ['DrGeometryFree.app']
]

{ #category : #initialize-release }
DrGiPad >> initialize [
	canWeDisplayLoader := true.
	WorldState desktopMenuTitle: 'Dr. Geo'.
	WorldState desktopMenuPragmaKeyword:  'drgeoMenu'.

	PolymorphSystemSettings uiThemeClass:  DrGeoTheme.
	UITheme currentSettings fastDragging: true.
	UITheme currentSettings fadedBackgroundWindows: false.
	SystemWindow fullscreenMargin: 0.
	UITheme currentSettings preferRoundCorner: false.

	TaskbarMorph showTaskbar: false.
	World color: Color white.
"	HostWindowProxy basicNew primitiveWindowSize: 1	x: 1024	y: 768. " "does not work when building from Linux"
"	World doOneCycleNow.
	DrGeo new view extent: 1024@768; position: 0@0."
]

{ #category : #testing }
DrGiPad >> isiPad [
	^ true
]

{ #category : #path }
DrGiPad >> localePath [
	^ self rootPath / 'locale'
]

{ #category : #path }
DrGiPad >> mySketchesPath [
	| path |
	path := self sandboxPath asFileReference / 'MySketches'.
	^path fullName

]

{ #category : #'as yet unclassified' }
DrGiPad >> openURI: aString [
	| sharedApp nsUrl |
	sharedApp := ((Smalltalk at: #ObjectiveCBridge) classObjectForName: #UIApplication) sharedApplication.
	nsUrl := (Smalltalk at: #ObjectiveCBridge) classObjectForName: #NSURL.
	sharedApp openURL: (nsUrl URLWithString: aString asNSStringUTF8).
	
	"(ObjectiveCBridge  classObjectForName: #UIApplication) sharedApplication 
		openURL: ((ObjectiveCBridge classObjectForName: #NSURL) URLWithString: 'http://www.drgeo.eu' asNSStringUTF8)"
]

{ #category : #path }
DrGiPad >> rootPath [
	^ (FileDirectory on: (FileDirectory iPhoneCurrentDirectory allButFirst: 8)) containingDirectory fullName, 
		FileDirectory slash, 
		self class applicationName
]

{ #category : #path }
DrGiPad >> sandboxPath [
	| path |
	path := self rootPath  parent / 'Documents'.
	path ensureDirectory.
	^path fullName
]

{ #category : #'user interface' }
DrGiPad >> showVirtualKeyboard: boolean [
	(Smalltalk at: #IPhonePlatform) showKeyboard: boolean
]

{ #category : #initialize-release }
DrGiPad >> startUp [
	GetTextTranslator userDefaultLocaleDirs add: self localePath.
	NaturalLanguageTranslator privateStartUp.
	super startUp.

]

{ #category : #'user interface' }
DrGiPad >> toolbarIconSize [
	^ 40
]
