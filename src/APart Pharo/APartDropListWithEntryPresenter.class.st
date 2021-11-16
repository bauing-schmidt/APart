Class {
	#name : #APartDropListWithEntryPresenter,
	#superclass : #APartDropListPresenter,
	#instVars : [
		'#textSymbol',
		'#text => SpObservableSlot'
	],
	#category : #'APart Pharo'
}

{ #category : #specs }
APartDropListWithEntryPresenter class >> adapterName [

	^ #DropListWithEntryAdapter
]

{ #category : #specs }
APartDropListWithEntryPresenter class >> title [

	^ 'Drop List with entry'
]

{ #category : #initialization }
APartDropListWithEntryPresenter >> popup [ 

	self withWidgetDo: [ :w | w popup ]
]

{ #category : #initialization }
APartDropListWithEntryPresenter >> setValueAdaptor: aspectObject aspect: anAspect parent: parentPresenter interface: toPart [

	| selectionObject aValueAdaptor |
	
	aValueAdaptor := aspectObject subAdaptor.

	self assert: self id notNil.

	selectionObject := (parentPresenter bindingsManager 
		source: parentPresenter;
		listAt: self id) subAdaptor.

	(selectionObject isKindOf: APListSelection)
		ifTrue: [ 	
			self setupForContentAdaptor: selectionObject listHolder.
			self setupForSelectionIndexAdaptor: selectionObject selectionIndexHolder ]
		ifFalse: [ 	
			selectionObject := (parentPresenter bindingsManager 
				source: parentPresenter;
				listAt: self aspectSymbol) subAdaptor ].
	
	self whenBuiltDo: [ :annoucement |
			
		annoucement widget connectChanged: [ 	
			| textAspect anEntry |
			textAspect := 	(self owner bindingsManager 
				source: self owner)
				aspectAt: textSymbol.
			text := annoucement widget basicActiveText.
			textAspect value: text.
			annoucement widget popup. 
			annoucement widget setActive: -1.	
			anEntry := annoucement widget getEntry.
			annoucement widget getEntry selectFrom: 0 to: 1.
			GtkRunLoop delayedDefer: [ annoucement widget getEntry grabFocus ].

			]. 
		].			
	
				
		
]

{ #category : #accessing }
APartDropListWithEntryPresenter >> text [

	^ text
]

{ #category : #accessing }
APartDropListWithEntryPresenter >> text: anObject [

	^ text := anObject
]

{ #category : #accessing }
APartDropListWithEntryPresenter >> textSymbol [

	^ textSymbol
]

{ #category : #accessing }
APartDropListWithEntryPresenter >> textSymbol: anObject [

	textSymbol := anObject
]
