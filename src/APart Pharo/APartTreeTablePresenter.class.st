Class {
	#name : #APartTreeTablePresenter,
	#superclass : #SpTreeTablePresenter,
	#traits : 'TAPartPresenter',
	#classTraits : 'TAPartPresenter classTrait',
	#category : #'APart Pharo'
}

{ #category : #specs }
APartTreeTablePresenter class >> adapterName [

	^ #APartTreeTableAdapter
]

{ #category : #accessing }
APartTreeTablePresenter >> defaultModel [
	self notYetImplemented
]

{ #category : #initialization }
APartTreeTablePresenter >> setValueAdaptor: selectionInTree aspect: anAspect parent: parentPresenter interface: partInterface [ 

	| treeModel listHolder representationBlock iconRepresentationBlock compositeColumn |
	
	selectionInTree ifNil: [ ^ self ].
	selectionInTree subAdaptor ifNil: [ ^ self ].
	listHolder := selectionInTree subAdaptor subject listHolder.
	
	representationBlock := listHolder subject itemStringRepresentationBlock.
	representationBlock ifNil: [ representationBlock := [ :obj | obj asString ] ].
	
	iconRepresentationBlock := listHolder subject itemIconRepresentationBlock .	
	
	treeModel := listHolder value.

	treeModel showHeaders 
		ifFalse: [ self hideColumnHeaders ].

	
	treeModel columns ifEmpty: [ 
		"default columns"
		compositeColumn := SpCompositeTableColumn new title: 'item'.
		iconRepresentationBlock ifNotNil: [  
			compositeColumn addColumn: ((SpImageTableColumn title: 'icon' evaluated: iconRepresentationBlock) width: 28; beNotExpandable;yourself)
			].	
		compositeColumn addColumn: (SpStringTableColumn title: 'text' evaluated: representationBlock).
		self addColumn: compositeColumn. ]
		ifNotEmpty: [ 
			treeModel columns do: [ :aColumn |
				 self addColumn: aColumn asSpecColumn ]
			 ].
				
	self roots: treeModel root children.
	self children: [ :aNode | aNode children ].
		
	self setupForSelection: selectionInTree.
	
	treeModel whenChangedDo: [ :newSelection |self roots: self roots ].


		 
]

{ #category : #initialization }
APartTreeTablePresenter >> setupForSelection: selectionInTreeAspect [

	| selectionInTree |
	
	selectionInTree := selectionInTreeAspect subAdaptor.

	self selectionMode whenChangedDo: [ :newSelection |
		selectionInTree subject selectionIndex: newSelection  ].


	self selectionMode
		whenChangedDo: [ :newSelection | 
			selectionInTree setValue: newSelection  ].


 	self selectionMode
		whenChangedDo: [ :newSelection |										 
			selectionInTree
				setValueIn: selectionInTree subjectChannel value
					to: newSelection ].
			selectionInTree
				addDependent:
					(APartUpdateConverter
						on: [ :aspect | 
							| aValue |
							aValue := selectionInTree
								valueUsingSubject: selectionInTree subjectChannel value.
							self selectionMode isMultipleSelection 
								ifFalse: [self selection selectPath: selectionInTree subject selectionIndex]
								ifTrue: [	self selection selectPaths:selectionInTree subject selectionIndexes]
						"selectionInTree subjectChannel value isClosing ifFalse: [ 
							self selection selectIndex: aValue ]"]).
			"selectionInTree subjectChannel
				whenChangedDo: [ :aspect | 
					| aValue |
					aValue := selectionInTree
						valueUsingSubject: selectionInTree subjectChannel value.
					 selectionInTree subjectChannel value isClosing ifFalse: [ 
						self selection selectIndex: aValue ]]."

			"initial update"
			"self selection selectIndex: selectionInTree value."

			"set icons. We need to access the APartList indirectly using the selection
		because we do not have a direct way how to access it"
"			selectionInTree subject itemIconRepresentationBlock
				ifNotNil: [ :anIconBlock | self icons: anIconBlock ].
			selectionInTree subject itemStringRepresentationBlock
				ifNotNil: [ :aBlock | self display: aBlock ] "
				
				
			
	
]

{ #category : #initialization }
APartTreeTablePresenter >> setupForSelectionOld: selectionInTreeAspect [

	| selectionInTree |
	
	selectionInTree := selectionInTreeAspect subAdaptor.

	self selectionMode whenChangedDo: [ :newSelection |
		selectionInTree subject selectionIndex: newSelection  ].


 self selectionMode
				whenChangedDo:
					[ :newSelection | selectionInTree setValue: newSelection selectedIndexes ].

	self selectionMode isMultipleSelection
		ifFalse: [ self selectionMode
				whenChangedDo: [ :newSelection |
					 
					selectionInTree
						setValueIn: selectionInTree subjectChannel value
						to: newSelection selectedIndex ].
			selectionInTree
				addDependent:
					(APartUpdateConverter
						on: [ :aspect | 
							| aValue |
							aValue := selectionInTree
								valueUsingSubject: selectionInTree subjectChannel value.
						selectionInTree subjectChannel value isClosing ifFalse: [ 
							self selection selectIndex: aValue ]]).
			selectionInTree subjectChannel
				whenChangedDo: [ :aspect | 
					| aValue |
					aValue := selectionInTree
						valueUsingSubject: selectionInTree subjectChannel value.
					 selectionInTree subjectChannel value isClosing ifFalse: [ 
						self selection selectIndex: aValue ]].

			"initial update"
			self selection selectIndex: selectionInTree value.

			"set icons. We need to access the APartList indirectly using the selection
		because we do not have a direct way how to access it"
			selectionInTree subject itemIconRepresentationBlock
				ifNotNil: [ :anIconBlock | self icons: anIconBlock ].
			selectionInTree subject itemStringRepresentationBlock
				ifNotNil: [ :aBlock | self display: aBlock ] ]
		ifTrue: [ self selectionMode
				whenChangedDo:
					[ :newSelection | selectionInTree setValue: newSelection selectedIndexes ].
			selectionInTree
				addDependent:
					(APartUpdateConverter
						on: [ :aspect | 
							| aValue |
							aValue := selectionInTree
								valueUsingSubject: selectionInTree subjectChannel value.
							selectionInTree subjectChannel value isClosing ifFalse: [
								self selection selectIndexes: aValue ] ]).
			selectionInTree subjectChannel
				whenChangedDo: [ :aspect | 
					| aValue |
					aValue := selectionInTree
						valueUsingSubject: selectionInTree subjectChannel value.
					selectionInTree subjectChannel value isClosing ifFalse: [ 
						self selection selectIndexes: aValue ] ].

			"initial update"
			self selection selectIndexes: selectionInTree value.

			"set icons. We need to access the APartList indirectly using the selection
		because we do not have a direct way how to access it"
			selectionInTree subject itemIconRepresentationBlock
				ifNotNil: [ :anIconBlock | self icons: anIconBlock ].
			selectionInTree subject itemStringRepresentationBlock
				ifNotNil: [ :aBlock | self displayBlock: aBlock ] ]
]
