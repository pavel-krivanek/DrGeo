Class {
	#name : #ConfigurationOfDrGeo,
	#superclass : #Object,
	#instVars : [
		'project'
	],
	#classVars : [
		'LastVersionLoad'
	],
	#category : #ConfigurationOfDrGeo
}

{ #category : #private }
ConfigurationOfDrGeo class >> bootstrapPackage: aString from: aPath [ 
	| repository version |
	repository := MCHttpRepository
				location: aPath
				user: ''
				password: ''.
	repository
		versionReaderForFileNamed: aString , '.mcz'
		do: [:reader | 
			version := reader version.
			version load.
			version workingCopy repositoryGroup addRepository: repository]
]

{ #category : #private }
ConfigurationOfDrGeo class >> ensureMetacello [
	"Bootstrap Gofer (if necessary), bootstrap ConfigurationOfMetacello (using old Gofer API), then load the latest 
	version of Metacello itself."

	Smalltalk at: #MetacelloProject ifAbsent: [
		Smalltalk at: #Gofer ifAbsent: [
			"Current version of Gofer from which to bootstrap - as of 1.0-beta.21"
			self bootstrapPackage: 'Gofer-Core-lr.115' from: 'http://seaside.gemstone.com/ss/metacello' ].
		Smalltalk at: #Gofer ifPresent: [:goferClass | | gofer |
			gofer := goferClass new
				url: 'http://seaside.gemstone.com/ss/metacello';
				yourself.
			[ gofer addPackage: 'ConfigurationOfMetacello' ] on: Warning do: [:ex | ex resume ].
			gofer load ].
		"load 'default' group of Metacello"
		(Smalltalk at: #ConfigurationOfMetacello) perform: #load ]
]

{ #category : #'metacello tool support' }
ConfigurationOfDrGeo class >> isMetacelloConfig [
	"Answer true and the Metacello tools will operate on you"
	
	^true
]

{ #category : #'metacello tool support' }
ConfigurationOfDrGeo class >> lastMetacelloVersionLoad [
	"Answer the last version loaded and the list of packages loaded for that version."

	LastVersionLoad == nil ifTrue: [ LastVersionLoad := nil -> 'default' ].
	^LastVersionLoad
]

{ #category : #loading }
ConfigurationOfDrGeo class >> load [
	"self load"

	^self project latestVersion load
]

{ #category : #'metacello tool support' }
ConfigurationOfDrGeo class >> metacelloVersion: versionString loads: anArrayOrString [
	"Stash the last version loaded and the list of packages loaded for that version. The list
	 of packages will be used by the tools when doing 'Load Package Version'"

	LastVersionLoad := versionString -> anArrayOrString
]

{ #category : #accessing }
ConfigurationOfDrGeo class >> project [

	^self new project
]

{ #category : #'unloading Metacello' }
ConfigurationOfDrGeo class >> unloadMetacello [

	Smalltalk at: #ConfigurationOfMetacello ifPresent: [:cls | cls unloadMetacello ]
]

{ #category : #2010 }
ConfigurationOfDrGeo >> baseline1008: spec [
	<version: '10.08-baseline'>
	spec for: #pharo do: [
		spec blessing: #baseline.
		spec project: 'XML Parser' with: [
			spec className: 'ConfigurationOfXMLSupport';
			version: '1.0.1';
			loads: #('default');
			file: 'ConfigurationOfXMLSupport';
			repository: 'http://www.squeaksource.com/MetacelloRepository'].
		spec package: 'DrGeoII-Core' with: [
			spec requires: 'XML Parser']]
]

{ #category : #2010 }
ConfigurationOfDrGeo >> baseline1012: spec [
	<version: '10.12-baseline'>
	spec for: #pharo do: [
		spec blessing: #baseline.
		spec project: 'XML Parser' with: [
			spec className: 'ConfigurationOfXMLSupport';
			version: '1.0.1';
			loads: #('default');
			file: 'ConfigurationOfXMLSupport';
			repository: 'http://www.squeaksource.com/MetacelloRepository'].
		spec package: 'DrGeoII-Core' with: [
			spec requires: 'XML Parser']]
]

{ #category : #2010 }
ConfigurationOfDrGeo >> baseline10: spec [
	<version: '1.0-baseline'>
	spec for: #pharo do: [
		spec blessing: #baseline.
		spec project: 'XML Parser' with: [
			spec className: 'ConfigurationOfXMLSupport';
			version: '1.0.1';
			loads: #('default');
			file: 'ConfigurationOfXMLSupport';
			repository: 'http://www.squeaksource.com/MetacelloRepository'].
		spec package: 'DrGeo' with: [spec requires: 'XML Parser']]
]

{ #category : #2013 }
ConfigurationOfDrGeo >> baseline1309: spec [
	<version: '13.09-baseline'>
	spec for: #pharo do: [
		spec blessing: #baseline.
		spec project: 'XML Parser' with: [
			spec className: 'ConfigurationOfXMLSupport';
			version: '1.0.1';
			loads: #('default');
			file: 'ConfigurationOfXMLSupport';
			repository: 'http://smalltalkhub.com/mc/HilaireFernandes/DrGeo/main'].
		spec package: 'DrGeoII-Core' with: [
			spec requires: 'XML Parser']]
]

{ #category : #2014 }
ConfigurationOfDrGeo >> baseline1407: spec [
	<version: '14.07-baseline'>
	
	spec for: #common do: [
		spec blessing: #baseline;
			repository: 'http://smalltalkhub.com/mc/HilaireFernandes/DrGeo/main';
			description: 'Dr. Geo, an interactive geometry application.';
			author: 'HilaireFernandes'.

		spec project: 'XML Parser' with: [
			spec className: 'ConfigurationOfXMLSupport';
			version: '1.0.1';
			loads: #('default');
			file: 'ConfigurationOfXMLSupport';
			repository: 'http://smalltalkhub.com/mc/HilaireFernandes/DrGeo/main'].

		spec project: 'Gettext' with: [ 
			spec className: 'ConfigurationOfGettext';
				version: '1.6';
				loads: #('default');
				file: 'ConfigurationOfGettext';
				repository: 'http://smalltalkhub.com/mc/PharoExtras/Gettext/main'].
		
		spec package: 'DrGeoII-Core' with: [spec requires: #('XML Parser' 'Gettext')].
		
		spec group: 'release' with: #('DrGeoII-Core' 'DrGeo-French' 'DrGeoII-Polymorph' 'DrGeoII-User' 'DrGeoII-Installer');
			group: 'default' with: 'release';
			group: 'development' with: #('release' 'DrGeoII-Test').
		
		]
]

{ #category : #2017 }
ConfigurationOfDrGeo >> baseline1709: spec [
	<version: '17.09-baseline'>
	
	spec for: #common do: [
		spec blessing: #baseline;
			repository: 'http://smalltalkhub.com/mc/HilaireFernandes/DrGeo/main';
			description: 'Dr. Geo, an interactive geometry application.';
			author: 'HilaireFernandes'.

		spec project: 'XML Parser' with: [
			spec className: 'ConfigurationOfXMLSupport';
			version: '1.0.1';
			loads: #('default');
			file: 'ConfigurationOfXMLSupport';
			repository: 'http://smalltalkhub.com/mc/HilaireFernandes/DrGeo/main'].

		spec project: 'Gettext' with: [ 
			spec className: 'ConfigurationOfGettext';
				version: '2.0';
				loads: #('default');
				file: 'ConfigurationOfGettext';
				repository: 'http://smalltalkhub.com/mc/PharoExtras/Gettext/main'].
		
		spec package: 'DrGeoII-Core' with: [spec requires: #('XML Parser' 'Gettext')].
		
		spec group: 'release' with: #('DrGeoII-Core' 'DrGeo-French' 'DrGeoII-Polymorph' 'DrGeoII-User' 'DrGeoII-Installer');
			group: 'default' with: 'release';
			group: 'development' with: #('release' 'DrGeoII-Test').
		
		]
]

{ #category : #'symbolic versions' }
ConfigurationOfDrGeo >> development: spec [
	<symbolicVersion: #'development'>

	spec for: #'common' version: '17.09a'

]

{ #category : #accessing }
ConfigurationOfDrGeo >> project [

	^ project ifNil: [ | constructor |
		"Bootstrap Metacello if it is not already loaded"
		self class ensureMetacello.
		"Construct Metacello project"
		constructor := (Smalltalk at: #MetacelloVersionConstructor) on: self.
		project := constructor project.
		project loadType: #linear. "change to #atomic if desired"
		project ]
]

{ #category : #'symbolic versions' }
ConfigurationOfDrGeo >> stable: spec [
	<symbolicVersion: #'stable'>

	spec for: #'common' version: '17.07a'
]

{ #category : #2010 }
ConfigurationOfDrGeo >> version1008: spec [
	<version: '10.08' imports: #('10.08-baseline')>
	spec for: #common do: [
		spec blessing: #release.
		spec description: 'DrGeo, an interactive geometry framework and application, for Pharo 1.1/Squeak 4.1'.
		spec author: 'HilaireFernandes'.
		spec timestamp:  '2010-07-27T21:23:56+02:00'.
		spec repository: 'http://www.squeaksource.com/DrGeoII'.
		spec package: 'DrGeoII-Core' with: 'DrGeoII-Core-HilaireFernandes.31'].
	spec for: #pharo do: [
		spec package: 'DrGeoII-Polymorph' with: [
			spec  
				file: 'DrGeoII-Polymorph-HilaireFernandes.14';
				requires: 'DrGeoII-Core']].
	spec for: #squeak do: [
		spec package: 'DrGeoII-Etoys' with: [
			spec 
				file: 'DrGeoII-Etoys-HilaireFernandes.10';
				requires: 'DrGeoII-Core']]

]

{ #category : #2010 }
ConfigurationOfDrGeo >> version1012: spec [
	<version: '10.12' imports: #('10.12-baseline')>
	spec for: #common do: [
		spec blessing: #release.
		spec description: 'DrGeo, an interactive geometry framework and application, for Pharo 1.2/Squeak 4.1'.
		spec author: 'HilaireFernandes'.
		spec timestamp:  ' 2010-11-10T22:25:26+01:00'. 
		spec repository: 'http://www.squeaksource.com/DrGeoII'.
		spec package: 'DrGeoII-Core' with: 'DrGeoII-Core-HilaireFernandes.77'].
	spec for: #pharo do: [
		spec package: 'DrGeoII-Polymorph' with: [
			spec  
				file: 'DrGeoII-Polymorph-HilaireFernandes.20';
				requires: 'DrGeoII-Core']].
	spec for: #squeak do: [
		spec package: 'DrGeoII-Etoys' with: [
			spec 
				file: 'DrGeoII-Etoys-HilaireFernandes.10';
				requires: 'DrGeoII-Core']]

]

{ #category : #2010 }
ConfigurationOfDrGeo >> version10: spec [
	<version: '1.0' imports: #('1.0-baseline')>
	spec for: #common do: [
		spec blessing: #release.
		spec description: 'DrGeo, an interactive geometry framework and application, for Pharo 1.0'.
		spec author: 'HilaireFernandes'.
		spec timestamp:  '2010-03-23 21:23'.
		spec repository: 'http://www.squeaksource.com/DrGeoII'.
		spec package: 'DrGeo' with: 'DrGeoII-HilaireFernandes.157']
]

{ #category : #2011 }
ConfigurationOfDrGeo >> version1103: spec [
	<version: '11.03' imports: #('10.12-baseline')>
	spec for: #common do: [
		spec blessing: #release.
		spec description: 'DrGeo, an interactive geometry framework and application, for Pharo 1.2/Squeak 4.1'.
		spec author: 'HilaireFernandes'.
		spec timestamp:  '2011-02-21T19:11:57+01:00'. 
		spec repository: 'http://www.squeaksource.com/DrGeoII'.
		spec package: 'DrGeoII-Core' with: 'DrGeoII-Core-HilaireFernandes.93'].
	spec for: #pharo do: [
		spec package: 'DrGeoII-Polymorph' with: [
			spec  
				file: 'DrGeoII-Polymorph-HilaireFernandes.20';
				requires: 'DrGeoII-Core']].
	spec for: #squeak do: [
		spec package: 'DrGeoII-Etoys' with: [
			spec 
				file: 'DrGeoII-Etoys-HilaireFernandes.10';
				requires: 'DrGeoII-Core']]

]

{ #category : #2011 }
ConfigurationOfDrGeo >> version1106: spec [ 
	<version: '11.06' imports: #('10.12-baseline')>
	spec
		for: #common
		do: [spec blessing: #release.
			spec description: 'DrGeo, an interactive geometry framework and application, for Pharo 1.2/Squeak 4.1'.
			spec author: 'HilaireFernandes'.
			spec timestamp: '2011-05-24T22:38:31+02:00'.
			spec repository: 'http://www.squeaksource.com/DrGeoII'.
			spec package: 'DrGeoII-Core' with: 'DrGeoII-Core-HilaireFernandes.112'].
	spec
		for: #pharo
		do: [spec
				package: 'DrGeoII-Polymorph'
				with: [spec file: 'DrGeoII-Polymorph-HilaireFernandes.24';
						 requires: 'DrGeoII-Core']].
	spec
		for: #squeak
		do: [spec
				package: 'DrGeoII-Etoys'
				with: [spec file: 'DrGeoII-Etoys-HilaireFernandes.10';
						 requires: 'DrGeoII-Core']]
]

{ #category : #2011 }
ConfigurationOfDrGeo >> version1106beta1: spec [ 
	<version: '11.06.beta1' imports: #('10.12-baseline')>
	spec
		for: #common
		do: [spec blessing: #release.
			spec description: 'DrGeo, an interactive geometry framework and application, for Pharo 1.2/Squeak 4.1'.
			spec author: 'HilaireFernandes'.
			spec timestamp: '2011-04-03T12:23:39+02:00'.
			spec repository: 'http://www.squeaksource.com/DrGeoII'.
			spec package: 'DrGeoII-Core' with: 'DrGeoII-Core-HilaireFernandes.97'].
	spec
		for: #pharo
		do: [spec
				package: 'DrGeoII-Polymorph'
				with: [spec file: 'DrGeoII-Polymorph-HilaireFernandes.24';
						 requires: 'DrGeoII-Core']].
	spec
		for: #squeak
		do: [spec
				package: 'DrGeoII-Etoys'
				with: [spec file: 'DrGeoII-Etoys-HilaireFernandes.10';
						 requires: 'DrGeoII-Core']]
]

{ #category : #2011 }
ConfigurationOfDrGeo >> version1106beta2: spec [ 
	<version: '11.06.beta2' imports: #('10.12-baseline')>
	spec
		for: #common
		do: [spec blessing: #release.
			spec description: 'DrGeo, an interactive geometry framework and application, for Pharo 1.2/Squeak 4.1'.
			spec author: 'HilaireFernandes'.
			spec timestamp: '2011-05-15T09:38:45+02:00'.
			spec repository: 'http://www.squeaksource.com/DrGeoII'.
			spec package: 'DrGeoII-Core' with: 'DrGeoII-Core-HilaireFernandes.111'].
	spec
		for: #pharo
		do: [spec
				package: 'DrGeoII-Polymorph'
				with: [spec file: 'DrGeoII-Polymorph-HilaireFernandes.24';
						 requires: 'DrGeoII-Core']].
	spec
		for: #squeak
		do: [spec
				package: 'DrGeoII-Etoys'
				with: [spec file: 'DrGeoII-Etoys-HilaireFernandes.10';
						 requires: 'DrGeoII-Core']]
]

{ #category : #2011 }
ConfigurationOfDrGeo >> version1108: spec [ 
	<version: '11.08' imports: #('10.12-baseline')>
	spec
		for: #common
		do: [spec blessing: #release.
			spec description: 'DrGeo, an interactive geometry framework and application, for Pharo 1.3/Squeak 4.1'.
			spec author: 'HilaireFernandes'.
			spec timestamp: '2011-08-06T10:43:44+02:00'.
			spec repository: 'http://www.squeaksource.com/DrGeoII'.
			spec package: 'DrGeoII-Core' with: 'DrGeoII-Core-HilaireFernandes.166'].
	spec
		for: #pharo
		do: [spec
				package: 'DrGeoII-Polymorph'
				with: [spec file: 'DrGeoII-Polymorph-HilaireFernandes.52';
						 requires: 'DrGeoII-Core'].
			spec
				package: 'DrGeoII-User'
				with: [spec file: 'DrGeoII-User-HilaireFernandes.1';
						 requires: 'DrGeoII-Core']].
	spec
		for: #squeak
		do: [spec
				package: 'DrGeoII-Etoys'
				with: [spec file: 'DrGeoII-Etoys-HilaireFernandes.10';
						 requires: 'DrGeoII-Core']]
]

{ #category : #2011 }
ConfigurationOfDrGeo >> version1108a: spec [ 
	<version: '11.08a' imports: #('10.12-baseline')>
	spec
		for: #common
		do: [spec blessing: #release.
			spec description: 'DrGeo, an interactive geometry framework and application, for Pharo 1.3/Squeak 4.1'.
			spec author: 'HilaireFernandes'.
			spec timestamp: '2011-08-08T00:35:35+02:00'.
			spec repository: 'http://www.squeaksource.com/DrGeoII'.
			spec package: 'DrGeoII-Core' with: 'DrGeoII-Core-HilaireFernandes.171'].
	spec
		for: #pharo
		do: [spec
				package: 'DrGeoII-Polymorph'
				with: [spec file: 'DrGeoII-Polymorph-HilaireFernandes.54';
						 requires: 'DrGeoII-Core'].
			spec
				package: 'DrGeoII-User'
				with: [spec file: 'DrGeoII-User-HilaireFernandes.1';
						 requires: 'DrGeoII-Core']].
	spec
		for: #squeak
		do: [spec
				package: 'DrGeoII-Etoys'
				with: [spec file: 'DrGeoII-Etoys-HilaireFernandes.10';
						 requires: 'DrGeoII-Core']]
]

{ #category : #2011 }
ConfigurationOfDrGeo >> version1112a: spec [ 
	<version: '11.12a' imports: #('10.12-baseline')>
	spec
		for: #common
		do: [spec blessing: #release.
			spec description: 'DrGeo, an interactive geometry framework and application, for Pharo 1.3/Squeak 4.1'.
			spec author: 'HilaireFernandes'.
			spec timestamp: '2011-10-28T15:43:15+02:00'.
			spec repository: 'http://www.squeaksource.com/DrGeoII'.
			spec package: 'DrGeoII-Core' with: 'DrGeoII-Core-HilaireFernandes.175'].
	spec
		for: #pharo
		do: [spec
				package: 'DrGeoII-Polymorph'
				with: [spec file: 'DrGeoII-Polymorph-HilaireFernandes.56';
						 requires: 'DrGeoII-Core'].
			spec
				package: 'DrGeoII-User'
				with: [spec file: 'DrGeoII-User-HilaireFernandes.1';
						 requires: 'DrGeoII-Core']].
	spec
		for: #squeak
		do: [spec
				package: 'DrGeoII-Etoys'
				with: [spec file: 'DrGeoII-Etoys-HilaireFernandes.10';
						 requires: 'DrGeoII-Core']]
]

{ #category : #2011 }
ConfigurationOfDrGeo >> version1112b: spec [ 
	<version: '11.12b' imports: #('10.12-baseline')>
	spec
		for: #common
		do: [spec blessing: #release.
			spec description: 'DrGeo, an interactive geometry framework and application, for Pharo 1.3/Squeak 4.1'.
			spec author: 'HilaireFernandes'.
			spec timestamp: '2011-11-02T08:27:58+01:00'.
			spec repository: 'http://www.squeaksource.com/DrGeoII'.
			spec package: 'DrGeoII-Core' with: 'DrGeoII-Core-HilaireFernandes.179'].
	spec
		for: #pharo
		do: [spec
				package: 'DrGeoII-Polymorph'
				with: [spec file: 'DrGeoII-Polymorph-HilaireFernandes.57';
						 requires: 'DrGeoII-Core'].
			spec
				package: 'DrGeoII-User'
				with: [spec file: 'DrGeoII-User-HilaireFernandes.1';
						 requires: 'DrGeoII-Core']].
	spec
		for: #squeak
		do: [spec
				package: 'DrGeoII-Etoys'
				with: [spec file: 'DrGeoII-Etoys-HilaireFernandes.10';
						 requires: 'DrGeoII-Core']]
]

{ #category : #2011 }
ConfigurationOfDrGeo >> version1112c: spec [ 
	<version: '11.12c' imports: #('10.12-baseline')>
	spec
		for: #common
		do: [spec blessing: #release.
			spec description: 'DrGeo, an interactive geometry framework and application, for Pharo 1.3/Squeak 4.1'.
			spec author: 'HilaireFernandes'.
			spec timestamp: '2011-11-09T10:37:41+01:00'.
			spec repository: 'http://www.squeaksource.com/DrGeoII'.
			spec package: 'DrGeoII-Core' with: 'DrGeoII-Core-HilaireFernandes.184'].
	spec
		for: #pharo
		do: [spec
				package: 'DrGeoII-Polymorph'
				with: [spec file: 'DrGeoII-Polymorph-HilaireFernandes.60';
						 requires: 'DrGeoII-Core'].
			spec
				package: 'DrGeoII-User'
				with: [spec file: 'DrGeoII-User-HilaireFernandes.1';
						 requires: 'DrGeoII-Core']].
	spec
		for: #squeak
		do: [spec
				package: 'DrGeoII-Etoys'
				with: [spec file: 'DrGeoII-Etoys-HilaireFernandes.10';
						 requires: 'DrGeoII-Core']]
]

{ #category : #2011 }
ConfigurationOfDrGeo >> version1112d: spec [ 
	<version: '11.12d' imports: #('10.12-baseline')>
	spec
		for: #common
		do: [spec blessing: #release.
			spec description: 'DrGeo, an interactive geometry framework and application, for Pharo 1.3/Squeak 4.1'.
			spec author: 'HilaireFernandes'.
			spec timestamp: '2011-11-12T22:09:27+01:00'.
			spec repository: 'http://www.squeaksource.com/DrGeoII'.
			spec package: 'DrGeoII-Core' with: 'DrGeoII-Core-HilaireFernandes.188'].
	spec
		for: #pharo
		do: [spec
				package: 'DrGeoII-Polymorph'
				with: [spec file: 'DrGeoII-Polymorph-HilaireFernandes.60';
						 requires: 'DrGeoII-Core'].
			spec
				package: 'DrGeoII-User'
				with: [spec file: 'DrGeoII-User-HilaireFernandes.1';
						 requires: 'DrGeoII-Core']].
	spec
		for: #squeak
		do: [spec
				package: 'DrGeoII-Etoys'
				with: [spec file: 'DrGeoII-Etoys-HilaireFernandes.10';
						 requires: 'DrGeoII-Core']]
]

{ #category : #2011 }
ConfigurationOfDrGeo >> version1112e: spec [ 
	<version: '11.12e' imports: #('10.12-baseline')>
	spec
		for: #common
		do: [spec blessing: #release.
			spec description: 'DrGeo, an interactive geometry framework and application, for Pharo 1.3/Squeak 4.1'.
			spec author: 'HilaireFernandes'.
			spec timestamp: '2011-11-17T14:15:35+01:00'.
			spec repository: 'http://www.squeaksource.com/DrGeoII'.
			spec package: 'DrGeoII-Core' with: 'DrGeoII-Core-HilaireFernandes.193'].
	spec
		for: #pharo
		do: [spec
				package: 'DrGeoII-Polymorph'
				with: [spec file: 'DrGeoII-Polymorph-HilaireFernandes.60';
						 requires: 'DrGeoII-Core'].
			spec
				package: 'DrGeoII-User'
				with: [spec file: 'DrGeoII-User-HilaireFernandes.1';
						 requires: 'DrGeoII-Core']].
	spec
		for: #squeak
		do: [spec
				package: 'DrGeoII-Etoys'
				with: [spec file: 'DrGeoII-Etoys-HilaireFernandes.10';
						 requires: 'DrGeoII-Core']]
]

{ #category : #2011 }
ConfigurationOfDrGeo >> version1112f: spec [ 
	<version: '11.12f' imports: #('10.12-baseline')>
	spec
		for: #common
		do: [spec blessing: #release.
			spec description: 'DrGeo, an interactive geometry framework and application, for Pharo 1.3/Squeak 4.1'.
			spec author: 'HilaireFernandes'.
			spec timestamp: '2011-11-26T11:24:23+01:00'.
			spec repository: 'http://www.squeaksource.com/DrGeoII'.
			spec package: 'DrGeoII-Core' with: 'DrGeoII-Core-HilaireFernandes.198'].
	spec
		for: #pharo
		do: [spec
				package: 'DrGeoII-Polymorph'
				with: [spec file: 'DrGeoII-Polymorph-HilaireFernandes.61';
						 requires: 'DrGeoII-Core'].
			spec
				package: 'DrGeoII-User'
				with: [spec file: 'DrGeoII-User-HilaireFernandes.1';
						 requires: 'DrGeoII-Core']].
	spec
		for: #squeak
		do: [spec
				package: 'DrGeoII-Etoys'
				with: [spec file: 'DrGeoII-Etoys-HilaireFernandes.10';
						 requires: 'DrGeoII-Core']]
]

{ #category : #2011 }
ConfigurationOfDrGeo >> version1112g: spec [ 
	<version: '11.12g' imports: #('10.12-baseline')>
	spec
		for: #common
		do: [spec blessing: #release.
			spec description: 'DrGeo, an interactive geometry framework and application, for Pharo 1.3/Squeak 4.1'.
			spec author: 'HilaireFernandes'.
			spec timestamp: '2011-12-10T09:35:44+01:00'.
			spec repository: 'http://www.squeaksource.com/DrGeoII'.
			spec package: 'DrGeoII-Core' with: 'DrGeoII-Core-HilaireFernandes.203'].
	spec
		for: #pharo
		do: [spec
				package: 'DrGeoII-Polymorph'
				with: [spec file: 'DrGeoII-Polymorph-HilaireFernandes.61';
						 requires: 'DrGeoII-Core'].
			spec
				package: 'DrGeoII-User'
				with: [spec file: 'DrGeoII-User-HilaireFernandes.1';
						 requires: 'DrGeoII-Core']].
	spec
		for: #squeak
		do: [spec
				package: 'DrGeoII-Etoys'
				with: [spec file: 'DrGeoII-Etoys-HilaireFernandes.10';
						 requires: 'DrGeoII-Core']]
]

{ #category : #2011 }
ConfigurationOfDrGeo >> version1112h: spec [ 
	<version: '11.12h' imports: #('10.12-baseline')>
	spec
		for: #common
		do: [spec blessing: #release.
			spec description: 'DrGeo, an interactive geometry framework and application, for Pharo 1.3/Squeak 4.1'.
			spec author: 'HilaireFernandes'.
			spec timestamp: '2011-12-10T11:40:04+01:00'.
			spec repository: 'http://www.squeaksource.com/DrGeoII'.
			spec package: 'DrGeoII-Core' with: 'DrGeoII-Core-HilaireFernandes.204'].
	spec
		for: #pharo
		do: [spec
				package: 'DrGeoII-Polymorph'
				with: [spec file: 'DrGeoII-Polymorph-HilaireFernandes.61';
						 requires: 'DrGeoII-Core'].
			spec
				package: 'DrGeoII-User'
				with: [spec file: 'DrGeoII-User-HilaireFernandes.1';
						 requires: 'DrGeoII-Core']].
	spec
		for: #squeak
		do: [spec
				package: 'DrGeoII-Etoys'
				with: [spec file: 'DrGeoII-Etoys-HilaireFernandes.10';
						 requires: 'DrGeoII-Core']]
]

{ #category : #2012 }
ConfigurationOfDrGeo >> version1203a: spec [ 
	<version: '12.03a' imports: #('10.12-baseline')>
	spec
		for: #common
		do: [spec blessing: #release.
			spec description: 'DrGeo, an interactive geometry framework and application, for Pharo 1.3/Squeak 4.1'.
			spec author: 'HilaireFernandes'.
			spec timestamp: '2011-12-26T18:42:27+01:00'.
			spec repository: 'http://www.squeaksource.com/DrGeoII'.
			spec package: 'DrGeoII-Core' with: 'DrGeoII-Core-HilaireFernandes.214'].
	spec
		for: #pharo
		do: [spec
				package: 'DrGeoII-Polymorph'
				with: [spec file: 'DrGeoII-Polymorph-HilaireFernandes.68';
						 requires: 'DrGeoII-Core'].
			spec
				package: 'DrGeoII-User'
				with: [spec file: 'DrGeoII-User-HilaireFernandes.1';
						 requires: 'DrGeoII-Core']].
	spec
		for: #squeak
		do: [spec
				package: 'DrGeoII-Etoys'
				with: [spec file: 'DrGeoII-Etoys-HilaireFernandes.10';
						 requires: 'DrGeoII-Core']]
]

{ #category : #2012 }
ConfigurationOfDrGeo >> version1203b: spec [ 
	<version: '12.03b' imports: #('10.12-baseline')>
	spec
		for: #common
		do: [spec blessing: #release.
			spec description: 'DrGeo, an interactive geometry framework and application, for Pharo 1.3/Squeak 4.1'.
			spec author: 'HilaireFernandes'.
			spec timestamp: '2012-01-11T20:23:44+01:00'.
			spec repository: 'http://www.squeaksource.com/DrGeoII'.
			spec package: 'DrGeoII-Core' with: 'DrGeoII-Core-HilaireFernandes.223'].
	spec
		for: #pharo
		do: [spec
				package: 'DrGeoII-Polymorph'
				with: [spec file: 'DrGeoII-Polymorph-HilaireFernandes.69';
						 requires: 'DrGeoII-Core'].
			spec
				package: 'DrGeoII-User'
				with: [spec file: 'DrGeoII-User-HilaireFernandes.1';
						 requires: 'DrGeoII-Core']].
	spec
		for: #squeak
		do: [spec
				package: 'DrGeoII-Etoys'
				with: [spec file: 'DrGeoII-Etoys-HilaireFernandes.10';
						 requires: 'DrGeoII-Core']]
]

{ #category : #2012 }
ConfigurationOfDrGeo >> version1203c: spec [ 
	<version: '12.03c' imports: #('10.12-baseline')>
	spec
		for: #common
		do: [spec blessing: #release.
			spec description: 'DrGeo, an interactive geometry framework and application, for Pharo 1.4'.
			spec author: 'HilaireFernandes'.
			spec timestamp: '2012-04-09T22:47:00.521+02:00'.
			spec repository: 'http://www.squeaksource.com/DrGeoII'.
			spec package: 'DrGeoII-Core' with: 'DrGeoII-Core-HilaireFernandes.279'].
	spec
		for: #pharo
		do: [spec
				package: 'DrGeoII-Polymorph'
				with: [spec file: 'DrGeoII-Polymorph-HilaireFernandes.93';
						 requires: 'DrGeoII-Core'].
			spec
				package: 'DrGeoII-User'
				with: [spec file: 'DrGeoII-User-HilaireFernandes.1';
						 requires: 'DrGeoII-Core']].
	spec
		for: #squeak
		do: [spec
				package: 'DrGeoII-Etoys'
				with: [spec file: 'DrGeoII-Etoys-HilaireFernandes.10';
						 requires: 'DrGeoII-Core']]
]

{ #category : #2012 }
ConfigurationOfDrGeo >> version1204a: spec [ 
	<version: '12.04a' imports: #('10.12-baseline')>
	spec
		for: #common
		do: [spec blessing: #release.
			spec description: 'DrGeo, an interactive geometry framework and application, for Pharo 1.4'.
			spec author: 'HilaireFernandes'.
			spec timestamp: '2012-04-13T10:12:52.924+02:00'.
			spec repository: 'http://www.squeaksource.com/DrGeoII'.
			spec package: 'DrGeoII-Core' with: 'DrGeoII-Core-HilaireFernandes.279'].
	spec
		for: #pharo
		do: [spec
				package: 'DrGeoII-Polymorph'
				with: [spec file: 'DrGeoII-Polymorph-HilaireFernandes.93';
						 requires: 'DrGeoII-Core'].
			spec
				package: 'DrGeoII-User'
				with: [spec file: 'DrGeoII-User-HilaireFernandes.1';
						 requires: 'DrGeoII-Core']].
	spec
		for: #squeak
		do: [spec
				package: 'DrGeoII-Etoys'
				with: [spec file: 'DrGeoII-Etoys-HilaireFernandes.10';
						 requires: 'DrGeoII-Core']]
]

{ #category : #2012 }
ConfigurationOfDrGeo >> version1204b: spec [ 
	<version: '12.04b' imports: #('10.12-baseline')>
	spec
		for: #common
		do: [spec blessing: #release.
			spec description: 'DrGeo, an interactive geometry framework and application, for Pharo 1.4'.
			spec author: 'HilaireFernandes'.
			spec timestamp: '2012-04-13T10:12:52.924+02:00'.
			spec repository: 'http://www.squeaksource.com/DrGeoII'.
			spec package: 'DrGeoII-Core' with: 'DrGeoII-Core-HilaireFernandes.280'].
	spec
		for: #pharo
		do: [spec
				package: 'DrGeoII-Polymorph'
				with: [spec file: 'DrGeoII-Polymorph-HilaireFernandes.93';
						 requires: 'DrGeoII-Core'].
			spec
				package: 'DrGeoII-User'
				with: [spec file: 'DrGeoII-User-HilaireFernandes.1';
						 requires: 'DrGeoII-Core']].
	spec
		for: #squeak
		do: [spec
				package: 'DrGeoII-Etoys'
				with: [spec file: 'DrGeoII-Etoys-HilaireFernandes.10';
						 requires: 'DrGeoII-Core']]
]

{ #category : #2012 }
ConfigurationOfDrGeo >> version1204c: spec [ 
	<version: '12.04c' imports: #('10.12-baseline')>
	spec
		for: #common
		do: [spec blessing: #release.
			spec description: 'DrGeo, an interactive geometry framework and application, for Pharo 1.4'.
			spec author: 'HilaireFernandes'.
			spec timestamp: '2012-04-14T16:15:21.219+02:00'.
			spec repository: 'http://www.squeaksource.com/DrGeoII'.
			spec package: 'DrGeoII-Core' with: 'DrGeoII-Core-HilaireFernandes.283'].
	spec
		for: #pharo
		do: [spec
				package: 'DrGeoII-Polymorph'
				with: [spec file: 'DrGeoII-Polymorph-HilaireFernandes.93';
						 requires: 'DrGeoII-Core'].
			spec
				package: 'DrGeoII-User'
				with: [spec file: 'DrGeoII-User-HilaireFernandes.1';
						 requires: 'DrGeoII-Core']].
	spec
		for: #squeak
		do: [spec
				package: 'DrGeoII-Etoys'
				with: [spec file: 'DrGeoII-Etoys-HilaireFernandes.10';
						 requires: 'DrGeoII-Core']]
]

{ #category : #2012 }
ConfigurationOfDrGeo >> version1204d: spec [ 
	<version: '12.04d' imports: #('10.12-baseline')>
	spec
		for: #common
		do: [spec blessing: #release.
			spec description: 'DrGeo, an interactive geometry framework and application, for Pharo 1.4'.
			spec author: 'HilaireFernandes'.
			spec timestamp: '2012-04-15T10:39:47.088+02:00'.
			spec repository: 'http://www.squeaksource.com/DrGeoII'.
			spec package: 'DrGeoII-Core' with: 'DrGeoII-Core-HilaireFernandes.284'].
	spec
		for: #pharo
		do: [spec
				package: 'DrGeoII-Polymorph'
				with: [spec file: 'DrGeoII-Polymorph-HilaireFernandes.93';
						 requires: 'DrGeoII-Core'].
			spec
				package: 'DrGeoII-User'
				with: [spec file: 'DrGeoII-User-HilaireFernandes.1';
						 requires: 'DrGeoII-Core']].
	spec
		for: #squeak
		do: [spec
				package: 'DrGeoII-Etoys'
				with: [spec file: 'DrGeoII-Etoys-HilaireFernandes.10';
						 requires: 'DrGeoII-Core']]
]

{ #category : #2012 }
ConfigurationOfDrGeo >> version1206: spec [ 
	<version: '12.06' imports: #('10.12-baseline')>
	spec
		for: #common
		do: [spec blessing: #release.
			spec description: 'DrGeo, an interactive geometry framework and application, for Pharo 1.4'.
			spec author: 'HilaireFernandes'.
			spec timestamp: '2012-05-04T22:38:24.642+02:00'.
			spec repository: 'http://www.squeaksource.com/DrGeoII'.
			spec package: 'DrGeoII-Core' with: 'DrGeoII-Core-HilaireFernandes.299'].
	spec
		for: #pharo
		do: [spec
				package: 'DrGeoII-Polymorph'
				with: [spec file: 'DrGeoII-Polymorph-HilaireFernandes.103';
						 requires: 'DrGeoII-Core'].
			spec
				package: 'DrGeoII-User'
				with: [spec file: 'DrGeoII-User-HilaireFernandes.1';
						 requires: 'DrGeoII-Core']].
	spec
		for: #squeak
		do: [spec
				package: 'DrGeoII-Etoys'
				with: [spec file: 'DrGeoII-Etoys-HilaireFernandes.10';
						 requires: 'DrGeoII-Core']]
]

{ #category : #2012 }
ConfigurationOfDrGeo >> version1207: spec [ 
	<version: '12.07' imports: #('10.12-baseline')>
	spec
		for: #common
		do: [spec blessing: #release.
			spec description: 'DrGeo, an interactive geometry framework and application, for Pharo 1.4'.
			spec author: 'HilaireFernandes'.
			spec timestamp: '2012-05-26T15:04:43.829+02:00'.
			spec repository: 'http://www.squeaksource.com/DrGeoII'.
			spec package: 'DrGeoII-Core' with: 'DrGeoII-Core-HilaireFernandes.319'].
	spec
		for: #pharo
		do: [spec
				package: 'DrGeoII-Polymorph'
				with: [spec file: 'DrGeoII-Polymorph-HilaireFernandes.106';
						 requires: 'DrGeoII-Core'].
			spec
				package: 'DrGeoII-User'
				with: [spec file: 'DrGeoII-User-HilaireFernandes.1';
						 requires: 'DrGeoII-Core']].
	spec
		for: #squeak
		do: [spec
				package: 'DrGeoII-Etoys'
				with: [spec file: 'DrGeoII-Etoys-HilaireFernandes.10';
						 requires: 'DrGeoII-Core']]
]

{ #category : #2012 }
ConfigurationOfDrGeo >> version1207a: spec [ 
	<version: '12.07a' imports: #('10.12-baseline')>
	spec
		for: #common
		do: [spec blessing: #release.
			spec description: 'DrGeo, an interactive geometry framework and application, for Pharo 1.4'.
			spec author: 'HilaireFernandes'.
			spec timestamp: '2012-07-02T08:41:04.826+02:00'.
			spec repository: 'http://www.squeaksource.com/DrGeoII'.
			spec package: 'DrGeoII-Core' with: 'DrGeoII-Core-HilaireFernandes.338'].
	spec
		for: #pharo
		do: [spec
				package: 'DrGeoII-Polymorph'
				with: [spec file: 'DrGeoII-Polymorph-HilaireFernandes.107';
						 requires: 'DrGeoII-Core'].
			spec
				package: 'DrGeoII-User'
				with: [spec file: 'DrGeoII-User-HilaireFernandes.4';
						 requires: 'DrGeoII-Core']].
	spec
		for: #squeak
		do: [spec
				package: 'DrGeoII-Etoys'
				with: [spec file: 'DrGeoII-Etoys-HilaireFernandes.10';
						 requires: 'DrGeoII-Core']]
]

{ #category : #2012 }
ConfigurationOfDrGeo >> version1210a: spec [ 
	<version: '12.10a' imports: #('10.12-baseline')>
	spec
		for: #common
		do: [spec blessing: #release.
			spec description: 'DrGeo, an interactive geometry framework and application, for Pharo 1.4'.
			spec author: 'HilaireFernandes'.
			spec timestamp: '2012-09-05T16:10:32.11+02:00'.
			spec repository: 'http://www.squeaksource.com/DrGeoII'.
			spec package: 'DrGeoII-Core' with: 'DrGeoII-Core-HilaireFernandes.374'].
	spec
		for: #pharo
		do: [spec
				package: 'DrGeoII-Polymorph'
				with: [spec file: 'DrGeoII-Polymorph-HilaireFernandes.116';
						 requires: 'DrGeoII-Core'].
			spec
				package: 'DrGeoII-User'
				with: [spec file: 'DrGeoII-User-HilaireFernandes.4';
						 requires: 'DrGeoII-Core']].
	spec
		for: #squeak
		do: [spec
				package: 'DrGeoII-Etoys'
				with: [spec file: 'DrGeoII-Etoys-HilaireFernandes.10';
						 requires: 'DrGeoII-Core']]
]

{ #category : #2012 }
ConfigurationOfDrGeo >> version1212a: spec [ 
	<version: '12.12a' imports: #('10.12-baseline')>
	spec
		for: #common
		do: [spec blessing: #release.
			spec description: 'DrGeo, an interactive geometry framework and application, for Pharo 1.4'.
			spec author: 'HilaireFernandes'.
			spec timestamp: '2012-12-29T06:54:57.767+01:00'.
			spec repository: 'http://www.squeaksource.com/DrGeoII'.
			spec package: 'DrGeoII-Core' with: 'DrGeoII-Core-HilaireFernandes.395'].
	spec
		for: #pharo
		do: [spec
				package: 'DrGeoII-Polymorph'
				with: [spec file: 'DrGeoII-Polymorph-HilaireFernandes.126';
						 requires: 'DrGeoII-Core'].
			spec
				package: 'DrGeoII-User'
				with: [spec file: 'DrGeoII-User-HilaireFernandes.4';
						 requires: 'DrGeoII-Core']].
	spec
		for: #squeak
		do: [spec
				package: 'DrGeoII-Etoys'
				with: [spec file: 'DrGeoII-Etoys-HilaireFernandes.10';
						 requires: 'DrGeoII-Core']]
]

{ #category : #2013 }
ConfigurationOfDrGeo >> version1304a: spec [ 
	<version: '13.04a' imports: #('10.12-baseline')>
	spec
		for: #common
		do: [spec blessing: #release.
			spec description: 'DrGeo, an interactive geometry framework and application, for Pharo 1.4'.
			spec author: 'HilaireFernandes'.
			spec timestamp: '2013-04-01T14:35:51.432+02:00'.
			spec repository: 'http://www.squeaksource.com/DrGeoII'.
			spec package: 'DrGeoII-Core' with: 'DrGeoII-Core-HilaireFernandes.430'].
	spec
		for: #pharo
		do: [spec
				package: 'DrGeoII-Polymorph'
				with: [spec file: 'DrGeoII-Polymorph-HilaireFernandes.129';
						 requires: 'DrGeoII-Core'].
			spec
				package: 'DrGeoII-User'
				with: [spec file: 'DrGeoII-User-HilaireFernandes.4';
						 requires: 'DrGeoII-Core']].
	spec
		for: #squeak
		do: [spec
				package: 'DrGeoII-Etoys'
				with: [spec file: 'DrGeoII-Etoys-HilaireFernandes.10';
						 requires: 'DrGeoII-Core']]
]

{ #category : #2013 }
ConfigurationOfDrGeo >> version1306a: spec [ 
	<version: '13.06a' imports: #('10.12-baseline')>
	spec
		for: #common
		do: [spec blessing: #release.
			spec description: 'DrGeo, an interactive geometry framework and application, for Pharo 1.4'.
			spec author: 'HilaireFernandes'.
			spec timestamp: '2013-05-21T17:16:32.464+02:00'.
			spec repository: 'http://www.squeaksource.com/DrGeoII'.
			spec package: 'DrGeoII-Core' with: 'DrGeoII-Core-HilaireFernandes.458'].
	spec
		for: #pharo
		do: [spec
				package: 'DrGeoII-Polymorph'
				with: [spec file: 'DrGeoII-Polymorph-HilaireFernandes.140';
						 requires: 'DrGeoII-Core'].
			spec
				package: 'DrGeoII-User'
				with: [spec file: 'DrGeoII-User-HilaireFernandes.6';
						 requires: 'DrGeoII-Core']].
	spec
		for: #squeak
		do: [spec
				package: 'DrGeoII-Etoys'
				with: [spec file: 'DrGeoII-Etoys-HilaireFernandes.10';
						 requires: 'DrGeoII-Core']]
]

{ #category : #2013 }
ConfigurationOfDrGeo >> version1306b: spec [ 
	<version: '13.06b' imports: #('13.09-baseline')>
	spec
		for: #common
		do: [spec blessing: #release.
			spec description: 'DrGeo, an interactive geometry framework and application, for Pharo 1.4'.
			spec author: 'HilaireFernandes'.
			spec timestamp: '2013-06-04T19:09:28.836+02:00'.
			spec repository: 'http://smalltalkhub.com/mc/HilaireFernandes/DrGeo/main'.
			spec package: 'DrGeoII-Core' with: 'DrGeoII-Core-HilaireFernandes.458'].
	spec
		for: #pharo
		do: [spec
				package: 'DrGeoII-Polymorph'
				with: [spec file: 'DrGeoII-Polymorph-HilaireFernandes.140';
						 requires: 'DrGeoII-Core'].
			spec
				package: 'DrGeoII-User'
				with: [spec file: 'DrGeoII-User-HilaireFernandes.6';
						 requires: 'DrGeoII-Core']].
	spec
		for: #squeak
		do: [spec
				package: 'DrGeoII-Etoys'
				with: [spec file: 'DrGeoII-Etoys-HilaireFernandes.10';
						 requires: 'DrGeoII-Core']]
]

{ #category : #2013 }
ConfigurationOfDrGeo >> version1308a: spec [ 
	<version: '13.08a' imports: #('13.09-baseline')>
	spec
		for: #common
		do: [spec blessing: #release.
			spec description: 'DrGeo, an interactive geometry framework and application, for Pharo 1.4'.
			spec author: 'HilaireFernandes'.
			spec timestamp: '2013-07-06T10:05:14.232+02:00'.
			spec repository: 'http://smalltalkhub.com/mc/HilaireFernandes/DrGeo/main'.
			spec package: 'DrGeoII-Core' with: 'DrGeoII-Core-HilaireFernandes.471'].
	spec
		for: #pharo
		do: [spec
				package: 'DrGeoII-Polymorph'
				with: [spec file: 'DrGeoII-Polymorph-HilaireFernandes.140';
						 requires: 'DrGeoII-Core'].
			spec
				package: 'DrGeoII-User'
				with: [spec file: 'DrGeoII-User-HilaireFernandes.6';
						 requires: 'DrGeoII-Core']].
	spec
		for: #squeak
		do: [spec
				package: 'DrGeoII-Etoys'
				with: [spec file: 'DrGeoII-Etoys-HilaireFernandes.10';
						 requires: 'DrGeoII-Core']]
]

{ #category : #2013 }
ConfigurationOfDrGeo >> version1310a: spec [ 
	<version: '13.10a' imports: #('13.09-baseline')>
	spec
		for: #common
		do: [spec blessing: #release.
			spec description: 'DrGeo, an interactive geometry framework and application, for Pharo 1.4'.
			spec author: 'HilaireFernandes'.
			spec timestamp: '2013-09-08T20:21:41.233+08:00'.
			spec repository: 'http://smalltalkhub.com/mc/HilaireFernandes/DrGeo/main'.
			spec package: 'DrGeoII-Core' with: 'DrGeoII-Core-HilaireFernandes.477'].
	spec
		for: #pharo
		do: [spec
				package: 'DrGeoII-Polymorph'
				with: [spec file: 'DrGeoII-Polymorph-HilaireFernandes.141';
						 requires: 'DrGeoII-Core'].
			spec
				package: 'DrGeoII-User'
				with: [spec file: 'DrGeoII-User-HilaireFernandes.6';
						 requires: 'DrGeoII-Core']].
	spec
		for: #squeak
		do: [spec
				package: 'DrGeoII-Etoys'
				with: [spec file: 'DrGeoII-Etoys-HilaireFernandes.10';
						 requires: 'DrGeoII-Core']]
]

{ #category : #2014 }
ConfigurationOfDrGeo >> version1407a: spec [ 
	<version: '14.07a' imports: #('14.07-baseline') >
	
	spec for: #common do: [
		spec blessing: #development.
		spec description: '14.07a release'.
		
		spec package: 'DrGeoII-Core' with: 'DrGeoII-Core-HilaireFernandes.519'.
		spec package: 'DrGeoII-Polymorph' with: 'DrGeoII-Polymorph-HilaireFernandes.147'.
		spec package: 'DrGeoII-User' with: 'DrGeoII-User-HilaireFernandes.7'.
		spec package: 'DrGeoII-Installer' with: 'DrGeoII-Installer-HilaireFernandes.14'.
		spec package: 'DrGeoII-Test' with: 'DrGeoII-Test-HilaireFernandes.10']
	


]

{ #category : #2014 }
ConfigurationOfDrGeo >> version1407b: spec [ 
	<version: '14.07b' imports: #('14.07-baseline') >
	
	spec for: #common do: [
		spec blessing: #development.
		spec description: '14.07a release'.
		
		spec package: 'DrGeoII-Core' with: 'DrGeoII-Core-HilaireFernandes.522'.
		spec package: 'DrGeoII-Polymorph' with: 'DrGeoII-Polymorph-HilaireFernandes.149'.
		spec package: 'DrGeoII-User' with: 'DrGeoII-User-HilaireFernandes.7'.
		spec package: 'DrGeoII-Installer' with: 'DrGeoII-Installer-HilaireFernandes.15'.
		spec package: 'DrGeoII-Test' with: 'DrGeoII-Test-HilaireFernandes.10']
	


]

{ #category : #2014 }
ConfigurationOfDrGeo >> version1407c: spec [ 
	<version: '14.07c' imports: #('14.07-baseline') >
	
	spec for: #common do: [
		spec blessing: #development.
		spec description: '14.07c release'.
		
		spec package: 'DrGeoII-Core' with: 'DrGeoII-Core-HilaireFernandes.524'.
		spec package: 'DrGeoII-Polymorph' with: 'DrGeoII-Polymorph-HilaireFernandes.152'.
		spec package: 'DrGeoII-User' with: 'DrGeoII-User-HilaireFernandes.7'.
		spec package: 'DrGeoII-Installer' with: 'DrGeoII-Installer-HilaireFernandes.15'.
		spec package: 'DrGeoII-Test' with: 'DrGeoII-Test-HilaireFernandes.10']
	


]

{ #category : #2014 }
ConfigurationOfDrGeo >> version1407d: spec [ 
	<version: '14.07d' imports: #('14.07-baseline') >
	
	spec for: #common do: [
		spec blessing: #development.
		spec description: '14.07d release'.
		
		spec package: 'DrGeoII-Core' with: 'DrGeoII-Core-HilaireFernandes.527'.
		spec package: 'DrGeoII-Polymorph' with: 'DrGeoII-Polymorph-HilaireFernandes.153'.
		spec package: 'DrGeoII-User' with: 'DrGeoII-User-HilaireFernandes.7'.
		spec package: 'DrGeoII-Installer' with: 'DrGeoII-Installer-HilaireFernandes.15'.
		spec package: 'DrGeoII-Test' with: 'DrGeoII-Test-HilaireFernandes.10']
	


]

{ #category : #2014 }
ConfigurationOfDrGeo >> version1410a: spec [ 
	<version: '14.10a' imports: #('14.07-baseline') >
	
	spec for: #common do: [
		spec blessing: #development.
		spec description: '14.10 release'.
		
		spec package: 'DrGeoII-Core' with: 'DrGeoII-Core-HilaireFernandes.539'.
		spec package: 'DrGeoII-Polymorph' with: 'DrGeoII-Polymorph-HilaireFernandes.154'.
		spec package: 'DrGeoII-User' with: 'DrGeoII-User-HilaireFernandes.7'.
		spec package: 'DrGeoII-Installer' with: 'DrGeoII-Installer-HilaireFernandes.29'.
		spec package: 'DrGeoII-Test' with: 'DrGeoII-Test-HilaireFernandes.10']
	


]

{ #category : #2014 }
ConfigurationOfDrGeo >> version1412a: spec [ 
	<version: '14.12b' imports: #('14.07-baseline') >
	
	spec for: #common do: [
		spec blessing: #development.
		spec description: '14.12 release'.
		
		spec package: 'DrGeoII-Core' with: 'DrGeoII-Core-HilaireFernandes.560'.
		spec package: 'DrGeoII-Polymorph' with: 'DrGeoII-Polymorph-HilaireFernandes.163'.
		spec package: 'DrGeoII-User' with: 'DrGeoII-User-HilaireFernandes.10'.
		spec package: 'DrGeoII-Installer' with: 'DrGeoII-Installer-HilaireFernandes.29'.
		spec package: 'DrGeoII-Test' with: 'DrGeoII-Test-HilaireFernandes.10']
	


]

{ #category : #2015 }
ConfigurationOfDrGeo >> version1504a: spec [ 
	<version: '15.04a' imports: #('14.07-baseline') >
	
	spec for: #common do: [
		spec blessing: #development.
		spec description: '15.04 release'.
		
		spec package: 'DrGeoII-Core' with: 'DrGeoII-Core-HilaireFernandes.570'.
		spec package: 'DrGeoII-Polymorph' with: 'DrGeoII-Polymorph-HilaireFernandes.164'.
		spec package: 'DrGeoII-User' with: 'DrGeoII-User-HilaireFernandes.13'.
		spec package: 'DrGeoII-Installer' with: 'DrGeoII-Installer-HilaireFernandes.30'.
		spec package: 'DrGeoII-Test' with: 'DrGeoII-Test-HilaireFernandes.10']
	


]

{ #category : #2015 }
ConfigurationOfDrGeo >> version1507a: spec [ 
	<version: '15.07a' imports: #('14.07-baseline') >
	spec for: #common do: [
		spec blessing: #development.
		spec description: '15.07 release'.
		
		spec package: 'DrGeoII-Core' with: 'DrGeoII-Core-HilaireFernandes.582'.
		spec package: 'DrGeoII-Polymorph' with: 'DrGeoII-Polymorph-HilaireFernandes.166'.
		spec package: 'DrGeoII-User' with: 'DrGeoII-User-HilaireFernandes.16'.
		spec package: 'DrGeoII-Installer' with: 'DrGeoII-Installer-HilaireFernandes.32'.
		spec package: 'DrGeoII-Test' with: 'DrGeoII-Test-HilaireFernandes.10']
]

{ #category : #2015 }
ConfigurationOfDrGeo >> version1509a: spec [ 
	<version: '15.09a' imports: #('14.07-baseline') >
	spec for: #common do: [
		spec blessing: #development.
		spec description: '15.09 release'.
		
		spec package: 'DrGeoII-Core' with: 'DrGeoII-Core-HilaireFernandes.587'.
		spec package: 'DrGeoII-Polymorph' with: 'DrGeoII-Polymorph-HilaireFernandes.166'.
		spec package: 'DrGeoII-User' with: 'DrGeoII-User-HilaireFernandes.16'.
		spec package: 'DrGeoII-Installer' with: 'DrGeoII-Installer-HilaireFernandes.32'.
		spec package: 'DrGeoII-Test' with: 'DrGeoII-Test-HilaireFernandes.10']
]

{ #category : #2015 }
ConfigurationOfDrGeo >> version1512a: spec [ 
	<version: '15.12a' imports: #('14.07-baseline') >
	spec for: #common do: [
		spec blessing: #development.
		spec description: '15.12 release'.
		
		spec package: 'DrGeoII-Core' with: 'DrGeoII-Core-HilaireFernandes.598'.
		spec package: 'DrGeoII-Polymorph' with: 'DrGeoII-Polymorph-HilaireFernandes.168'.
		spec package: 'DrGeoII-User' with: 'DrGeoII-User-HilaireFernandes.16'.
		spec package: 'DrGeoII-Installer' with: 'DrGeoII-Installer-HilaireFernandes.33'.
		spec package: 'DrGeoII-Test' with: 'DrGeoII-Test-HilaireFernandes.10']
]

{ #category : #2016 }
ConfigurationOfDrGeo >> version1603a: spec [ 
	<version: '16.03a' imports: #('14.07-baseline') >
	spec for: #common do: [
		spec blessing: #development.
		spec description: '16.03 alpha a'.
		
		spec package: 'DrGeoII-Core' with: 'DrGeoII-Core-HilaireFernandes.604'.
		spec package: 'DrGeoII-Polymorph' with: 'DrGeoII-Polymorph-HilaireFernandes.168'.
		spec package: 'DrGeoII-User' with: 'DrGeoII-User-HilaireFernandes.16'.
		spec package: 'DrGeoII-Installer' with: 'DrGeoII-Installer-HilaireFernandes.33'.
		spec package: 'DrGeoII-Test' with: 'DrGeoII-Test-HilaireFernandes.10']
]

{ #category : #2016 }
ConfigurationOfDrGeo >> version1603b: spec [ 
	<version: '16.03b' imports: #('14.07-baseline') >
	spec for: #common do: [
		spec blessing: #development.
		spec description: '16.03 alpha b'.
		
		spec package: 'DrGeoII-Core' with: 'DrGeoII-Core-HilaireFernandes.615'.
		spec package: 'DrGeoII-Polymorph' with: 'DrGeoII-Polymorph-HilaireFernandes.169'.
		spec package: 'DrGeoII-User' with: 'DrGeoII-User-HilaireFernandes.16'.
		spec package: 'DrGeoII-Installer' with: 'DrGeoII-Installer-HilaireFernandes.33'.
		spec package: 'DrGeoII-Test' with: 'DrGeoII-Test-HilaireFernandes.10']
]

{ #category : #2016 }
ConfigurationOfDrGeo >> version1603c: spec [ 
	<version: '16.03c' imports: #('14.07-baseline') >
	spec for: #common do: [
		spec blessing: #development.
		spec description: '16.03c'.
		
		spec package: 'DrGeoII-Core' with: 'DrGeoII-Core-HilaireFernandes.619'.
		spec package: 'DrGeoII-Polymorph' with: 'DrGeoII-Polymorph-HilaireFernandes.170'.
		spec package: 'DrGeoII-User' with: 'DrGeoII-User-HilaireFernandes.16'.
		spec package: 'DrGeoII-Installer' with: 'DrGeoII-Installer-HilaireFernandes.33'.
		spec package: 'DrGeoII-Test' with: 'DrGeoII-Test-HilaireFernandes.10']
]

{ #category : #2016 }
ConfigurationOfDrGeo >> version1610a: spec [ 
	<version: '16.10a' imports: #('14.07-baseline') >
	spec for: #common do: [
		spec blessing: #development.
		spec description: '16.10a'.
		
		spec package: 'DrGeoII-Core' with: 'DrGeoII-Core-HilaireFernandes.623'.
		spec package: 'DrGeoII-Polymorph' with: 'DrGeoII-Polymorph-HilaireFernandes.170'.
		spec package: 'DrGeoII-User' with: 'DrGeoII-User-HilaireFernandes.16'.
		spec package: 'DrGeo-French' with: 'DrGeo-French-HilaireFernandes.8'.
		spec package: 'DrGeoII-Installer' with: 'DrGeoII-Installer-HilaireFernandes.33'.
		spec package: 'DrGeoII-Test' with: 'DrGeoII-Test-HilaireFernandes.10']
]

{ #category : #2017 }
ConfigurationOfDrGeo >> version1707a: spec [ 
	<version: '17.07a' imports: #('14.07-baseline') >
	spec for: #common do: [
		spec blessing: #development.
		spec description: '17.07a'.
		
		spec package: 'DrGeoII-Core' with: 'DrGeoII-Core-HilaireFernandes.626'.
		spec package: 'DrGeoII-Polymorph' with: 'DrGeoII-Polymorph-HilaireFernandes.170'.
		spec package: 'DrGeoII-User' with: 'DrGeoII-User-HilaireFernandes.19'.
		spec package: 'DrGeo-French' with: 'DrGeo-French-HilaireFernandes.9'.
		spec package: 'DrGeoII-Installer' with: 'DrGeoII-Installer-HilaireFernandes.33'.
		spec package: 'DrGeoII-Test' with: 'DrGeoII-Test-HilaireFernandes.10']
]

{ #category : #2017 }
ConfigurationOfDrGeo >> version1709a: spec [ 
	<version: '17.09a' imports: #('17.09-baseline') >
	spec for: #common do: [
		spec blessing: #development.
		spec description: '17.09a'.
		
		spec package: 'DrGeoII-Core' with: 'DrGeoII-Core-HilaireFernandes.634'.
		spec package: 'DrGeoII-Polymorph' with: 'DrGeoII-Polymorph-HilaireFernandes.176'.
		spec package: 'DrGeoII-User' with: 'DrGeoII-User-HilaireFernandes.19'.
		spec package: 'DrGeo-French' with: 'DrGeo-French-HilaireFernandes.9'.
		spec package: 'DrGeoII-Installer' with: 'DrGeoII-Installer-HilaireFernandes.33'.
		spec package: 'DrGeoII-Test' with: 'DrGeoII-Test-HilaireFernandes.10']
]
