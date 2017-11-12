"
A DrGDirectoryLocal is facade to local resources on the host.
"
Class {
	#name : #DrGDirectoryLocal,
	#superclass : #DrGDirectory,
	#category : #DrGeoII-Core-Resources
}

{ #category : #accessing }
DrGDirectoryLocal >> deleteFile: thisFilename [
	(directory asFileReference / thisFilename) delete
]

{ #category : #testing }
DrGDirectoryLocal >> fileExists: aFilename [
	^ (directory asFileReference / aFilename) exists
]

{ #category : #helpers }
DrGDirectoryLocal >> fullname: aFilename [ 
	^ (directory asFileReference / aFilename) pathString 
]

{ #category : #accessing }
DrGDirectoryLocal >> getDirectoryList [
	^ directory asFileReference directoryNames
]

{ #category : #accessing }
DrGDirectoryLocal >> getFile: filename [
	^ FileStream readOnlyFileNamed: (self fullname: filename)
]

{ #category : #accessing }
DrGDirectoryLocal >> getFileList [
	^ directory asFileReference fileNames
]

{ #category : #accessing }
DrGDirectoryLocal >> getTextFile: filename [
	^ self getFile: filename
]

{ #category : #testing }
DrGDirectoryLocal >> isLocal [
	^ true
]

{ #category : #protocol }
DrGDirectoryLocal >> pathNameDelimiter [
	^ FileSystem disk delimiter
]

{ #category : #accessing }
DrGDirectoryLocal >> put: stream into: filename [
	|streamOnDisk|
	[streamOnDisk := MultiByteFileStream forceNewFileNamed: (self fullname: filename).
	streamOnDisk nextPutAll: stream contents] ensure: 
		[streamOnDisk close]
]
