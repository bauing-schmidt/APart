"
A form preview in standalone window
"
Class {
	#name : #ApedFormPreviewWindowPart,
	#superclass : #APart,
	#traits : 'APTRootPart + APTPartWithLocale',
	#classTraits : 'APTRootPart classTrait + APTPartWithLocale classTrait',
	#instVars : [
		'formPart',
		'preview',
		'previewSwitchingPart'
	],
	#category : #'APart Form Editor-Preview'
}

{ #category : #accessing }
ApedFormPreviewWindowPart >> defineAspects [

	partInterface description createAspectNamed: #preview.
]

{ #category : #accessing }
ApedFormPreviewWindowPart >> formPart [

	^ formPart
]

{ #category : #accessing }
ApedFormPreviewWindowPart >> formPart: anObject [

	formPart := anObject
]

{ #category : #accessing }
ApedFormPreviewWindowPart >> initializeValues [

	preview := ApedFormPreviewPart onPart: self key: #preview.
	previewSwitchingPart := APSwitchingPart onPart: self key: #previewSwitchingPart.
	previewSwitchingPart releaseInactivePart: false.
	previewSwitchingPart addSubPart: preview key: #current.
	previewSwitchingPart privCurrentPartKey: #current.
	
]

{ #category : #accessing }
ApedFormPreviewWindowPart >> preview [ 

	^ preview
]

{ #category : #accessing }
ApedFormPreviewWindowPart >> updatePreview [ 

	self partInterface ifNil: [ 
		"window is closed"
		^ self ].
	
	self parentPart loadedFile ifNotNil: [
		self sendNotification: #changeWindowTitle with: 'Preview - ' , self parentPart loadedFile asFileReference basename].

	self removeSubPartForKey: #preview.
	preview := ApedFormPreviewPart onPart: self key: #preview.
	previewSwitchingPart forceSwitchToPart: preview.
]
