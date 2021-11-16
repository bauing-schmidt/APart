"
I am a description of a tree table presenter
"
Class {
	#name : #ApedTreeTablePresenterPart,
	#superclass : #ApedWidgetPresenterPart,
	#category : #'APart Form Editor-Element Parts'
}

{ #category : #accessing }
ApedTreeTablePresenterPart class >> iconName [

	^ #ttreeview
]

{ #category : #accessing }
ApedTreeTablePresenterPart class >> label [ 

	^ 'Tree table'
]

{ #category : #preview }
ApedTreeTablePresenterPart >> newPreviewPresenterOn: aPresenter [

	^ aPresenter newTreeTable
]

{ #category : #preview }
ApedTreeTablePresenterPart >> setupPreviewPresenter: aPresenter [

	super setupPreviewPresenter: aPresenter.
		
		self exampleContent ifTrue: [ aPresenter 
			addColumn: (SpCompositeTableColumn new
			title: 'Classes';
			addColumn: ((SpImageTableColumn evaluated: #systemIcon)
				width: 20;
				yourself);
			addColumn: (SpStringTableColumn evaluated: #name);
			yourself);
		addColumn: (SpStringTableColumn 
			title: 'Number of subclasses' 
			evaluated: [ :class | class subclasses size asString ]);
		addColumn: (SpStringTableColumn 
			title: 'Number of methods' 
			evaluated: [ :class | class methods size asString ]);
		roots: {Object};
		children: [ :aClass | aClass subclasses ];
		beResizable;	
		activateOnDoubleClick;
		whenActivatedDo: [ :selection | selection selectedItem browse ]		
			]
			
]
