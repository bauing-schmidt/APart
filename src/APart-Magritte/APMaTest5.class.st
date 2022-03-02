Class {
	#name : #APMaTest5,
	#superclass : #APartWithForm,
	#instVars : [
		'toOne'
	],
	#category : #'Apart-Magritte'
}

{ #category : #accessing }
APMaTest5 >> defineAspects [

	<generated>
	^ partInterface description createAllAspectsNamed: #( toOne )
]

{ #category : #accessing }
APMaTest5 >> initializeDefaultValues [

	<generated>
	toOne := APartList onPart: self key: #toOne
]

{ #category : #accessing }
APMaTest5 >> initializeValues [

	<generated>
	self initializeDefaultValues
]

{ #category : #accessing }
APMaTest5 >> toOne [

	<generated>
	^ toOne
]

{ #category : #accessing }
APMaTest5 >> toOne: anObject [

	<generated>
	toOne := anObject
]

{ #category : #'magritte descriptions' }
APMaTest5 >> toOneDescription [

	<magritteDescription>
	<generated>
	^ MAToOneRelationDescription new
		  aspect: (MAAspectAccessor aspectName: #toOne);
		  accessor: (MANullAccessor uuid:
					   #( 49 38 61 152 144 193 239 120 138 139 146 127 129 139 16 148 ));
		  label: 'toOne';
		  presenterClass: MASpInternalEditorPresenter;
		  yourself
]
