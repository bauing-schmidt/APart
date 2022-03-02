Class {
	#name : #APMaTest4,
	#superclass : #APartWithForm,
	#instVars : [
		'toOne'
	],
	#category : #'Apart-Magritte'
}

{ #category : #accessing }
APMaTest4 >> defineAspects [

	<generated>
	^ partInterface description createAllAspectsNamed: #( toOne )
]

{ #category : #accessing }
APMaTest4 >> initializeDefaultValues [

	<generated>
	toOne := APartList onPart: self key: #toOne
]

{ #category : #accessing }
APMaTest4 >> initializeValues [

	<generated>
	self initializeDefaultValues
]

{ #category : #accessing }
APMaTest4 >> toOne [

	<generated>
	^ toOne
]

{ #category : #accessing }
APMaTest4 >> toOne: anObject [

	<generated>
	toOne := anObject
]

{ #category : #'magritte descriptions' }
APMaTest4 >> toOneDescription [

	<magritteDescription>
	<generated>
	^ MAToOneRelationDescription new
		  aspect: (MAAspectAccessor aspectName: #toOne);
		  accessor: (MANullAccessor uuid:
					   #( 49 38 61 152 144 193 239 120 138 139 146 127 129 139 16 148 ));
		  label: 'toOne';
		  classes: (OrderedCollection new
				   add: AColorSelectorMorph;
				   add: APAbstractLayoutDecorator;
				   add: APAbstractValueConfigCreator;
				   add: APActionRedefinitionError;
				   add: APMaTest3;
				   yourself);
		  presenterClass: MASpInternalEditorPresenter;
		  yourself
]
