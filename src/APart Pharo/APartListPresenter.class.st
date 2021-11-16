Class {
	#name : #APartListPresenter,
	#superclass : #SpListPresenter,
	#traits : 'TAPartPresenter',
	#classTraits : 'TAPartPresenter classTrait',
	#category : #'APart Pharo'
}

{ #category : #accessing }
APartListPresenter >> defaultModel [
	self notYetImplemented
]

{ #category : #updating }
APartListPresenter >> setValueAdaptor: aspectObject aspect: anAspect parent: parentPresenter interface: toPart [

	|  selectionInList aValueAdaptor |
		
	aspectObject ifNil: [ ^ self ].
	aValueAdaptor := aspectObject subAdaptor.

	selectionInList := aValueAdaptor.

	selectionInList ifNil: [ ^ self ].
		
	self setupForListHolderAdaptor: selectionInList listHolder.
	self setupForSelectionIndexHolderAdaptor: selectionInList selectionIndexHolder.


  

]

{ #category : #updating }
APartListPresenter >> setupForListHolderAdaptor: listHolderAdaptor [	

	model whenChangedDo: [ 
		listHolderAdaptor setValue: model collection.
	].

	"initial update"
	model collection: (listHolderAdaptor value).
	
	"make me dependen directly on the List collection. When it will be changed, the message
	#update:with: will be invoked"
	listHolderAdaptor value addDependent: self.
	
	listHolderAdaptor addDependent: (APartUpdateConverter on: [ :aspect | 
		| list | 
		list := listHolderAdaptor valueUsingSubject: listHolderAdaptor subjectChannel value.
		model privateCollection: list.
		list addDependent: self.
		self updateList ]).
	listHolderAdaptor subjectChannel whenChangedDo: [ :aspect | 
		| list | 
		list := listHolderAdaptor valueUsingSubject: listHolderAdaptor subjectChannel value.
		model privateCollection: list.
		list addDependent: self.
		listHolderAdaptor subjectChannel value isClosing ifFalse: [ 
			self updateList ] ].
]

{ #category : #updating }
APartListPresenter >> setupForSelectionIndexHolderAdaptor: selectionIndexAdaptor [

	self selectionMode isMultipleSelection
		ifFalse: [ 
			self selectionMode whenChangedDo: [ :newSelection | 
				selectionIndexAdaptor
					setValueIn: selectionIndexAdaptor subjectChannel value
					to: newSelection selectedIndex ].
			selectionIndexAdaptor addDependent:
				(APartUpdateConverter on: [ :aspect | 
					 | aValue |
					 aValue := selectionIndexAdaptor valueUsingSubject:
						           selectionIndexAdaptor subjectChannel value.
					 selectionIndexAdaptor subjectChannel value isClosing ifFalse: [ 
						 self selection selectIndex: aValue ] ]).
			selectionIndexAdaptor subjectChannel whenChangedDo: [ :aspect | 
				| aValue |
				aValue := selectionIndexAdaptor valueUsingSubject:
					          selectionIndexAdaptor subjectChannel value.
				selectionIndexAdaptor subjectChannel value isClosing ifFalse: [ 
					self selection selectIndex: aValue ] ].

			"initial update"
			self selection selectIndex: selectionIndexAdaptor value.

			"set icons. We need to access the APartList indirectly using the selection
		because we do not have a direct way how to access it"
			selectionIndexAdaptor subject itemIconRepresentationBlock 
				ifNotNil: [ :anIconBlock | self displayIcon: anIconBlock ].
			selectionIndexAdaptor subject itemStringRepresentationBlock 
				ifNotNil: [ :aBlock | self display: aBlock ] ]
		ifTrue: [ 
			self selectionMode whenChangedDo: [ :newSelection | 
				selectionIndexAdaptor setValue: newSelection selectedIndexes ].
			selectionIndexAdaptor addDependent:
				(APartUpdateConverter on: [ :aspect | 
					 | aValue |
					 aValue := selectionIndexAdaptor valueUsingSubject:
						           selectionIndexAdaptor subjectChannel value.
					 selectionIndexAdaptor subjectChannel value isClosing ifFalse: [ 
						 self selection selectIndexes: aValue ] ]).
			selectionIndexAdaptor subjectChannel whenChangedDo: [ :aspect | 
				| aValue |
				aValue := selectionIndexAdaptor valueUsingSubject:
					          selectionIndexAdaptor subjectChannel value.
				selectionIndexAdaptor subjectChannel value isClosing ifFalse: [ 
					self selection selectIndexes: aValue ] ].

			"initial update"
			self selection selectIndexes: selectionIndexAdaptor value.

			"set icons. We need to access the APartList indirectly using the selection
		because we do not have a direct way how to access it"
			selectionIndexAdaptor subject itemIconRepresentationBlock 
				ifNotNil: [ :anIconBlock | self displayIcon: anIconBlock ].
			selectionIndexAdaptor subject itemStringRepresentationBlock 
				ifNotNil: [ :aBlock | self display: aBlock ] ]
]

{ #category : #updating }
APartListPresenter >> update: anAspect with: anObject [

"	anObject == self sequence
		ifTrue: [anAspect == #at: ifTrue: [^self updateAt: anArg].
				anAspect == #add ifTrue: [^self updateAdd: sequence size].
				anAspect == #insert: ifTrue: [^self updateInsert: anArg].
				anAspect == #replace: ifTrue: [^self updateReplace: anArg].
				anAspect == #remove: ifTrue: [^self updateRemove: anArg].
				anAspect == #removeFrom:to: ifTrue: [^self updateRemoveRange: anArg].
				anAspect == #insertCollection: ifTrue: [^self updateInsertCollection: anArg].
				anAspect == #appendCollection: ifTrue: [^self updateAppendCollection: anArg]].
"

	anAspect == #at: ifTrue: [ self updateList ].
	anAspect == #add ifTrue: [ self updateList ].
	anAspect == #insert: ifTrue: [ self updateList ].
	anAspect == #replace: ifTrue: [ self updateList ].
	anAspect == #remove: ifTrue: [ self updateList ].
	anAspect == #removeFrom:to: ifTrue: [ self updateList ].
	anAspect == #insertCollection: ifTrue: [ self updateList ].
	anAspect == #appendCollection: ifTrue: [ self updateList ].

]
