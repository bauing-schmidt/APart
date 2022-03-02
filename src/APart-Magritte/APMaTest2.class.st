Class {
	#name : #APMaTest2,
	#superclass : #APartWithForm,
	#instVars : [
		'name'
	],
	#category : #'Apart-Magritte'
}

{ #category : #accessing }
APMaTest2 >> defineAspects [

	<generated>
	^ partInterface description createAllAspectsNamed: #( name )
]

{ #category : #accessing }
APMaTest2 >> initializeDefaultValues [

	<generated>
	
]

{ #category : #accessing }
APMaTest2 >> initializeValues [

	<generated>
	self initializeDefaultValues
]

{ #category : #accessing }
APMaTest2 >> name [

	<generated>
	^ name
]

{ #category : #accessing }
APMaTest2 >> name: anObject [

	<generated>
	name := anObject
]

{ #category : #'magritte descriptions' }
APMaTest2 >> nameDescription [

	<magritteDescription>
	<generated>
	^ MAStringDescription new
		  accessor: (MANullAccessor uuid:
					   #( 157 97 167 119 52 73 4 217 149 133 195 205 0 148 228 57 ));
		  aspect: (MAAspectAccessor aspectName: #name);
		  label: 'Name';
		  undefined: 'something';
		  placeholder: 'placeholder';
		  yourself
]
