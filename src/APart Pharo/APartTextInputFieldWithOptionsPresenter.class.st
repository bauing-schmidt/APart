Class {
	#name : #APartTextInputFieldWithOptionsPresenter,
	#superclass : #APartTextInputFieldPresenter,
	#instVars : [
		'popover',
		'popoverPresenter',
		'completion',
		'gtkCompletion',
		'hideOnMatch'
	],
	#category : #'APart Pharo'
}

{ #category : #specs }
APartTextInputFieldWithOptionsPresenter class >> adapterName [

	^ #TextInputFieldWithOptionsAdapter
]

{ #category : #initialization }
APartTextInputFieldWithOptionsPresenter >> adapter: anAdapter [

	adapter ifNotNil: [
		gtkCompletion := nil. ].
	
	super adapter: anAdapter.
]

{ #category : #accessing }
APartTextInputFieldWithOptionsPresenter >> completion [

	^ completion
]

{ #category : #accessing }
APartTextInputFieldWithOptionsPresenter >> completion: anObject [

	completion := anObject
]

{ #category : #accessing }
APartTextInputFieldWithOptionsPresenter >> hideOnMatch [ 

	^ hideOnMatch
]

{ #category : #accessing }
APartTextInputFieldWithOptionsPresenter >> hideOnMatch: anObject [

	hideOnMatch := anObject
]

{ #category : #initialization }
APartTextInputFieldWithOptionsPresenter >> initialize [ 

	super initialize.
	hideOnMatch := true.
]

{ #category : #initialization }
APartTextInputFieldWithOptionsPresenter >> needRebuild: aBoolean [ 

	aBoolean ifTrue: [ 
		self setCompletionFor:  self adapter widget  options: OrderedCollection new.
		adapter widget entryCompletion: nil.
		gtkCompletion := nil ].
]

{ #category : #accessing }
APartTextInputFieldWithOptionsPresenter >> popover [

	^ popover
]

{ #category : #accessing }
APartTextInputFieldWithOptionsPresenter >> popover: anObject [

	popover := anObject
]

{ #category : #accessing }
APartTextInputFieldWithOptionsPresenter >> rawValueChanged: aString [

	| options |

	self adapter ifNil: [ ^ self ].
	
	completion ifNil: [
		^ self ].
		
	options := self owner client partInterface execute: completion with: aString ifDisabled: [ aString -> nil  ].
	
	(self hideOnMatch and: [ options size = 1 ]) ifTrue: [ 
		options := OrderedCollection new ].

	GtkRunLoop delayedDefer: [
		self setCompletionFor:  self adapter widget  options: options.
	]
]

{ #category : #accessing }
APartTextInputFieldWithOptionsPresenter >> setCompletionFor: aWidget options: strings [

	| store |
		
	store := GtkListStore newStrings: strings.
	gtkCompletion ifNil: [
		gtkCompletion := GtkEntryCompletion new ].

	adapter widget entryCompletion: gtkCompletion.

	gtkCompletion model: store.
	gtkCompletion textColumn: 0
]

{ #category : #accessing }
APartTextInputFieldWithOptionsPresenter >> setValueAdaptor: aspectObject aspect: anAspect parent: aPartentPresenter interface: toPart [

	super setValueAdaptor: aspectObject aspect: anAspect parent: aPartentPresenter interface: toPart.
	
	self whenBuiltDo: [ :ann | 
		self setCompletionFor: ann widget options: #() ]

]
