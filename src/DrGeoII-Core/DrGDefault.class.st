"
I map settings/preferences to the underneath hardware/os plateform
Pattern: strategy

(SettingBrowser forKeywords: #('drgeosettings')) open.
"
Class {
	#name : #DrGDefault,
	#superclass : #Object,
	#classVars : [
		'Host',
		'NetworkDirectory',
		'NetworkPassword',
		'NetworkType',
		'NetworkUser',
		'UseNetwork'
	],
	#classInstVars : [
		'plateform',
		'expirationDate'
	],
	#category : #DrGeoII-Core-Resources
}

{ #category : #'system startup' }
DrGDefault class >> addStartUp [
	Smalltalk addToStartUpList: self
]

{ #category : #'class initialization' }
DrGDefault class >> beAndroid [
	"self beAndroid"
	plateform := DrGAndroid new.
	self addStartUp
]

{ #category : #'class initialization' }
DrGDefault class >> beOlpc [
	"self beOlpc"
	plateform := DrGSugar new.
	self addStartUp
]

{ #category : #'class initialization' }
DrGDefault class >> beSystem [
"Reset to pharo system preference"
"self beSystem"
	Display newDepth: 32.
	WorldState desktopMenuPragmaKeyword:  'worldMenu'.
	WorldState desktopMenuTitle: 'World'.
	self removeStartUp.
	TaskbarMorph showTaskbar: true.
]

{ #category : #'class initialization' }
DrGDefault class >> beWorkstation [
	"self beWorkstation"
	plateform := DrGWorkstation new.
	self addStartUp
]

{ #category : #'class initialization' }
DrGDefault class >> beiPad [
	"self beiPad"
	plateform := DrGiPad new.
	self addStartUp
]

{ #category : #'class initialization' }
DrGDefault class >> beiPadDemo [
	"self beiPadDemo"
	plateform := DrGiPadDemo new.
	self addStartUp
]

{ #category : #testing }
DrGDefault class >> canWeDisplayLoader [
	^ plateform canWeDisplayLoader
]

{ #category : #font }
DrGDefault class >> canvasFont [
	^ LogicalFont familyName: self fontName pointSize: self canvasFontSize
]

{ #category : #font }
DrGDefault class >> canvasFont: size [
	^ LogicalFont familyName: self fontName pointSize: size
]

{ #category : #font }
DrGDefault class >> canvasFontSize [
	^ plateform canvasFontSize
]

{ #category : #resources }
DrGDefault class >> connectToNetwork: parentMorph [
|resource|
	[resource := (DrGDirectoryFTP host: self host)
		login: self networkUser password: self networkPassword]
		on: Error
		do: [parentMorph abort: 'I can''t connect to server.
Check the server settings.' translated.
			resource := nil].
	^ resource 
]

{ #category : #settings }
DrGDefault class >> drgeoSettingsOn: aBuilder [
	<drgeosettings>
	(aBuilder group: #drgeo)
		label: 'Network';
		description: 'Dr. Geo network settings' translated;
		noOrdering;
		with: [
			(aBuilder setting: #useNetwork)
				label: 'Use network resources' translated;
				noOrdering;
				description: 'If checked you can set a server name, user and password to load and to save sketches.' translated;
				with: [
					(aBuilder pickOne: #networkType)
						label: 'Server type' translated;
						description: 'The server type, FTP or WebDav';
						default: #ftp;
						domainValues: #(#ftp #http).
					(aBuilder setting: #host)
						label: 'Host' translated;
						description: 'The server (i.e. ftp.drgeo.eu)' translated .
					(aBuilder setting: #networkUser)
						label: 'User name' translated;
						description: 'The server user name' translated.
					(aBuilder setting: #networkPassword)
						type: #Password;
						label: 'Password' translated;
						description: 'The user password' translated.
					(aBuilder setting: #networkShare)
						label: 'Share' translated;
						description: 'The server resources directory (i.e. private/drgeo)' translated ]]
]

{ #category : #resources }
DrGDefault class >> exampleResources [
	^ DrGDirectoryLocal new directory: DrGDefault examplesPath pathString.
]

{ #category : #path }
DrGDefault class >> examplesPath [
	^ plateform examplesPath
]

{ #category : #'class initialization' }
DrGDefault class >> expiresIn: duration [
	duration 
		ifNil: [expirationDate := nil]
		ifNotNil: [expirationDate := Date today + duration] 
]

{ #category : #font }
DrGDefault class >> font [
	^ LogicalFont familyName: self fontName pointSize: self fontSize
]

{ #category : #font }
DrGDefault class >> fontFile [
	^ Locale current isoLanguage = 'ko'
		ifTrue: ['UnDotum.ttf']
		ifFalse: ['wqy-microhei.ttc'] 
]

{ #category : #font }
DrGDefault class >> fontName [
	^ Locale current isoLanguage = 'ko'
		ifTrue: ['UnDotum']
		ifFalse: ['WenQuanYi Micro Hei'] 
]

{ #category : #font }
DrGDefault class >> fontSize [
	^ plateform fontSize
]

{ #category : #settings }
DrGDefault class >> host [
	^ Host ifNil: [Host := '']
]

{ #category : #settings }
DrGDefault class >> host: string [
	Host := string
]

{ #category : #testing }
DrGDefault class >> ifNotTablet: aBlock [
	^ self isTablet ifFalse: [aBlock value]
]

{ #category : #testing }
DrGDefault class >> ifNotiPad: aBlock [
	^ plateform isiPad ifFalse: [aBlock value]
]

{ #category : #testing }
DrGDefault class >> ifPremium: block [
	^ self isPremium
		ifTrue: [block value]
		ifFalse: [UIManager default inform: 'You need to buy the full version
of Dr. Geo for this function.']
]

{ #category : #testing }
DrGDefault class >> ifRelease: block [
	^ self isRelease
		ifTrue: [block value]
]

{ #category : #testing }
DrGDefault class >> ifTablet: aBlock [
	^ self isTablet ifTrue: [aBlock value]
]

{ #category : #testing }
DrGDefault class >> isAndroid [
	^ plateform isAndroid
]

{ #category : #testing }
DrGDefault class >> isEtoys [
	^ plateform isEtoys
]

{ #category : #testing }
DrGDefault class >> isPremium [
"Are we the premium version of DrGeo"
	^ plateform isPremium
]

{ #category : #testing }
DrGDefault class >> isRelease [ 
"Are we in the public release mode of DrGeo"
	^ plateform isRelease
]

{ #category : #testing }
DrGDefault class >> isSugar [
	^ plateform isSugar
]

{ #category : #testing }
DrGDefault class >> isTablet [
	^ plateform isAndroid or: [plateform isiPad]
]

{ #category : #testing }
DrGDefault class >> isWorkstation [
"Are we workstation version of DrGeo"
	^ plateform isWorkstation
]

{ #category : #testing }
DrGDefault class >> isiPad [
	^ plateform isiPad
]

{ #category : #path }
DrGDefault class >> myExportsPath [
	^ plateform myExportsPath
]

{ #category : #resources }
DrGDefault class >> mySketchResources [
	^ DrGDirectoryLocal new directory: DrGDefault mySketchesPath pathString.
]

{ #category : #path }
DrGDefault class >> mySketchesPath [
	^ plateform mySketchesPath
]

{ #category : #resources }
DrGDefault class >> networkOpenShareOn: resource with: parentMorph [
	(resource directory: self networkShare) ifTrue: [^ resource].
	(self networkShare = 'SandBox') ifTrue:
		[DrGLoader stop.
		parentMorph abort: 'I can''t connect to network.' translated.
		resource close.
		^ nil].
	DrGLoader stop.
	parentMorph abort: ('I can''t open the share {1}.
Switch back to ''SandBox'' share.' translated format: {self networkShare}).
	self networkShare: 'SandBox'.
	parentMorph changed: #networkShare.
	resource close.
	^ self networkResources: parentMorph.
]

{ #category : #settings }
DrGDefault class >> networkPassword [
	^ NetworkPassword ifNil: [NetworkPassword := '']
]

{ #category : #settings }
DrGDefault class >> networkPassword: string [
	NetworkPassword := string 
]

{ #category : #resources }
DrGDefault class >> networkResources: parentMorph [
"Open a network resource on the selected share"
|resource|
	^ (resource := self connectToNetwork: parentMorph) 
		ifNil: [nil]
		ifNotNil: [self networkOpenShareOn: resource  with: parentMorph]
	
]

{ #category : #resources }
DrGDefault class >> networkResourcesCreateShare [
"Check the share exsists, if not create it"
	|resource|
	(resource := self connectToNetwork: UIManager default) ifNil: [DrGLoader stop. ^nil].
	(resource shareExists: self networkShare) ifFalse: [
		[resource makeDirectory: self networkShare]
			on: TelnetProtocolError 
			do: [UIManager default abort:  ('I can''t create the share {1}.' translated format: {self networkShare}).
				^ nil]].
	^self networkOpenShareOn: resource with: UIManager default
]

{ #category : #settings }
DrGDefault class >> networkShare [
	^ NetworkDirectory ifNil: [NetworkDirectory := '']
]

{ #category : #settings }
DrGDefault class >> networkShare: string [
	NetworkDirectory := string 
]

{ #category : #settings }
DrGDefault class >> networkType [
	^ NetworkType ifNil: [NetworkType = #ftp]
]

{ #category : #settings }
DrGDefault class >> networkType: symbol [
	NetworkType := symbol
]

{ #category : #settings }
DrGDefault class >> networkUser [
	^ NetworkUser ifNil: [NetworkUser := '']
]

{ #category : #settings }
DrGDefault class >> networkUser: string [
	NetworkUser := string 
]

{ #category : #'as yet unclassified' }
DrGDefault class >> openURI: string [
	plateform openURI: string
]

{ #category : #settings }
DrGDefault class >> premium: boolean [
	plateform premium: boolean 
]

{ #category : #settings }
DrGDefault class >> release: boolean [
	plateform release: boolean 
]

{ #category : #'system startup' }
DrGDefault class >> removeStartUp [
"self removeStartUp"
	Smalltalk removeFromStartUpList: self.
]

{ #category : #'user interface' }
DrGDefault class >> replicateDisplayWidth [
"the replicated area width under mouse"
	^ 80
]

{ #category : #'class initialization' }
DrGDefault class >> reset [
	plateform reset.
	DrGIcons reset.  "flush icons cach"
]

{ #category : #'user interface' }
DrGDefault class >> screenCenter [
	^ (self screenWidth @ self screenHeight) // 2
]

{ #category : #'user interface' }
DrGDefault class >> screenHeight [
	^ plateform screenHeight
]

{ #category : #'user interface' }
DrGDefault class >> screenWidth [
	^ plateform screenWidth
]

{ #category : #'user interface' }
DrGDefault class >> showVirtualKeyboard: boolean [
	plateform ifNotNil: [
		plateform showVirtualKeyboard: boolean.
		boolean ifFalse: [World primaryHand releaseAllFocus]]
]

{ #category : #font }
DrGDefault class >> smallFont [
	^ LogicalFont familyName: self fontName pointSize: self smallFontSize
]

{ #category : #font }
DrGDefault class >> smallFontSize [
	^ plateform smallFontSize
]

{ #category : #'system startup' }
DrGDefault class >> startUp [
	(expirationDate notNil and: [expirationDate < Date today]) ifTrue: 
		[Smalltalk addDeferredStartupAction: 
			[self inform: 'This beta version expired!'.
			Smalltalk quitPrimitive]].
	DrGDefault reset.
	plateform startUp.
	
]

{ #category : #'user interface' }
DrGDefault class >> toolbarIconSize [
	^ plateform toolbarIconSize 
]

{ #category : #settings }
DrGDefault class >> useNetwork [
	^ UseNetwork ifNil: [UseNetwork := false]
]

{ #category : #settings }
DrGDefault class >> useNetwork: aBoolean [
	UseNetwork := aBoolean
]

{ #category : #'as yet unclassified' }
DrGDefault class >> viewXml: filename [ 
	DrGeo serviceViewXml: (self examplesPath / filename) pathString
]

{ #category : #'user interface' }
DrGDefault class >> wheelHeight [
	^ plateform wheelHeight 
]

{ #category : #'user interface' }
DrGDefault class >> wheelWidth [
	^ plateform wheelWidth
]

{ #category : #'user interface' }
DrGDefault class >> wizardExtent [
	^ plateform wizardExtent
]
