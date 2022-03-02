Class {
	#name : #ApedGeneratedPresenter,
	#superclass : #SpPresenter,
	#category : #'APart Form Editor-Support'
}

{ #category : #'as yet unclassified' }
ApedGeneratedPresenter class >> defaultLayout [

	^ SpBoxLayout newVertical
		  spacing: 0;
		  borderWidth: 0;
		  homogeneous: false;
		  add: (SpGridLayout new
				   borderWidth: 20;
				   columnSpacing: 10;
				   rowSpacing: 5;
				   columnHomogeneous: true;
				   rowHomogeneous: true;
				   add:
					   ((SpFrameLayout newLabel: 'Frame') add:
							    (SpBoxLayout newVertical
								     spacing: 0;
								     borderWidth: 0;
								     homogeneous: false;
								     add: (SpGridLayout new
										      borderWidth: 10;
										      columnSpacing: 10;
										      rowSpacing: 6;
										      columnHomogeneous: true;
										      rowHomogeneous: false;
										      add: #label7 at: 1 @ 1 span: 1 @ 1;
										      add: #numberInputField1 at: 2 @ 1 span: 2 @ 1;
										      add: #label8 at: 1 @ 2 span: 1 @ 1;
										      add: #numberInputField6 at: 2 @ 2 span: 2 @ 1;
										      add: #label4 at: 1 @ 3 span: 1 @ 1;
										      add: #dropList2 at: 2 @ 3 span: 2 @ 1;
										      yourself)
								     expand: true fill: true;
								     yourself) yourself)
				   at: 1 @ 1
				   span: 1 @ 1;
				   add:
					   ((SpFrameLayout newLabel: 'Frame') add:
						    (SpBoxLayout newVertical
							     spacing: 0;
							     borderWidth: 0;
							     homogeneous: false;
							     add: (SpGridLayout new
									      borderWidth: 10;
									      columnSpacing: 10;
									      rowSpacing: 6;
									      columnHomogeneous: true;
									      rowHomogeneous: false;
									      add: #label5 at: 1 @ 1 span: 1 @ 1;
									      add: #numberInputField5 at: 2 @ 1 span: 3 @ 1;
									      add: #label6 at: 1 @ 2 span: 1 @ 1;
									      add: #numberInputField4 at: 2 @ 2 span: 3 @ 1;
									      yourself)
							     expand: true fill: true;
							     add: (SpBoxLayout newHorizontal
									      spacing: 13;
									      borderWidth: 0;
									      homogeneous: true;
									      add: #button1 expand: false fill: false;
									      add: #button2 expand: false fill: false;
									      yourself)
							     expand: true fill: false;
							     yourself) yourself)
				   at: 2 @ 1
				   span: 1 @ 1;
				   add:
					   ((SpFrameLayout newLabel: 'Frame') add:
						    (SpBoxLayout newVertical
							     spacing: 0;
							     borderWidth: 0;
							     homogeneous: false;
							     add: (SpGridLayout new
									      borderWidth: 9;
									      columnSpacing: 10;
									      rowSpacing: 6;
									      columnHomogeneous: true;
									      rowHomogeneous: true;
									      add: #label7 at: 1 @ 1 span: 1 @ 1;
									      add: #numberInputField1 at: 2 @ 1 span: 3 @ 1;
									      add: #label8 at: 1 @ 2 span: 1 @ 1;
									      add: #numberInputField6 at: 2 @ 2 span: 3 @ 1;
									      yourself)
							     expand: false fill: false;
							     add: (SpBoxLayout newHorizontal
									      spacing: 0;
									      borderWidth: 0;
									      homogeneous: false;
									      add: #treeTable4 expand: true fill: true;
									      yourself)
							     expand: true fill: true;
							     yourself) yourself)
				   at: 1 @ 2
				   span: 2 @ 1;
				   yourself)
		  expand: true fill: true;
		  yourself
]

{ #category : #'as yet unclassified' }
ApedGeneratedPresenter class >> openInGtk [ 

	<script>
	| app p |
	app := SpApplication new useBackend: #Gtk.
	p := self newApplication: app.
	p open.
]

{ #category : #'as yet unclassified' }
ApedGeneratedPresenter >> initializeFormPresenters [

	self additionalSubpresentersMap at: #label7 put: (self newLabel
			 label: 'value X:';
			 enabled: true;
			 help: nil;
			 yourself).
	self additionalSubpresentersMap
		at: #numberInputField1
		put: (self newNumberInput
				 minimum: 0;
				 maximum: 100;
				 climbRate: 1;
				 digits: 2;
				 yourself).
	self additionalSubpresentersMap at: #label8 put: (self newLabel
			 label: 'value Y:';
			 enabled: true;
			 help: nil;
			 yourself).
	self additionalSubpresentersMap
		at: #numberInputField6
		put: (self newNumberInput
				 minimum: 0;
				 maximum: 100;
				 climbRate: 1;
				 digits: 2;
				 yourself).
	self additionalSubpresentersMap at: #label5 put: (self newLabel
			 label: 'width:';
			 enabled: true;
			 help: nil;
			 yourself).
	self additionalSubpresentersMap
		at: #numberInputField5
		put: (self newNumberInput
				 minimum: 0;
				 maximum: 100;
				 climbRate: 1;
				 digits: 2;
				 yourself).
	self additionalSubpresentersMap at: #label6 put: (self newLabel
			 label: 'height:';
			 enabled: true;
			 help: nil;
			 yourself).
	self additionalSubpresentersMap
		at: #numberInputField4
		put: (self newNumberInput
				 minimum: 0;
				 maximum: 100;
				 climbRate: 1;
				 digits: 2;
				 yourself).
	self additionalSubpresentersMap
		at: #treeTable1
		put: (self newTreeTable
				 enabled: true;
				 help: nil;
				 yourself).
	self additionalSubpresentersMap
		at: #treeTable2
		put: (self newTreeTable
				 enabled: true;
				 help: nil;
				 yourself).
	self additionalSubpresentersMap
		at: #treeTable3
		put: (self newTreeTable
				 enabled: true;
				 help: nil;
				 yourself).
	self additionalSubpresentersMap
		at: #treeTable4
		put: (self newTreeTable
				 enabled: true;
				 help: nil;
				 yourself).
	self additionalSubpresentersMap at: #label4 put: (self newLabel
			 label: 'type:';
			 enabled: true;
			 help: nil;
			 yourself).
	self additionalSubpresentersMap
		at: #dropList1
		put: (self newDropList
				 enabled: true;
				 help: nil;
				 yourself).
	self additionalSubpresentersMap
		at: #dropList2
		put: (self newDropList
				 enabled: true;
				 help: nil;
				 yourself).
	self additionalSubpresentersMap at: #button1 put: (self newButton
			 label: 'button1';
			 enabled: true;
			 help: nil;
			 yourself).
	self additionalSubpresentersMap at: #button2 put: (self newButton
			 label: 'button2';
			 enabled: true;
			 help: nil;
			 yourself)
]

{ #category : #initialization }
ApedGeneratedPresenter >> initializePresenters [ 

	self initializeFormPresenters
]

{ #category : #accessing }
ApedGeneratedPresenter >> presenterAt: aName [

	^ self additionalSubpresentersMap at: aName ifAbsent: [ super presenterAt: aName ]
]
